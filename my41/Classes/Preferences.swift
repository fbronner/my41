//
//  Preferences.swift
//  my41
//
//  Created by Miroslav Perovic on 10/17/14.
//  Copyright (c) 2014 iPera. All rights reserved.
//

import Foundation
import Cocoa
import AppKit

final class PreferencesWindowController: NSWindowController {

}

final class PreferencesContainerViewController: NSViewController {
    var preferencesCalculatorViewController: PreferencesCalculatorViewController?
    var preferencesModsViewController: PreferencesModsViewController?

    var newMod1: String?
    var newMod2: String?
    var newMod3: String?
    var newMod4: String?

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case PreferencesCalculatorViewController.segueId:
            preferencesCalculatorViewController = segue.destinationController as? PreferencesCalculatorViewController
            preferencesCalculatorViewController?.preferencesContainerViewController = self
        case PreferencesModsViewController.segueId:
            preferencesModsViewController = segue.destinationController as? PreferencesModsViewController
            preferencesModsViewController?.preferencesContainerViewController = self
        default:
            break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let mod = UserDefaults.standard.string(forKey: HPPort1) {
            newMod1 = mod
        }
        if let mod = UserDefaults.standard.string(forKey: HPPort2) {
            newMod2 = mod
        }
        if let mod = UserDefaults.standard.string(forKey: HPPort3) {
            newMod3 = mod
        }
        if let mod = UserDefaults.standard.string(forKey: HPPort4) {
            newMod4 = mod
        }

        loadPreferencesCalculatorViewController()
    }

    func loadPreferencesCalculatorViewController() {
        performSegue(withIdentifier: PreferencesCalculatorViewController.segueId, sender: self)
    }

    func loadPreferencesModsViewController() {
        performSegue(withIdentifier: PreferencesModsViewController.segueId, sender: self)
    }


    func applyChanges() {
        // First check calclulator type
        var needsRestart = false

        let cType = UserDefaults.standard.integer(forKey: HPCalculatorType)
        let currentCalculatorType = preferencesCalculatorViewController?.calculatorType?.rawValue
        if cType != currentCalculatorType {
            UserDefaults.standard.set(currentCalculatorType!, forKey: HPCalculatorType)
            needsRestart = true
        }

        if let path = preferencesModsViewController?.expansionModule1.filePath {
            needsRestart = needsRestart || applyPortChange(key: HPPort1, path: path)
        }
        if let path = preferencesModsViewController?.expansionModule2.filePath {
            needsRestart = needsRestart || applyPortChange(key: HPPort2, path: path)
        }
        if let path = preferencesModsViewController?.expansionModule3.filePath {
            needsRestart = needsRestart || applyPortChange(key: HPPort3, path: path)
        }
        if let path = preferencesModsViewController?.expansionModule4.filePath {
            needsRestart = needsRestart || applyPortChange(key: HPPort4, path: path)
        }

        if needsRestart {
            CalculatorController.sharedInstance.resetCalculator(restoringMemory: true)
        }
    }

    private func applyPortChange(key: String, path: String) -> Bool {
        if let fPath = preferencesModsViewController?.expansionModule1.filePath {
            // We have something in a port
            let moduleName = (fPath as NSString).lastPathComponent
            if let dModuleName = UserDefaults.standard.string(forKey: key) {
                // And we had something in Port1 at the begining
                if moduleName != dModuleName {
                    // This is different module
                    UserDefaults.standard.set((fPath as NSString).lastPathComponent, forKey: key)
                    return true
                }
            } else {
                // Port1 was empty
                UserDefaults.standard.set((fPath as NSString).lastPathComponent, forKey: key)
                return true
            }
        } else {
            // Port1 is empty now
            if UserDefaults.standard.string(forKey: key) != nil {
                // But we had something in Port1
                UserDefaults.standard.removeObject(forKey: key)
            }
        }

        return false
    }

}

final class PreferencesViewController: NSViewController {

    @IBOutlet weak var modTitle: NSTextField!
    @IBOutlet weak var modAuthor: NSTextField!
    @IBOutlet weak var modVersion: NSTextField!
    @IBOutlet weak var modCopyright: NSTextField!
    @IBOutlet weak var modCategory: NSTextField!
    @IBOutlet weak var modHardware: NSTextField!
    @IBOutlet weak var expansionModule1: ExpansionView!
    @IBOutlet weak var expansionModule2: ExpansionView!
    @IBOutlet weak var expansionModule3: ExpansionView!
    @IBOutlet weak var expansionModule4: ExpansionView!
    @IBOutlet weak var comments: NSTextField!
    @IBOutlet weak var bottomView: NSView!

    @IBOutlet weak var removeModule1: NSButton!
    @IBOutlet weak var removeModule2: NSButton!
    @IBOutlet weak var removeModule3: NSButton!
    @IBOutlet weak var removeModule4: NSButton!

    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var calculatorSelectorView: NSView!
    @IBOutlet weak var modSelectorView: NSView!
    @IBOutlet weak var modDetailsView: ModDetailsView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = ""
        comments.stringValue = ""

        // Draw border on splitView
        bottomView.layer = CALayer()
        bottomView.layer?.borderWidth = 1.0
        bottomView.wantsLayer = true
    }
}


// MARK: - SpitView

final class PreferencesSplitViewController: NSSplitViewController {

    override func viewWillAppear() {
        super.viewWillAppear()

        let menuVC = splitViewItems[0].viewController as! PreferencesMenuViewController
        let containerVC = splitViewItems[1].viewController as! PreferencesContainerViewController
        menuVC.preferencesContainerViewController = containerVC

        view.addConstraint(
            NSLayoutConstraint(
                item: splitViewItems[0].viewController.view,
                attribute: NSLayoutConstraint.Attribute.width,
                relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: nil,
                attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                multiplier: 0,
                constant: 194
            )
        )
        view.addConstraint(
            NSLayoutConstraint(
                item: splitViewItems[0].viewController.view,
                attribute: NSLayoutConstraint.Attribute.height,
                relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: nil,
                attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                multiplier: 0,
                constant: 587
            )
        )
        view.addConstraint(
            NSLayoutConstraint(
                item: splitViewItems[1].viewController.view,
                attribute: NSLayoutConstraint.Attribute.width,
                relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: nil,
                attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                multiplier: 0,
                constant: 528
            )
        )
        view.addConstraint(
            NSLayoutConstraint(
                item: splitViewItems[1].viewController.view,
                attribute: NSLayoutConstraint.Attribute.height,
                relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: nil,
                attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                multiplier: 0,
                constant: 587
            )
        )
    }
    
}


//MARK: -

final class PreferencesSegue: NSStoryboardSegue {

    override func perform() {
        let source = sourceController as! NSViewController
        let destination = destinationController as! NSViewController

        if source.view.subviews.count > 0 {
            let aView: AnyObject = source.view.subviews[0]
            if aView is NSView {
                aView.removeFromSuperview()
            }
        }

        let dView = destination.view
        source.view.addSubview(dView)
        source.view.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[dView]|",
                options: [],
                metrics: nil,
                views: ["dView": dView]
            )
        )
        source.view.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[dView]|",
                options: [],
                metrics: nil,
                views: ["dView": dView]
            )
        )
    }

}
