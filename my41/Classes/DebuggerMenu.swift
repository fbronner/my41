//
//  DebuggerMenu.swift
//  my41
//
//  Created by Miroslav Perovic on 11/15/14.
//  Copyright (c) 2014 iPera. All rights reserved.
//

import Foundation
import Cocoa

final class DebugMenuViewController: NSViewController {
	var registersView: SelectedDebugView?
	var memoryView: SelectedDebugView?
	var debugContainerViewController: DebugContainerViewController?
	
	@IBOutlet weak var menuView: NSView!
	
	override func viewWillAppear() {
        super.viewWillAppear()

		view.layer = CALayer()
		view.layer?.backgroundColor = NSColor(calibratedRed: 0.4824, green: 0.6667, blue: 0.2941, alpha: 1.0).cgColor
		view.wantsLayer = true

		registersView = SelectedDebugView(frame: CGRect(x: 0, y: menuView.frame.size.height - 35, width: 184, height: 24))
		registersView?.text = "Registers"
		registersView?.selected = true
		menuView.addSubview(registersView!)
		
		memoryView = SelectedDebugView(frame: CGRect(x: 0, y: menuView.frame.size.height - 59, width: 184, height: 24))
		memoryView?.text = "Memory"
		memoryView?.selected = false
		menuView.addSubview(memoryView!)
	}
	
	@IBAction func registersAction(sender: AnyObject) {
		registersView!.selected = true
		memoryView!.selected = false
		registersView!.setNeedsDisplay(registersView!.bounds)
		memoryView!.setNeedsDisplay(memoryView!.bounds)
		
		debugContainerViewController?.loadCPUViewController()
	}
	
	@IBAction func memoryAction(sender: AnyObject) {
		registersView!.selected = false
		memoryView!.selected = true
		registersView!.setNeedsDisplay(registersView!.bounds)
		memoryView!.setNeedsDisplay(memoryView!.bounds)
		
		debugContainerViewController?.loadMemoryViewController()
	}
}

final class DebugerMenuView: NSView {
	
}

final class SelectedDebugView: NSView {
	var text: NSString?
	var selected: Bool?
	
	override func draw(_ dirtyRect: NSRect) {
		//// Color Declarations
		let backColor = NSColor(calibratedRed: 1, green: 1, blue: 1, alpha: 0.95)
		let textColor = NSColor(calibratedRed: 0.147, green: 0.222, blue: 0.162, alpha: 1)
		
		let font = NSFont(name: "Helvetica Bold", size: 14.0)
		
		let textRect: NSRect = NSMakeRect(5, 3, 125, 18)
        let textStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
		textStyle.alignment = .left
		
		if selected! {
			//// Rectangle Drawing
			let rectangleCornerRadius: CGFloat = 5
			let rectangleRect = NSMakeRect(0, 0, 184, 24)
			let rectangleInnerRect = NSInsetRect(rectangleRect, rectangleCornerRadius, rectangleCornerRadius)
			let rectanglePath = NSBezierPath()
			rectanglePath.move(to: NSMakePoint(NSMinX(rectangleRect), NSMinY(rectangleRect)))
			rectanglePath.appendArc(
				withCenter: NSMakePoint(NSMaxX(rectangleInnerRect), NSMinY(rectangleInnerRect)),
				radius: rectangleCornerRadius,
				startAngle: 270,
				endAngle: 360
			)
			rectanglePath.appendArc(
				withCenter: NSMakePoint(NSMaxX(rectangleInnerRect), NSMaxY(rectangleInnerRect)),
				radius: rectangleCornerRadius,
				startAngle: 0,
				endAngle: 90
			)
			rectanglePath.line(to: NSMakePoint(NSMinX(rectangleRect), NSMaxY(rectangleRect)))
			rectanglePath.close()
			backColor.setFill()
			rectanglePath.fill()
			
			if let actualFont = font {
				let textFontAttributes: [NSAttributedString.Key: Any] = [
                    NSAttributedString.Key.font: actualFont,
                    NSAttributedString.Key.foregroundColor: textColor,
                    NSAttributedString.Key.paragraphStyle: textStyle
				]

				text?.draw(in: NSOffsetRect(textRect, 0, 1), withAttributes: textFontAttributes)
			}
		} else {
			if let actualFont = font {
				let textFontAttributes: [NSAttributedString.Key: Any] = [
                    NSAttributedString.Key.font: actualFont,
                    NSAttributedString.Key.foregroundColor: backColor,
                    NSAttributedString.Key.paragraphStyle: textStyle
				]
				
				text?.draw(in: NSOffsetRect(textRect, 0, 1), withAttributes: textFontAttributes)
			}
		}
	}

}


//MARK: -

final class DebugMenuLabelView: NSView {

	override func awakeFromNib() {
        super.awakeFromNib()

		let viewLayer = CALayer()
		viewLayer.backgroundColor = NSColor.selectedTextBackgroundColor.cgColor
		wantsLayer = true
		layer = viewLayer
	}

}
