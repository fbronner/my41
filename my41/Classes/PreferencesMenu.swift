//
//  PreferencesMenu.swift
//  my41
//
//  Created by Miroslav Perovic on 11/16/14.
//  Copyright (c) 2014 iPera. All rights reserved.
//

import Foundation
import Cocoa

class PreferencesMenuViewController: NSViewController {
    @IBOutlet private weak var calculatorButton: NSButton!
    @IBOutlet private weak var modsButton: NSButton!
	var calculatorView: SelectedPreferencesView?
	var modsView: SelectedPreferencesView?
	
	var preferencesContainerViewController: PreferencesContainerViewController?
	
	@IBOutlet weak var menuView: NSView!

    override func viewDidLoad() {
        super.viewDidLoad()

		if calculatorView != nil {
			calculatorView?.removeFromSuperview()
		}
		calculatorView = SelectedPreferencesView(frame: calculatorButton.frame)
		calculatorView?.text = "Calculator"
		calculatorView?.selected = true
		menuView.addSubview(calculatorView!)
		
		if modsView != nil {
			modsView?.removeFromSuperview()
		}
        modsView = SelectedPreferencesView(frame: modsButton.frame)
		modsView?.text = "MODs"
		modsView?.selected = false
		menuView.addSubview(modsView!)
	}
	
	
	// MARK: Actions
	@IBAction func selectCalculatorAction(sender: AnyObject) {
		calculatorView?.selected = true
		modsView?.selected = false
		calculatorView!.setNeedsDisplay(calculatorView!.bounds)
		modsView!.setNeedsDisplay(modsView!.bounds)
		
		preferencesContainerViewController?.loadPreferencesCalculatorViewController()
	}
	
	@IBAction func selectModAction(sender: AnyObject) {
		calculatorView?.selected = false
		modsView?.selected = true
		calculatorView!.setNeedsDisplay(calculatorView!.bounds)
		modsView!.setNeedsDisplay(modsView!.bounds)
		
		preferencesContainerViewController?.loadPreferencesModsViewController()
	}
}

class PreferencesMenuView: NSView {

	override func awakeFromNib() {
        super.awakeFromNib()

		let viewLayer = CALayer()
		viewLayer.backgroundColor = NSColor.gridColor.cgColor
		wantsLayer = true
		layer = viewLayer
	}

}

//MARK: -

class PreferencesMenuLabelView: NSView {

	override func awakeFromNib() {
        super.awakeFromNib()

		let viewLayer = CALayer()
		viewLayer.backgroundColor = NSColor.selectedTextBackgroundColor.cgColor
		wantsLayer = true
		layer = viewLayer
	}

}

class SelectedPreferencesView: NSView {
	var text: NSString?
	var selected: Bool?
	
	override func draw(_ dirtyRect: NSRect) {
		//// Color Declarations
		let backColor = NSColor(calibratedRed: 0.1569, green: 0.6157, blue: 0.8902, alpha: 0.95)
		let textColor = NSColor(calibratedRed: 1.0, green: 1.0, blue: 1.0, alpha: 1)
		
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
				let textFontAttributes: [NSAttributedString.Key : Any] = [
                    .font: actualFont,
                    .foregroundColor: textColor,
                    .paragraphStyle: textStyle
				]
				
				text?.draw(in: NSOffsetRect(textRect, 0, 1), withAttributes: textFontAttributes)
			}
		} else {
			if let actualFont = font {
				let textFontAttributes: [NSAttributedString.Key : Any] = [
                    .font: actualFont,
                    .foregroundColor: backColor,
                    .paragraphStyle: textStyle
				]
				
				text?.draw(in: NSOffsetRect(textRect, 0, 1), withAttributes: textFontAttributes)
			}
		}
	}
    
}
