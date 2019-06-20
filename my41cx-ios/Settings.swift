//
//  Settings.swift
//  my41
//
//  Created by Miroslav Perovic on 3/20/15.
//  Copyright (c) 2015 iPera. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController, UIAlertViewDelegate {
	@IBOutlet weak var sound: UISwitch!
	@IBOutlet weak var syncClock: UISwitch!
	@IBOutlet weak var calculator: UISegmentedControl!
	
	@IBOutlet weak var expansionModule1: MODsView?
	@IBOutlet weak var expansionModule2: MODsView?
	@IBOutlet weak var expansionModule3: MODsView?
	@IBOutlet weak var expansionModule4: MODsView?
	
	var yRatio: CGFloat = 1.0

	override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

		calculator.selectedSegmentIndex = CalculatorType.getDefault().asIndex()

		sound.isOn = SOUND
		yRatio = view.bounds.size.height / 800.0
	}
	
	@IBAction func clearMemory(_ sender: AnyObject) {
		let alertController = UIAlertController(
			title: "Reset Calculator",
			message: "This operation will clear all programs and memory registers",
			preferredStyle: .alert
		)

		let destructiveAction = UIAlertAction(title: "Continue", style: .destructive) { (result : UIAlertAction) -> Void in
			CalculatorController.sharedInstance.resetCalculator(restoringMemory: false)
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (result : UIAlertAction) -> Void in
			print("Cancel clear memory")
		}
		alertController.addAction(cancelAction)
		alertController.addAction(destructiveAction)
		present(alertController, animated: true, completion: nil)
	}
	
	@IBAction func applyChanges(_ sender: AnyObject) {
		var needsRestart = false
        var restoringMemory = true

		let defaults = UserDefaults.standard
		
		// Sound settings
		if sound.isOn {
			SOUND = true
		} else {
			SOUND = false
		}
		defaults.set(SOUND, forKey: "sound")
		
		// Calculator timer
		if syncClock.isOn {
			SYNCHRONYZE = true
		} else {
			SYNCHRONYZE = false
		}
		defaults.set(SYNCHRONYZE, forKey: "synchronyzeTime")

        // Calculator type
        let currentCalculatorType = calculator.selectedSegmentIndex
        if CalculatorType.getDefault().asIndex() != currentCalculatorType {
            restoringMemory = false
            needsRestart = true
            CalculatorType(index: currentCalculatorType).setDefault()
        }

		// Modules
        if let path = expansionModule1?.filePath {
            needsRestart = needsRestart || applyPortChange(key: HPPort1, path: path)
        }
        if let path = expansionModule2?.filePath {
            needsRestart = needsRestart || applyPortChange(key: HPPort2, path: path)
        }
        if let path = expansionModule3?.filePath {
            needsRestart = needsRestart || applyPortChange(key: HPPort3, path: path)
        }
        if let path = expansionModule4?.filePath {
            needsRestart = needsRestart || applyPortChange(key: HPPort4, path: path)
        }

        if needsRestart {
            NotificationCenter.default.post(name: .calculatorTypeChanged, object: nil)
            CalculatorController.sharedInstance.resetCalculator(restoringMemory: restoringMemory)
        }
	}

    private func applyPortChange(key: String, path: String) -> Bool {
        // We have something in a port
        let newModule = (path as NSString).lastPathComponent
        let oldModule = UserDefaults.standard.string(forKey: key)
        if oldModule == nil || newModule != oldModule {
            // This is different module
            UserDefaults.standard.set(newModule, forKey: key)
            return true
        }

        return false
    }

}

class MODsView: UIView, UIAlertViewDelegate {
	var modDetails: ModuleHeader?
	var category: String?
	var hardware: String?
	var filePath: String?
	var oldFilePath: String?
	var port: Int = 0
	var button: UIButton

	var modFiles = [String]()
	var allModFiles = [String]()
	var modFileHeaders: [String: ModuleHeader]?

	@IBOutlet weak var settingsViewController: SettingsViewController?
	
	override func awakeFromNib() {
		allModFiles = modFilesInBundle()

		let defaults = UserDefaults.standard
		switch port {
		case 1:
			if let module1 = defaults.string(forKey: HPPort1) {
				filePath = Bundle.main.resourcePath! + "/" + module1
			}
			
		case 2:
			if let module2 = defaults.string(forKey: HPPort2) {
				filePath = Bundle.main.resourcePath! + "/" + module2
			}
			
		case 3:
			if let module3 = defaults.string(forKey: HPPort3) {
				filePath = Bundle.main.resourcePath! + "/" + module3
			}
			
		case 4:
			if let module4 = defaults.string(forKey: HPPort4) {
				filePath = Bundle.main.resourcePath! + "/" + module4
			}
			
		default:
			break
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		button = UIButton()
		super.init(coder: aDecoder)

		layer.cornerRadius = 5.0
		button.frame = bounds
		button.backgroundColor = UIColor.clear
		button.addTarget(
			self,
			action: #selector(MODsView.buttonAction(_:)),
			for: UIControl.Event.touchUpInside
		)
		addSubview(button)
	}
	
	@objc func buttonAction(_ sender: AnyObject) {
		if filePath != nil {
			let alertController = UIAlertController(
				title: "Reset Calculator",
				message: "What do you want to do with module",
				preferredStyle: .alert
			)

			let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (result : UIAlertAction) -> Void in
                if let oldFilePath = self.oldFilePath {
                    self.filePath = oldFilePath
					self.oldFilePath = nil
				}
			}
			let emptyAction = UIAlertAction(title: "Empty port", style: .default) { (result : UIAlertAction) -> Void in
                self.filePath = nil
				self.setNeedsDisplay()
			}
			let replaceAction = UIAlertAction(title: "Replace module", style: .default) { (result : UIAlertAction) -> Void in
                self.oldFilePath = self.filePath
				self.filePath = nil
				self.selectModule()
			}
			alertController.addAction(cancelAction)
			alertController.addAction(emptyAction)
			alertController.addAction(replaceAction)
			settingsViewController?.present(alertController, animated: true, completion: nil)
		} else {
			selectModule()
		}
	}
	
	func selectModule() {
		let alertController = UIAlertController(
			title: "Port \(port)",
			message: "Choose module",
			preferredStyle: .alert
		)

		reloadModFiles()
		for (_, element) in modFiles.enumerated() {
			let modAction = UIAlertAction(title: (element as NSString).lastPathComponent, style: .default) { (result : UIAlertAction) -> Void in
				self.filePath = element
				self.oldFilePath = nil
				self.setNeedsDisplay()
			}
			alertController.addAction(modAction)
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (result : UIAlertAction) -> Void in
			if let oldFilePath = self.oldFilePath {
				self.filePath = oldFilePath
				self.oldFilePath = nil
			}
		}
		alertController.addAction(cancelAction)
		settingsViewController?.present(alertController, animated: true, completion: nil)
	}

	override func draw(_ rect: CGRect) {
		let backColor = UIColor(
			red: 0.1569,
			green: 0.6157,
			blue: 0.8902,
			alpha: 0.95
		)
		let rect = CGRect(
			x: bounds.origin.x + 3,
			y: bounds.origin.y + 3,
			width: bounds.size.width - 6,
			height: bounds.size.height - 6
		)
		
		let path = UIBezierPath(
			roundedRect: rect,
			cornerRadius: 5.0
		)
		path.addClip()
		
		backColor.setFill()
		path.fill()
		
		let font = UIFont.systemFont(ofSize: 15.0 * (settingsViewController?.yRatio)!)
		let textStyle: NSMutableParagraphStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
		textStyle.alignment = NSTextAlignment.center
		let attributes = [
			convertFromNSAttributedStringKey(NSAttributedString.Key.font) : font,
			convertFromNSAttributedStringKey(NSAttributedString.Key.paragraphStyle): textStyle
		]
		if let fPath = filePath {
			let mod = MOD()
			do {
				try mod.readModFromFile(fPath)
				mod.moduleHeader.title.draw(
					in: CGRect(x: 10.0, y: 10.0, width: bounds.size.width - 20.0, height: bounds.size.height - 20.0),
					withAttributes: convertToOptionalNSAttributedStringKeyDictionary(attributes)
				)
			} catch {
				
			}
		} else {
			let title = "Empty module"
			title.draw(
				in: CGRect(x: 10.0, y: 10.0, width: bounds.size.width - 20.0, height: bounds.size.height - 20.0),
				withAttributes: convertToOptionalNSAttributedStringKeyDictionary(attributes)
			)

		}
	}
	
	//MARK: - Private methods
	
	func reloadModFiles() {
		modFiles = allModFiles
		removeLoadedModules()
	}
	
	func modFilesInBundle() -> [String] {
		var realModFiles: [String] = [String]()
		let modFiles = Bundle.main.paths(forResourcesOfType: "mod", inDirectory: nil)
		for modFile in modFiles {
			if (modFile as NSString).lastPathComponent != "nut-c.mod" && (modFile as NSString).lastPathComponent != "nut-cv.mod" && (modFile as NSString).lastPathComponent != "nut-cx.mod" {
				realModFiles.append(modFile)
			}
		}

		return realModFiles
	}
	
	func removeLoadedModules() {
		let defaults = UserDefaults.standard
		if (defaults.string(forKey: HPPort1) != nil) {
			if let path = settingsViewController?.expansionModule1?.filePath {
				removeModFile(path)
			}
		}
		if (defaults.string(forKey: HPPort2) != nil) {
			if let path = settingsViewController?.expansionModule2?.filePath {
				removeModFile(path)
			}
		}
		if (defaults.string(forKey: HPPort3) != nil) {
			if let path = settingsViewController?.expansionModule3?.filePath {
				removeModFile(path)
			}
		}
		if (defaults.string(forKey: HPPort4) != nil) {
			if let path = settingsViewController?.expansionModule4?.filePath {
				removeModFile(path)
			}
		}
	}
	
	func removeModFile(_ filename: String) {
		var index = 0
		for aFileName in modFiles {
			if filename == aFileName {
				modFiles.remove(at: index)
				
				break
			}
			index += 1
		}
	}
}

final class MODDetailsView: UIView {
	var modDetails: ModuleHeader?
	var category: String?
	var hardware: String?
	
	override func draw(_ rect: CGRect) {
		let backColor = UIColor(
			red: 0.99,
			green: 0.99,
			blue: 0.99,
			alpha: 0.95
		)
		let rect = CGRect(
			x: bounds.origin.x + 3.0,
			y: bounds.origin.y + 3.0,
			width: bounds.size.width - 6.0,
			height: bounds.size.height - 6.0
		)
		let path = UIBezierPath(
			roundedRect: rect,
			cornerRadius: 5.0
		)
		path.addClip()
		backColor.setFill()
		path.fill()
	}
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
