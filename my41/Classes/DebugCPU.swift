//
//  DebugCPUView.swift
//  my41
//
//  Created by Miroslav Perovic on 11/15/14.
//  Copyright (c) 2014 iPera. All rights reserved.
//

import Foundation
import Cocoa

final class DebugCPUViewController: NSViewController {
	@IBOutlet weak var cpuRegistersView: NSView!
	@IBOutlet weak var cpuRegisterA: NSTextField!
	@IBOutlet weak var cpuRegisterB: NSTextField!
	@IBOutlet weak var cpuRegisterC: NSTextField!
	@IBOutlet weak var cpuRegisterM: NSTextField!
	@IBOutlet weak var cpuRegisterN: NSTextField!
	@IBOutlet weak var cpuRegisterP: NSTextField!
	@IBOutlet weak var cpuRegisterQ: NSTextField!
	@IBOutlet weak var cpuRegisterPC: NSTextField!
	@IBOutlet weak var cpuRegisterG: NSTextField!
	@IBOutlet weak var cpuRegisterT: NSTextField!
	@IBOutlet weak var cpuRegisterXST: NSTextField!
	@IBOutlet weak var cpuRegisterST: NSTextField!
	@IBOutlet weak var cpuRegisterR: NSTextField!
	@IBOutlet weak var cpuRegisterCarry: NSTextField!
	@IBOutlet weak var cpuPowerMode: NSTextField!
	@IBOutlet weak var cpuSelectedRAM: NSTextField!
	@IBOutlet weak var cpuSelectedPeripheral: NSTextField!
	@IBOutlet weak var cpuMode: NSTextField!
	@IBOutlet weak var cpuStack1: NSTextField!
	@IBOutlet weak var cpuStack2: NSTextField!
	@IBOutlet weak var cpuStack3: NSTextField!
	@IBOutlet weak var cpuStack4: NSTextField!
	@IBOutlet weak var cpuRegisterKY: NSTextField!
	@IBOutlet weak var cpuRegisterFI: NSTextField!
	
	@IBOutlet weak var displayRegistersView: NSView!
	@IBOutlet weak var displayRegisterA: NSTextField!
	@IBOutlet weak var displayRegisterB: NSTextField!
	@IBOutlet weak var displayRegisterC: NSTextField!
	@IBOutlet weak var displayRegisterE: NSTextField!
	
	@IBOutlet weak var traceSwitch: NSButton!
	
	var debugContainerViewController: DebugContainerViewController?
	
	override func viewDidLoad() {
        super.viewDidLoad()

		cpuRegistersView.wantsLayer = true
		cpuRegistersView.layer?.masksToBounds = true
		cpuRegistersView.layer?.borderWidth = 2.0
		cpuRegistersView.layer?.borderColor = CGColor(gray: 0.75, alpha: 1.0)
		cpuRegistersView.layer?.cornerRadius = 6.0
		
		displayRegistersView.wantsLayer = true
		displayRegistersView.layer?.masksToBounds = true
		displayRegistersView.layer?.borderWidth = 2.0
		displayRegistersView.layer?.borderColor = CGColor(gray: 0.75, alpha: 1.0)
		displayRegistersView.layer?.cornerRadius = 6.0
		
		cpu.debugCPUViewController = self
		
		NotificationCenter.default.addObserver(self, selector: #selector(updateDisplay), name: .kCPUDebugUpdateDisplay, object: nil)
		
		updateDisplay()
	}
	
    @objc func updateDisplay() {
		populateCPURegisters()
		populateDisplayRegisters()
	}
	
	func populateCPURegisters() {
		cpuRegisterA.stringValue = cpu.digitsToString(cpu.reg.A.digits)
		cpuRegisterB.stringValue = cpu.digitsToString(cpu.reg.B.digits)
		cpuRegisterC.stringValue = cpu.digitsToString(cpu.reg.C.digits)
		cpuRegisterM.stringValue = cpu.digitsToString(cpu.reg.M.digits)
		cpuRegisterN.stringValue = cpu.digitsToString(cpu.reg.N.digits)
		cpuRegisterP.stringValue = cpu.bits4ToString(cpu.reg.P)
		cpuRegisterQ.stringValue = cpu.bits4ToString(cpu.reg.Q)
		cpuRegisterPC.stringValue = String(format:"%04X", cpu.reg.PC)
		cpuRegisterG.stringValue = cpu.digitsToString(cpu.reg.G)
		cpuRegisterT.stringValue = String(format:"%02X", cpu.reg.T)
		let strXST = String(cpu.reg.XST, radix:2)
		cpuRegisterXST.stringValue = strXST.pad(toSize: 4)
		let strST = String(cpu.reg.ST, radix:2)
		cpuRegisterST.stringValue = strST.pad(toSize: 8)
        cpuRegisterR.stringValue = cpu.reg.R == 0 ? "P" : "Q"
        cpuRegisterCarry.stringValue = cpu.reg.carry == 0 ? "T" : "F"
        cpuStack1.stringValue = String(format:"%04X", cpu.reg.stack[0])
        cpuStack2.stringValue = String(format:"%04X", cpu.reg.stack[1])
        cpuStack3.stringValue = String(format:"%04X", cpu.reg.stack[2])
        cpuStack4.stringValue = String(format:"%04X", cpu.reg.stack[3])
        cpuRegisterKY.stringValue = String(format:"%02X", cpu.reg.KY)
        cpuRegisterFI.stringValue = String(format:"%04X", cpu.reg.FI)
        cpuSelectedRAM.stringValue = String(format:"%03X", cpu.reg.ramAddress)
        cpuSelectedPeripheral.stringValue = String(format:"%02X", cpu.reg.peripheral)

        switch cpu.powerMode {
		case .deepSleep:
			cpuPowerMode.stringValue = "D"
		case .lightSleep:
			cpuPowerMode.stringValue = "L"
		case .powerOn:
			cpuPowerMode.stringValue = "P"
		}

		switch cpu.reg.mode {
		case .dec_mode:
			cpuMode.stringValue = "D"
		case .hex_mode:
			cpuMode.stringValue = "H"
		}
	}
	
	func populateDisplayRegisters() {
		if let display = calculatorController.display {
			displayRegisterA.stringValue = display.digits12ToString(display.registers.A)
			displayRegisterB.stringValue = display.digits12ToString(display.registers.B)
			displayRegisterC.stringValue = display.digits12ToString(display.registers.C)
			displayRegisterE.stringValue = NSString(format:"%03X", display.registers.E) as String
		}
	}

	override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
		let segid = segue.identifier ?? "(none)"
		if TRACE != 0 {
			print("\(#function) hit, segue ID = \(segid)")
		}
	}
	
	@IBAction func traceAction(sender: AnyObject) {
        TRACE = traceSwitch.state == NSControl.StateValue.on ? 1 : 0
        UserDefaults.standard.set(TRACE, forKey: "traceActive")
	}

}
