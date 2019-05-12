//
//  Debuger.swift
//  my41
//
//  Created by Miroslav Perovic on 9/21/14.
//  Copyright (c) 2014 iPera. All rights reserved.
//

import Foundation
import Cocoa

final class DebugWindowController: NSWindowController {
	
}


// MARK: - SpitView

final class DebugSplitViewController: NSSplitViewController {
	
	override func viewWillAppear() {
        super.viewWillAppear()

		let menuVC = splitViewItems[0].viewController as! DebugMenuViewController
		let containerVC = splitViewItems[1].viewController as! DebugContainerViewController
		menuVC.debugContainerViewController = containerVC

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
				constant: 379
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
				constant: 710
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
				constant: 379
			)
		)
	}
    
}

final class DebugContainerViewController: NSViewController {
	var debugCPUViewController: DebugCPUViewController?
	var debugMemoryViewController: DebugMemoryViewController?

	override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
		let segid = segue.identifier ?? "(none)"
		
		if segid == "showCPUView" {
			debugCPUViewController = segue.destinationController as? DebugCPUViewController
			debugCPUViewController?.debugContainerViewController = self
		}
		if segid == "showMemoryView" {
			debugMemoryViewController = segue.destinationController as? DebugMemoryViewController
			debugMemoryViewController?.debugContainerViewController = self
		}
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()

		loadCPUViewController()
		let defaults = UserDefaults.standard
		TRACE = defaults.integer(forKey: "traceActive")
		if TRACE == 0 {
			debugCPUViewController?.traceSwitch.state = NSControl.StateValue.off
		} else {
			debugCPUViewController?.traceSwitch.state = NSControl.StateValue.on
		}
	}
	
	func loadCPUViewController() {
		performSegue(withIdentifier: "showCPUView", sender: self)
	}
	
	func loadMemoryViewController() {
		performSegue(withIdentifier: "showMemoryView", sender: self)
	}

}


//MARK: -

final class DebugerSegue: NSStoryboardSegue {

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
