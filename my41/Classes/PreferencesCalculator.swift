//
//  PreferencesCalculator.swift
//  my41
//
//  Created by Miroslav Perovic on 11/16/14.
//  Copyright (c) 2014 iPera. All rights reserved.
//

import Foundation
import Cocoa

final class PreferencesCalculatorViewController: NSViewController, NSComboBoxDelegate {
    static let segueId = "showSelectCalculatorView"

	@IBOutlet weak var calculatorSelector: NSComboBox!
	@IBOutlet weak var printerButton: NSButton!
	@IBOutlet weak var cardReaderButton: NSButton!
	@IBOutlet weak var synchronyzeButton: NSButton!

    var calculatorType = CalculatorType.getDefault()
	var preferencesContainerViewController: PreferencesContainerViewController?

	override func viewDidLoad() {
        super.viewDidLoad()

		calculatorSelector.selectItem(at: calculatorType.asIndex())
	}
	
	
	//MARK: - Actions
	
    @IBAction func applyChanges(_ button: NSButton)
	{
		preferencesContainerViewController?.applyChanges()
	}
	
	@IBAction func synchronize(sender: AnyObject)
	{
		if sender as? NSObject == synchronyzeButton {
            SYNCHRONYZE = synchronyzeButton.state == NSControl.StateValue.on
			UserDefaults.standard.set(SYNCHRONYZE, forKey: "synchronyzeTime")
		}
	}

	
	// MARK: - NSComboBoxDelegate Methods
	func comboBoxSelectionDidChange(_ notification: Notification)
	{
		if notification.object as? NSObject == calculatorSelector {
            calculatorType = CalculatorType(index: calculatorSelector.indexOfSelectedItem)
		}
	}
    
}
