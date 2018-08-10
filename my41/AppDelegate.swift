//
//  AppDelegate.swift
//  my41
//
//  Created by Miroslav Perovic on 7/30/14.
//  Copyright (c) 2014 iPera. All rights reserved.
//

import Foundation
import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
	var window: CalculatorWindow?
	var buttonPressed = false
	
	func applicationDidFinishLaunching(aNotification: NSNotification) {
		// Insert code here to initialize your application
		let defaults = UserDefaults.standard
		if let _ = defaults.object(forKey: "memory") as? NSData {
			CalculatorApplication.shared().activate(ignoringOtherApps: false)
		} else {
			CalculatorApplication.shared().activate(ignoringOtherApps: true)
		}
		if let aWindow = self.window {
			aWindow.becomeFirstResponder()
			aWindow.becomeKey()
			aWindow.becomeMain()
		}
	}

	func applicationWillResignActive(_ notification: Notification) {
		CalculatorController.sharedInstance.saveMemory()
	}

	func applicationWillBecomeActive(_ notification: Notification) {
		CalculatorController.sharedInstance.restoreMemory()
	}
	
	func applicationWillTerminate(aNotification: NSNotification) {
		// Insert code here to tear down your application
		CalculatorController.sharedInstance.saveMemory()
	}

	@IBAction func masterClear(sender: AnyObject) {
		let defaults = UserDefaults.standard
		defaults.removeObject(forKey: "memory")
		defaults.synchronize()
		CalculatorController.sharedInstance.resetCalculator(false)
	}
	
	func application(_ app: NSApplication, willEncodeRestorableState coder: NSCoder) {
		// Implement this functionality
	}
	
	func application(_ app: NSApplication, didDecodeRestorableState coder: NSCoder) {
		// Implement this functionality
	}
}

