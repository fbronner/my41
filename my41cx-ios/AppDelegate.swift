//
//  AppDelegate.swift
//  my41cx-ios
//
//  Created by Miroslav Perovic on 1/10/15.
//  Copyright (c) 2015 iPera. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func applicationDidFinishLaunching(_ application: UIApplication) {
		// Override point for customization after application launch.
		CalculatorController.sharedInstance.resetCalculator(restoringMemory: true)
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
		CalculatorController.sharedInstance.saveMemory()
		CalculatorController.sharedInstance.saveCPU()
	}
	
	func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
		return true
	}
	
	func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
		return true
	}
}

