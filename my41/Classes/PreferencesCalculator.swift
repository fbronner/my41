//
//  PreferencesCalculator.swift
//  my41
//
//  Created by Miroslav Perovic on 11/16/14.
//  Copyright (c) 2014 iPera. All rights reserved.
//

import Foundation
import Cocoa

class PreferencesCalculatorViewController: NSViewController, NSComboBoxDelegate {
	@IBOutlet weak var calculatorSelector: NSComboBox!
	@IBOutlet weak var printerButton: NSButton!
	@IBOutlet weak var cardReaderButton: NSButton!
	@IBOutlet weak var synchronyzeButton: NSButton!

	var calculatorType: CalculatorType?
	var preferencesContainerViewController: PreferencesContainerViewController?

	override func viewDidLoad() {
		let defaults = UserDefaults.standard
		
		let cType = defaults.integer(forKey: HPCalculatorType)
		
		switch cType {
		case 1:
			calculatorType = .hp41C
		case 2:
			calculatorType = .hp41CV
		case 3:
			calculatorType = .hp41CX
		default:
			// Make sure I have a default for next time
			calculatorType = .hp41CX
			defaults.set(CalculatorType.hp41CX.rawValue, forKey: HPCalculatorType)
		}
		calculatorSelector.selectItem(at: cType - 1)
	}
	
	
	//MARK: - Actions
	
	@IBAction func applyChanges(sender: AnyObject)
	{
		preferencesContainerViewController?.applyChanges()
	}
	
	@IBAction func synchronize(sender: AnyObject)
	{
		if sender as? NSObject == synchronyzeButton {
			if synchronyzeButton.state == NSControl.StateValue.on {
				SYNCHRONYZE = true
			} else {
				SYNCHRONYZE = false
			}
			let defaults = UserDefaults.standard
			defaults.set(SYNCHRONYZE, forKey: "synchronyzeTime")
			defaults.synchronize()
		}
	}

	
	// MARK: - NSComboBoxDelegate Methods
	func comboBoxSelectionDidChange(_ notification: Notification)
	{
		if notification.object as? NSObject == calculatorSelector {
			let selected = calculatorSelector.indexOfSelectedItem + 1
			let defaults = UserDefaults.standard
			let cType = defaults.integer(forKey: HPCalculatorType)
			
			if selected != cType {
//				comments.stringValue = "Please be aware that changing the calculator type may result in some memory loss"
				switch selected {
				case 1:
					calculatorType = .hp41C
				case 2:
					calculatorType = .hp41CV
				case 3:
					calculatorType = .hp41CX
				default:
					// Make sure I have a default for next time
					calculatorType = .hp41CX
				}
			}
		}
	}
}
