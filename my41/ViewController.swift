//
//  ViewController.swift
//  my41
//
//  Created by Miroslav Perovic on 7/30/14.
//  Copyright (c) 2014 iPera. All rights reserved.
//

import Cocoa

final class ViewController: NSViewController {
    @IBOutlet weak var keyboard: Keyboard!
    @IBOutlet weak var buttonCellOn: ButtonCell!
    @IBOutlet weak var buttonCellUSER: ButtonCell!
    @IBOutlet weak var buttonCellPRGM: ButtonCell!
    @IBOutlet weak var buttonCellALPHA: ButtonCell!

    @IBOutlet weak var displayBackgroundView: NSView!
    @IBOutlet weak var keyboardContainerView: NSView!

    @IBOutlet weak var labelSigmaMinus: NSTextField!
    @IBOutlet weak var buttonCellSigmaPlus: ButtonCell!
    @IBOutlet weak var buttonSigmaPlus: Key!
    @IBOutlet weak var labelYX: NSTextField!
    @IBOutlet weak var buttonCellOneX: ButtonCell!
    @IBOutlet weak var buttonOneX: Key!
    @IBOutlet weak var labelXSquare: NSTextField!
    @IBOutlet weak var buttonCellSquareRoot: ButtonCell!
    @IBOutlet weak var buttonSquareRoot: Key!
    @IBOutlet weak var labelTenX: NSTextField!
    @IBOutlet weak var buttonCellLog: ButtonCell!
    @IBOutlet weak var buttonLog: Key!
    @IBOutlet weak var labelEX: NSTextField!
    @IBOutlet weak var buttonCellLn: ButtonCell!
    @IBOutlet weak var buttonLn: Key!
    @IBOutlet weak var labelCLSigma: NSTextField!
    @IBOutlet weak var buttonCellXexY: ButtonCell!
    @IBOutlet weak var buttonXexY: Key!
    @IBOutlet weak var labelPercent: NSTextField!
    @IBOutlet weak var buttonCellRArrrow: ButtonCell!
    @IBOutlet weak var buttonRArrrow: Key!
    @IBOutlet weak var labelSin: NSTextField!
    @IBOutlet weak var buttonCellSin: ButtonCell!
    @IBOutlet weak var buttonSin: Key!
    @IBOutlet weak var labelCos: NSTextField!
    @IBOutlet weak var buttonCellCos: ButtonCell!
    @IBOutlet weak var buttonCos: Key!
    @IBOutlet weak var labelTan: NSTextField!
    @IBOutlet weak var buttonCellTan: ButtonCell!
    @IBOutlet weak var buttonTan: Key!
    @IBOutlet weak var buttonCellShift: ButtonCell!
    @IBOutlet weak var buttonShift: Key!
    @IBOutlet weak var labelASN: NSTextField!
    @IBOutlet weak var buttonCellXEQ: ButtonCell!
    @IBOutlet weak var buttonXEQ: Key!
    @IBOutlet weak var labelLBL: NSTextField!
    @IBOutlet weak var buttonCellSTO: ButtonCell!
    @IBOutlet weak var buttonSTO: Key!
    @IBOutlet weak var labelGTO: NSTextField!
    @IBOutlet weak var buttonCellRCL: ButtonCell!
    @IBOutlet weak var buttonRCL: Key!
    @IBOutlet weak var labelBST: NSTextField!
    @IBOutlet weak var buttonCellSST: ButtonCell!
    @IBOutlet weak var buttonSST: Key!
    @IBOutlet weak var labelCATALOG: NSTextField!
    @IBOutlet weak var buttonCellENTER: ButtonCell!
    @IBOutlet weak var buttonENTER: Key!
    @IBOutlet weak var labelISG: NSTextField!
    @IBOutlet weak var buttonCellCHS: ButtonCell!
    @IBOutlet weak var buttonCHS: Key!
    @IBOutlet weak var labelRTN: NSTextField!
    @IBOutlet weak var buttonCellEEX: ButtonCell!
    @IBOutlet weak var buttonEEX: Key!
    @IBOutlet weak var labelCLXA: NSTextField!
    @IBOutlet weak var buttonCellBack: ButtonCell!
    @IBOutlet weak var buttonBack: Key!

    @IBOutlet weak var labelXEQY: NSTextField!
    @IBOutlet weak var buttonCellMinus: ButtonCell!
    @IBOutlet weak var buttonMinus: Key!
    @IBOutlet weak var labelXLessThanY: NSTextField!
    @IBOutlet weak var buttonCellPlus: ButtonCell!
    @IBOutlet weak var buttonPlus: Key!
    @IBOutlet weak var labelXGreaterThanY: NSTextField!
    @IBOutlet weak var buttonCellMultiply: ButtonCell!
    @IBOutlet weak var buttonMultiply: Key!
    @IBOutlet weak var labelXEQ0: NSTextField!
    @IBOutlet weak var buttonCellDivide: ButtonCell!
    @IBOutlet weak var buttonDivide: Key!

    @IBOutlet weak var labelSF: NSTextField!
    @IBOutlet weak var buttonCell7: ButtonCell!
    @IBOutlet weak var button7: Key!
    @IBOutlet weak var labelCF: NSTextField!
    @IBOutlet weak var buttonCell8: ButtonCell!
    @IBOutlet weak var button8: Key!
    @IBOutlet weak var labelFS: NSTextField!
    @IBOutlet weak var buttonCell9: ButtonCell!
    @IBOutlet weak var button9: Key!
    @IBOutlet weak var labelBEEP: NSTextField!
    @IBOutlet weak var buttonCell4: ButtonCell!
    @IBOutlet weak var button4: Key!
    @IBOutlet weak var labelPR: NSTextField!
    @IBOutlet weak var buttonCell5: ButtonCell!
    @IBOutlet weak var button5: Key!
    @IBOutlet weak var labelRP: NSTextField!
    @IBOutlet weak var buttonCell6: ButtonCell!
    @IBOutlet weak var button6: Key!
    @IBOutlet weak var labelFIX: NSTextField!
    @IBOutlet weak var buttonCell1: ButtonCell!
    @IBOutlet weak var button1: Key!
    @IBOutlet weak var labelSCI: NSTextField!
    @IBOutlet weak var buttonCell2: ButtonCell!
    @IBOutlet weak var button2: Key!
    @IBOutlet weak var labelENG: NSTextField!
    @IBOutlet weak var buttonCell3: ButtonCell!
    @IBOutlet weak var button3: Key!
    @IBOutlet weak var labelPI: NSTextField!
    @IBOutlet weak var buttonCell0: ButtonCell!
    @IBOutlet weak var button0: Key!
    @IBOutlet weak var labelLASTX: NSTextField!
    @IBOutlet weak var buttonCellPoint: ButtonCell!
    @IBOutlet weak var buttonPoint: Key!
    @IBOutlet weak var labelVIEW: NSTextField!
    @IBOutlet weak var buttonCellRS: ButtonCell!
    @IBOutlet weak var buttonRS: Key!

    @IBOutlet weak var calculatorLabel: NSTextField!

    override func viewWillAppear() {
        super.viewWillAppear()

        becomeFirstResponder()

        (view as? CalculatorView)?.viewController = self

        view.wantsLayer = true
        let image = NSImage(named: "Blanked front")
        view.layer?.contents = image

        displayBackgroundView.layer = CALayer()
        displayBackgroundView.layer?.backgroundColor = NSColor.lightGray.cgColor
        displayBackgroundView.layer?.cornerRadius = 3.0
        displayBackgroundView.wantsLayer = true

        // ON
        buttonCellOn.upperText = "ON".attributedString()

        // USER
        buttonCellUSER.upperText = "USER".attributedString()

        // PRGM
        buttonCellPRGM.upperText = "PRGM".attributedString()

        // ALPHA
        buttonCellALPHA.upperText = "ALPHA".attributedString()

        guard
            let Helvetica09Font = NSFont(name: "Helvetica", size: 9.0),
            let Helvetica11Font = NSFont(name: "Helvetica", size: 11.0),
            let Helvetica12Font = NSFont(name: "Helvetica", size: 12.0),
            let Helvetica13Font = NSFont(name: "Helvetica", size: 13.0),
            let Helvetica15Font = NSFont(name: "Helvetica", size: 15.0),
            let TimesNewRoman09Font = NSFont(name: "Times New Roman", size: 9.0),
            let TimesNewRoman10Font = NSFont(name: "Times New Roman", size: 10.0),
            let TimesNewRoman11Font = NSFont(name: "Times New Roman", size: 11.0),
            let TimesNewRoman12Font = NSFont(name: "Times New Roman", size: 12.0),
            let TimesNewRoman13Font = NSFont(name: "Times New Roman", size: 12.0),
            let TimesNewRoman14Font = NSFont(name: "Times New Roman", size: 14.0),
            let TimesNewRoman15Font = NSFont(name: "Times New Roman", size: 15.0)
            else {
                return
        }

        // Label Σ-
        let sigmaMinusString = "Σ-".attributedString()
        let sigmaMinusAttributes: [NSAttributedString.Key: Any] = [
            .font : Helvetica13Font,
            .baselineOffset: 1
        ]
        sigmaMinusString.addAttributes(sigmaMinusAttributes, range: NSMakeRange(1, 1))
        labelSigmaMinus.attributedStringValue = sigmaMinusString

        // Button Σ+
        let sigmaPlusString = "Σ+".attributedString(color: .white)
        let sigmaPlusAttributes = [
            NSAttributedString.Key.baselineOffset: 1
        ]
        sigmaPlusString.addAttributes(sigmaPlusAttributes, range: NSMakeRange(1, 1))
        buttonCellSigmaPlus.upperText = sigmaPlusString
//        buttonCellSigmaPlus.lowerText = "A"

        // Label yx
        let yxString = "yx".attributedString()
        let yxAttributes: [NSAttributedString.Key: Any] = [
            .font : TimesNewRoman10Font,
            .baselineOffset: 4
        ]
        yxString.addAttributes(yxAttributes, range: NSMakeRange(1, 1))
        labelYX.attributedStringValue = yxString

        // Button 1/x
        let oneXString = "1/x".attributedString(color: .white)
        let oneXAttributes = [
            NSAttributedString.Key.font : TimesNewRoman10Font,
        ]
        oneXString.addAttributes(oneXAttributes, range: NSMakeRange(2, 1))
        buttonCellOneX.upperText = oneXString
//        buttonCellOneX.lowerText = "B"

        // Label x^2
        let xSquareString = "x\u{00B2}".attributedString()
        let xSquareAttributes = [
            NSAttributedString.Key.font : TimesNewRoman12Font,
        ]
        xSquareString.addAttributes(xSquareAttributes, range: NSMakeRange(0, 2))
        labelXSquare.attributedStringValue = xSquareString

        // Button √x
        let rootXString = "√x\u{0304}".attributedString(color: .white)
        let rootXAttributes1 = [
            NSAttributedString.Key.baselineOffset: 1
        ]
        rootXString.addAttributes(rootXAttributes1, range: NSMakeRange(2, 1))
        let rootXAttributes2 = [
            NSAttributedString.Key.font : TimesNewRoman10Font,
        ]
        rootXString.addAttributes(rootXAttributes2, range: NSMakeRange(1, 1))
        buttonCellSquareRoot.upperText = rootXString
//        buttonCellSquareRoot.lowerText = "C"

        // Label 10^x
        let tenXString = "10x".attributedString()
        let tenXAttributes: [NSAttributedString.Key: Any] = [
            .font : TimesNewRoman10Font,
            .baselineOffset: 4
        ]
        tenXString.addAttributes(tenXAttributes, range: NSMakeRange(2, 1))
        labelTenX.attributedStringValue = tenXString

        // Button LOG
        buttonCellLog.upperText = "LOG".attributedString(color: .white)
//        buttonCellLog.lowerText = "D"

        // Label e^x
        let eXString = "ex".attributedString()
        let eXAttributes: [NSAttributedString.Key: Any] = [
            .font : TimesNewRoman10Font,
            .baselineOffset: 4
        ]

        eXString.addAttributes(eXAttributes, range: NSMakeRange(1, 1))
        let eXAttributes2 = [
            NSAttributedString.Key.font : Helvetica12Font
        ]
        eXString.addAttributes(eXAttributes2, range: NSMakeRange(0, 1))
        labelEX.attributedStringValue = eXString

        // Button LN
        buttonCellLn.upperText = "LN".attributedString(color: .white)
//        buttonCellLn.lowerText = "E"

        // Label CLΣ
        labelCLSigma.attributedStringValue = "CLΣ".attributedString()

        // Button x≷y
        let XexYString = "x≷y".attributedString(color: .white)
        let XexYAttributes: [NSAttributedString.Key: Any] = [
            .font : TimesNewRoman14Font,
            .baselineOffset: 1
        ]
        XexYString.addAttributes(XexYAttributes, range: NSMakeRange(0, 3))
        buttonCellXexY.upperText = XexYString
//        buttonCellXexY.lowerText = "F"

        // Label %
        labelPercent.attributedStringValue = "%".attributedString()

        // Button R↓
        buttonCellRArrrow.upperText = "R↓".attributedString(color: .white)
//        buttonCellRArrrow.lowerText = "G"

        // Label SIN-1

        let sin1String = "SIN-1".attributedString()
        let sinAttributes: [NSAttributedString.Key: Any] = [
            .font : TimesNewRoman09Font,
            .baselineOffset: 4
        ]
        sin1String.addAttributes(sinAttributes, range: NSMakeRange(3, 2))
        labelSin.attributedStringValue = sin1String

        // Button SIN
        buttonCellSin.upperText = "SIN".attributedString(color: .white)
//        buttonCellSin.lowerText = "H"

        // Label COS-1
        let cos1String = "COS-1".attributedString()
        let cosAttributes: [NSAttributedString.Key: Any] = [
            .font : TimesNewRoman09Font,
            .baselineOffset: 4
        ]
        cos1String.addAttributes(cosAttributes, range: NSMakeRange(3, 2))
        labelCos.attributedStringValue = cos1String

        // Button COS
        buttonCellCos.upperText = "COS".attributedString(color: .white)
//        buttonCellCos.lowerText = "I"

        // Label TAN-1
        let tan1String = "TAN-1".attributedString()
        let tanAttributes: [NSAttributedString.Key: Any] = [
            .font : TimesNewRoman09Font,
            .baselineOffset: 4
        ]
        tan1String.addAttributes(tanAttributes, range: NSMakeRange(3, 2))
        labelTan.attributedStringValue = tan1String

        // Button TAN
        buttonCellTan.upperText = "TAN".attributedString(color: .white)
//        buttonCellTan.lowerText = "J"

        // Label ASN
        labelASN.attributedStringValue = "ASN".attributedString()

        // Button XEQ
        buttonCellXEQ.upperText = "XEQ".attributedString(color: .white)
//        buttonCellXEQ.lowerText = "K"

        // Label LBL
        labelLBL.attributedStringValue = "LBL".attributedString()

        // Button STO
        buttonCellSTO.upperText = "STO".attributedString(color: .white)
//        buttonCellSTO.lowerText = "L"

        // Label GTO
        labelGTO.attributedStringValue = "GTO".attributedString()

        // Button RCL
        buttonCellRCL.upperText = "RCL".attributedString(color: .white)
//        buttonCellRCL.lowerText = "M"

        // Label BST
        labelBST.attributedStringValue = "BST".attributedString()

        // Button SST
        buttonCellSST.upperText = "SST".attributedString(color: .white)

        // Label CATALOG
        labelCATALOG.attributedStringValue = "CATALOG".attributedString()

        // Button ENTER
        buttonCellENTER.upperText = "ENTER ↑".attributedString(color: .white)
//        buttonCellENTER.lowerText = "N"

        // Label ISG
        labelISG.attributedStringValue = "ISG".attributedString()

        // Button CHS
        buttonCellCHS.upperText = "CHS".attributedString(color: .white)
//        buttonCellCHS.lowerText = "O"

        // Label RTN
        labelRTN.attributedStringValue = "RTN".attributedString()

        // Button EEX
        buttonCellEEX.upperText = "EEX".attributedString(color: .white)
//        buttonCellEEX.lowerText = "P"

        // Label CL X/A
        let clxaString = "CL X/A".attributedString()
        let clxaAttributes = [
            NSAttributedString.Key.font : TimesNewRoman11Font
        ]
        clxaString.addAttributes(clxaAttributes, range: NSMakeRange(3, 1))
        labelCLXA.attributedStringValue = clxaString

        // Button Back
        let backString = "←".attributedString(color: .white)
        let backAttributes = [
            NSAttributedString.Key.font : Helvetica11Font
        ]
        backString.addAttributes(backAttributes, range: NSMakeRange(0, 1))
        buttonCellBack.upperText = backString

        // Label x=y ?
        let xeqyString = "x=y ?".attributedString()
        let xeqyAttributes = [
            NSAttributedString.Key.font : TimesNewRoman14Font
        ]
        xeqyString.addAttributes(xeqyAttributes, range: NSMakeRange(0, 3))
        labelXEQY.attributedStringValue = xeqyString

        // Button Minus
        let minusString = "━".attributedString(color: .white)
        let minusAttributes: [NSAttributedString.Key: Any] = [
            .font : Helvetica09Font,
            .baselineOffset: -1
        ]
        minusString.addAttributes(minusAttributes, range: NSMakeRange(0, 1))
        buttonCellMinus.upperText = minusString
//        buttonCellMinus.lowerText = "Q"

        // Label x≤y ?
        let xlessthanyString = "x≤y ?".attributedString()
        let xlessthanyAttributes = [
            NSAttributedString.Key.font : TimesNewRoman13Font
        ]
        xlessthanyString.addAttributes(xlessthanyAttributes, range: NSMakeRange(0, 3))
        labelXLessThanY.attributedStringValue = xlessthanyString

        // Button Plus
        let plusString = "╋".attributedString(color: .white)
        let plusAttributes = [
            NSAttributedString.Key.font : Helvetica09Font
        ]
        plusString.addAttributes(plusAttributes, range: NSMakeRange(0, 1))
        buttonCellPlus.upperText = plusString
//        buttonCellPlus.lowerText = "U"

        // Label x≥y ?
        let xgreaterthanyString = "x>y ?".attributedString()
        let xgreaterthanyAttributes: [NSAttributedString.Key: Any] = [
            .font : TimesNewRoman13Font,
            .baselineOffset: -1
        ]
        xgreaterthanyString.addAttributes(xgreaterthanyAttributes, range: NSMakeRange(0, 3))
        labelXGreaterThanY.attributedStringValue = xgreaterthanyString

        // Button Multiply
        let multiplyString = "×".attributedString(color: .white)
        let multiplyAttributes: [NSAttributedString.Key: Any] = [
            .font : Helvetica15Font,
            .baselineOffset: 1
        ]
        multiplyString.addAttributes(multiplyAttributes, range: NSMakeRange(0, 1))
        buttonCellMultiply.upperText = multiplyString
//        buttonCellMultiply.lowerText = "Y"

        // Label x=0 ?
        let xeq0String = "x=0 ?".attributedString()
        let xeq0Attributes: [NSAttributedString.Key: Any] = [
            .font : TimesNewRoman13Font,
            .baselineOffset: -1
        ]
        xeq0String.addAttributes(xeq0Attributes, range: NSMakeRange(0, 5))
        labelXEQ0.attributedStringValue = xeq0String

        // Button Divide
        let divideString = "÷".attributedString(color: .white)
        let divideAttributes: [NSAttributedString.Key: Any] = [
            .font : Helvetica15Font,
            .baselineOffset: 1
        ]
        divideString.addAttributes(divideAttributes, range: NSMakeRange(0, 1))
        buttonCellDivide.upperText = divideString
//        buttonCellDivide.lowerText = ":"

        // Label SF
        labelSF.attributedStringValue = "SF".attributedString()

        // Button 7
        let sevenString = "7".attributedString(color: .white)
        let sevenAttributes = [
            NSAttributedString.Key.font : Helvetica13Font
        ]
        sevenString.addAttributes(sevenAttributes, range: NSMakeRange(0, 1))
        buttonCell7.upperText = sevenString
//        buttonCell7.lowerText = "R"

        // Label CF
        labelCF.attributedStringValue = "CF".attributedString()

        // Button 8
        let eightString = "8".attributedString(color: .white)
        let eightAttributes = [
            NSAttributedString.Key.font : Helvetica13Font
        ]
        eightString.addAttributes(eightAttributes, range: NSMakeRange(0, 1))
        buttonCell8.upperText = eightString
//        buttonCell8.lowerText = "S"

        // Label FS?
        labelFS.attributedStringValue = "FS?".attributedString()

        // Button 9
        let nineString = "9".attributedString(color: .white)
        let nineAttributes = [
            NSAttributedString.Key.font : Helvetica13Font
        ]
        nineString.addAttributes(nineAttributes, range: NSMakeRange(0, 1))
        buttonCell9.upperText = nineString
//        buttonCell9.lowerText = "T"

        // Label BEEP
        labelBEEP.attributedStringValue = "BEEP".attributedString()

        // Button 4
        let fourString = "4".attributedString(color: .white)
        let fourAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font : Helvetica13Font
        ]
        fourString.addAttributes(fourAttributes, range: NSMakeRange(0, 1))
        buttonCell4.upperText = fourString
//        buttonCell4.lowerText = "V"

        // Label P→R
        labelPR.attributedStringValue = "P→R".attributedString()

        // Button 5
        let fiveString = "5".attributedString(color: .white)
        let fiveAttributes = [
            NSAttributedString.Key.font : Helvetica13Font
        ]
        fiveString.addAttributes(fiveAttributes, range: NSMakeRange(0, 1))
        buttonCell5.upperText = fiveString
//        buttonCell5.lowerText = "W"

        // Label R→P
        labelRP.attributedStringValue = "R→P".attributedString()

        // Button 6
        let sixString = "6".attributedString(color: .white)
        let sixAttributes = [
            NSAttributedString.Key.font : Helvetica13Font
        ]
        sixString.addAttributes(sixAttributes, range: NSMakeRange(0, 1))
        buttonCell6.upperText = sixString
//        buttonCell6.lowerText = "X"

        // Label FIX
        labelFIX.attributedStringValue = "FIX".attributedString()

        // Button 1
        let oneString = "1".attributedString(color: .white)
        let oneAttributes = [
            NSAttributedString.Key.font : Helvetica13Font
        ]
        oneString.addAttributes(oneAttributes, range: NSMakeRange(0, 1))
        buttonCell1.upperText = oneString
//        buttonCell1.lowerText = "Z"

        // Label SCI
        labelSCI.attributedStringValue = "SCI".attributedString()

        // Button 2
        let twoString = "2".attributedString(color: .white)
        let twoAttributes = [
            NSAttributedString.Key.font : Helvetica13Font
        ]
        twoString.addAttributes(twoAttributes, range: NSMakeRange(0, 1))
        buttonCell2.upperText = twoString
//        buttonCell2.lowerText = "="

        // Label ENG
        labelENG.attributedStringValue = "ENG".attributedString()

        // Button 3
        let thtreeString = "3".attributedString(color: .white)
        let thtreeAttributes = [
            NSAttributedString.Key.font : Helvetica13Font
        ]
        thtreeString.addAttributes(thtreeAttributes, range: NSMakeRange(0, 1))
        buttonCell3.upperText = thtreeString
//        buttonCell3.lowerText = "?"

        // Label PI
        let piString = "π".attributedString()
        let piAttributes = [
            NSAttributedString.Key.font : TimesNewRoman15Font
        ]
        piString.addAttributes(piAttributes, range: NSMakeRange(0, 1))
        labelPI.attributedStringValue = piString

        // Button 0
        let zeroString = "0".attributedString(color: .white)
        let zeroAttributes = [
            NSAttributedString.Key.font : Helvetica13Font
        ]
        zeroString.addAttributes(zeroAttributes, range: NSMakeRange(0, 1))
        buttonCell0.upperText = zeroString
//        buttonCell0.lowerText = "SPACE"

        // Label LAST X
        let lastxString = "LAST X".attributedString()
        let lastxAttributes = [
            NSAttributedString.Key.font : TimesNewRoman13Font
        ]
        lastxString.addAttributes(lastxAttributes, range: NSMakeRange(5, 1))
        labelLASTX.attributedStringValue = lastxString

        // Button •
        let pointString = "•".attributedString(color: .white)
        let pointAttributes = [
            NSAttributedString.Key.font : Helvetica13Font
        ]
        pointString.addAttributes(pointAttributes, range: NSMakeRange(0, 1))
        buttonCellPoint.upperText = pointString
//        buttonCellPoint.lowerText = ","

        // Label VIEW
        labelVIEW.attributedStringValue = "VIEW".attributedString()

        // Button R/S
        let rsString = "R/S".attributedString(color: .white)
        let rsAttributes = [
            NSAttributedString.Key.font : Helvetica12Font
        ]
        rsString.addAttributes(rsAttributes, range: NSMakeRange(0, 3))
        buttonCellRS.upperText = rsString
    }

    override func viewDidAppear() {
        super.viewDidAppear()

        switch CalculatorType.getDefault() {
        case CalculatorType.hp41C:
            calculatorLabel.stringValue = "my41C"
        case CalculatorType.hp41CV:
            calculatorLabel.stringValue = "my41CV"
        case CalculatorType.hp41CX:
            calculatorLabel.stringValue = "my41CX"
        }
    }

    override var acceptsFirstResponder: Bool { return true }

    @IBAction func keyPressed(sender: AnyObject) {
        if let key = sender as? Key {
            if TRACE != 0 {
                print(key.keyCode)
            }

            cpu.keyWithCode(key.keyCode, pressed: true)
            if TRACE != 0 {
                print(key.keyCode)
            }
            cpu.keyWithCode(key.keyCode, pressed: false)
        }
    }
}

final class KeyboardView : NSView {

    //    override func draw(_ dirtyRect: NSRect) {
    //        //// Color Declarations
    //        let color = NSColor(calibratedRed: 0.604, green: 0.467, blue: 0.337, alpha: 1)
    //
    //        //// Bezier Drawing
    //        let bezierPath = NSBezierPath()
    //        bezierPath.move(to: NSMakePoint(5, 0))
    //        bezierPath.line(to: NSMakePoint(bounds.width - 5.0, 0))
    //        bezierPath.curve(to: NSMakePoint(bounds.width - 5.0, bounds.height), controlPoint1: NSMakePoint(bounds.width, bounds.height / 2.0), controlPoint2: NSMakePoint(bounds.width - 5.0, bounds.height))
    //        bezierPath.line(to: NSMakePoint(5, bounds.height))
    //        bezierPath.curve(to: NSMakePoint(5, 0), controlPoint1: NSMakePoint(0, bounds.height / 2.0), controlPoint2: NSMakePoint(5, 0))
    //        color.setStroke()
    //        bezierPath.lineWidth = 2
    //        bezierPath.stroke()
    //    }

}

final class CalculatorView: NSView {
    @IBOutlet weak var lcdDisplay: Display!

    var viewController: ViewController?
    var pressedKey: Key?

    override func awakeFromNib() {
        super.awakeFromNib()

        var rect = bounds
        rect.origin.x = 0.0
        rect.origin.y = 0.0
        setNeedsDisplay(rect)

        NotificationCenter.default.addObserver(self, selector: #selector(displayOff), name: .displayOff, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(displayToggle), name: .displayToggle, object: nil)
    }

    override var acceptsFirstResponder: Bool { return true }

    override func keyDown(with theEvent: NSEvent) {
        if pressedKey == nil {
            if let theButton = getKey(theEvent: theEvent) {
                pressedKey = theButton
                theButton.downKey()
                theButton.highlight(true)
            }
        }
    }

    override func keyUp(with theEvent: NSEvent) {
        if let theButton = pressedKey {
            theButton.upKey()
            theButton.highlight(false)
            pressedKey = nil
        }
    }

    @objc func displayOff() {
        lcdDisplay.displayOff()
    }

    @objc func displayToggle() {
        lcdDisplay.displayToggle()
    }

    func getKey(theEvent: NSEvent) -> Key? {
        let char = theEvent.charactersIgnoringModifiers
        let hasCommand = (theEvent.modifierFlags.intersection(.command)).rawValue != 0
        let hasAlt = (theEvent.modifierFlags.intersection(.option)).rawValue != 0

        if CalculatorController.sharedInstance.alphaMode {
            if hasCommand {
                if hasAlt {
                    if char == "a" || char == "A" {
                        return viewController?.keyboard?.keyAlpha!
                    } else if char == "p" || char == "P" {
                        return viewController?.keyboard?.keyPrgm!
                    } else if char == "u" || char == "U" {
                        return viewController?.keyboard?.keyUser!
                    } else if char == "o" || char == "O" {
                        return viewController?.keyboard?.keyOn!
                    }
                } else {
                    if char == "r" || char == "R" {
                        return viewController?.buttonRS!
                    } else if char == "f" || char == "F" {
                        return viewController?.buttonShift!
                    } else if char == "s" || char == "S" {
                        return viewController?.buttonSST!
                    }
                }
            } else {
                if char == "." {
                    return viewController?.buttonPoint!
                } else if char == "0" {
                    return viewController?.button0!
                } else if char == "1" {
                    return viewController?.button1!
                } else if char == "2" {
                    return viewController?.button2!
                } else if char == "3" {
                    return viewController?.button3!
                } else if char == "4" {
                    return viewController?.button4!
                } else if char == "5" {
                    return viewController?.button5!
                } else if char == "6" {
                    return viewController?.button6!
                } else if char == "7" {
                    return viewController?.button7!
                } else if char == "8" {
                    return viewController?.button8!
                } else if char == "9" {
                    return viewController?.button9!
                } else if char == "a" || char == "A" {
                    return viewController?.buttonSigmaPlus!
                } else if char == "b" || char == "B" {
                    return viewController?.buttonOneX!
                } else if char == "c" || char == "C" {
                    return viewController?.buttonSquareRoot!
                } else if char == "d" || char == "D" {
                    return viewController?.buttonLog!
                } else if char == "e" || char == "E" {
                    return viewController?.buttonLn!
                } else if char == "f" || char == "F" {
                    return viewController?.buttonXexY!
                } else if char == "g" || char == "G" {
                    return viewController?.buttonRArrrow!
                } else if char == "h" || char == "H" {
                    return viewController?.buttonSin!
                } else if char == "i" || char == "I" {
                    return viewController?.buttonCos!
                } else if char == "j" || char == "J" {
                    return viewController?.buttonTan!
                } else if char == "k" || char == "K" {
                    return viewController?.buttonXEQ!
                } else if char == "l" || char == "L" {
                    return viewController?.buttonSTO!
                } else if char == "m" || char == "M" {
                    return viewController?.buttonRCL!
                } else if char == "n" || char == "N" {
                    return viewController?.buttonENTER!
                } else if char == "o" || char == "O" {
                    return viewController?.buttonCHS!
                } else if char == "p" || char == "P" {
                    return viewController?.buttonEEX!
                } else if char == "\u{7f}" {
                    return viewController?.buttonBack!
                } else if char == "q" || char == "Q" {
                    return viewController?.buttonMinus!
                } else if char == "r" || char == "R" {
                    return viewController?.button7!
                } else if char == "s" || char == "S" {
                    return viewController?.button8!
                } else if char == "t" || char == "T" {
                    return viewController?.button9!
                } else if char == "u" || char == "U" {
                    return viewController?.buttonPlus!
                } else if char == "v" || char == "V" {
                    return viewController?.button4!
                } else if char == "w" || char == "W" {
                    return viewController?.button5!
                } else if char == "x" || char == "X" {
                    return viewController?.button6!
                } else if char == "y" || char == "Y" {
                    return viewController?.buttonMultiply!
                } else if char == "z" || char == "Z" {
                    return viewController?.button1!
                } else if char == "=" {
                    return viewController?.button2!
                } else if char == "?" {
                    return viewController?.button3!
                } else if char == ":" {
                    return viewController?.buttonDivide!
                } else if char == " " {
                    return viewController?.button0!
                } else if char == "," {
                    return viewController?.buttonPoint!
                }
            }
        } else {
            if hasCommand {
                if hasAlt {
                    if char == "a" || char == "A" {
                        return viewController?.keyboard?.keyAlpha!
                    } else if char == "p" || char == "P" {
                        return viewController?.keyboard?.keyPrgm!
                    } else if char == "u" || char == "U" {
                        return viewController?.keyboard?.keyUser!
                    } else if char == "o" || char == "O" {
                        return viewController?.keyboard?.keyOn!
                    }
                } else {
                    if char == "r" || char == "R" {
                        return viewController?.buttonRS!
                    } else if char == "f" || char == "F" {
                        return viewController?.buttonShift!
                    } else if char == "s" || char == "S" {
                        return viewController?.buttonSST!
                    } else if char == "x" || char == "X" {
                        return viewController?.buttonXexY!
                    } else if char == "a" || char == "A" {
                        return viewController?.buttonRArrrow!
                    } else if char == "g" || char == "G" {
                        return viewController?.buttonSigmaPlus!
                    } else if char == "1" {
                        return viewController?.buttonOneX!
                    } else if char == "l" || char == "L" {
                        return viewController?.buttonLn!
                    } else if char == "\u{7f}" {
                        return viewController?.buttonBack!
                    }
                }
            } else {
                if char == "\r" {
                    return viewController?.buttonENTER!
                } else if char == "." {
                    return viewController?.buttonPoint!
                } else if char == "0" {
                    return viewController?.button0!
                } else if char == "1" {
                    return viewController?.button1!
                } else if char == "2" {
                    return viewController?.button2!
                } else if char == "3" {
                    return viewController?.button3!
                } else if char == "4" {
                    return viewController?.button4!
                } else if char == "5" {
                    return viewController?.button5!
                } else if char == "6" {
                    return viewController?.button6!
                } else if char == "7" {
                    return viewController?.button7!
                } else if char == "8" {
                    return viewController?.button8!
                } else if char == "9" {
                    return viewController?.button9!
                } else if char == "+" {
                    return viewController?.buttonPlus!
                } else if char == "-" {
                    return viewController?.buttonMinus!
                } else if char == "*" {
                    return viewController?.buttonMultiply!
                } else if char == "/" {
                    return viewController?.buttonDivide!
                } else if char == "c" || char == "C" {
                    return viewController?.buttonCHS!
                } else if char == "e" || char == "E" {
                    return viewController?.buttonEEX!
                } else if char == "\u{7f}" {
                    return viewController?.buttonBack!
                } else if char == "x" || char == "X" {
                    return viewController?.buttonXEQ!
                } else if char == "s" || char == "S" {
                    return viewController?.buttonSTO!
                } else if char == "r" || char == "R" {
                    return viewController?.buttonRCL!
                } else if char == "i" || char == "I" {
                    return viewController?.buttonSin!
                } else if char == "o" || char == "O" {
                    return viewController?.buttonCos!
                } else if char == "t" || char == "T" {
                    return viewController?.buttonTan!
                } else if char == "q" || char == "Q" {
                    return viewController?.buttonSquareRoot!
                } else if char == "l" || char == "L" {
                    return viewController?.buttonLog!
                }
            }
        }

        return nil
    }
}
