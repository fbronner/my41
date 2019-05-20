//
//  Calculator.swift
//  my41
//
//  Created by Miroslav Perovic on 2/14/15.
//  Copyright (c) 2015 iPera. All rights reserved.
//

import Foundation

enum CalculatorType {
	case hp41C
	case hp41CV
	case hp41CX
}

extension CalculatorType {
    init(_ int: Int) {
        switch int {
        case 1:
            self = .hp41C
        case 2:
            self = .hp41CV
        default:
            self = .hp41CX
        }
    }

    init(index: Int) {
        self.init(index + 1)
    }

    func asInt() -> Int {
        switch self {
        case .hp41C:
            return 1
        case .hp41CV:
            return 2
        case .hp41CX:
            return 3
        }
    }

    func asIndex() -> Int {
        return asInt() - 1
    }

    func setDefault() {
        UserDefaults.standard.set(asInt(), forKey: "CalculatorType")
    }

    static func getDefault() -> CalculatorType {
        let value = UserDefaults.standard.integer(forKey: "CalculatorType")
        if value == 0 {
            return .hp41CX
        }

        return CalculatorType(value)
    }

}

let MAX_RAM_SIZE		= 0x400
let epromAddress		= 0x4000

let HPPort1 = "ModulePort1"
let HPPort2 = "ModulePort2"
let HPPort3 = "ModulePort3"
let HPPort4 = "ModulePort4"

let HPPrinterAvailable = "PrinterAvailable"
let HPCardReaderAvailable = "CardReaderAvailable"
let HPDisplayDebug = "DisplayDebug"
let HPConsoleForegroundColor = "ConsoleForegroundColor"
let HPConsoleBackgroundColor = "ConsoleBackgroundColor"
let HPResetCalculator = "ResetCalculator"

class Calculator {
	var calculatorMod = MOD()
	var portMod: [MOD?] = [nil, nil, nil, nil]
	var executionTimer: Foundation.Timer?
	var timerModule: Timer?
	var display: Display?
	
	var alphaMode = false
	var prgmMode = false

	init() {
		timerModule = Timer()
		calculatorMod = MOD()

		resetCalculator(restoringMemory: true)
	}
	
	func resetCalculator(restoringMemory: Bool) {
		bus.memModules = 0
		bus.XMemModules = 0
		cpu.setRunning(false)
		cpu.reset()

		bus.removeAllRomChips()
		
		installBuiltinRoms()
		
		installExternalModules()
		emptyRAM()

		if restoringMemory {
			restoreCPU()
			restoreMemory()
		} else {
			let defaults = UserDefaults.standard
			defaults.removeObject(forKey: "cpu")
			defaults.removeObject(forKey: "reg")
			defaults.removeObject(forKey: "memory")
			defaults.synchronize()
		}

		cpu.setRunning(true)
		startExecutionTimer()
	}
	
	func installBuiltinRoms() {
		readCalculatorDescriptionFromDefaults()
		
		let debugSupportRom = RomChip()
		debugSupportRom.writable = true
		debugSupportRom[0] = 0x3E0
		debugSupportRom.writable = false
		bus.installRomChip(
			debugSupportRom,
			inSlot: byte(epromAddress >> 12),
			andBank: byte(0)
		)
		
		if calculatorMod.data != nil {
			// Install ROMs which came with the calculator module
			do {
				try bus.installMod(calculatorMod)
			} catch MODError.freeSpace {
				displayAlert("No free space")
			} catch {
				
			}
		}
	}
	
	func installExternalModules() {
		for idx in 0...3 {
			if portMod[idx]?.data != nil {
				do {
					try bus.installMod(portMod[idx]!)
				} catch MODError.freeSpace {
					displayAlert("No free space")
				} catch {
					
				}
			}
		}
	}
	
	func emptyRAM() {
		bus.ram = [Digits14](repeating: Digits14(), count: MAX_RAM_SIZE)
	}
	
	func startExecutionTimer() {
		cpu.setPowerMode(.powerOn)
		executionTimer = Foundation.Timer.scheduledTimer(
			timeInterval: timeSliceInterval,
			target: self,
			selector: #selector(Calculator.timeSlice(_:)),
			userInfo: nil,
			repeats: true
		)
	}
	
	func saveMemory() {
		let defaults = UserDefaults.standard

		do {
			let data = try JSONEncoder().encode(bus.ram)
			defaults.set(data, forKey: "memory")
			defaults.synchronize()
		} catch {
			print(error)
		}
	}

	func saveCPU() {
		do {
			let defaults = UserDefaults.standard

			let cpu = try JSONEncoder().encode(CPU.sharedInstance)
			defaults.set(cpu, forKey: "cpu")

			let reg = try JSONEncoder().encode(CPU.sharedInstance.reg)
			defaults.set(reg, forKey: "reg")
			defaults.synchronize()
		} catch {
			print(error)
		}
	}

	func restoreMemory() {
		if let data = UserDefaults.standard.object(forKey: "memory") as? Data {
			let decoder = JSONDecoder()
			do {
				bus.ram = try decoder.decode([Digits14].self, from: data)
			} catch {
				print(error)
			}
		}
	}

	func restoreCPU() {
		if let archivedCPU = UserDefaults.standard.object(forKey: "cpu") as? Data {
			let decoder = JSONDecoder()
			do {
				let decoded = try decoder.decode(CPU.self, from: archivedCPU)
				cpu.currentTyte = decoded.currentTyte
				cpu.savedPC = decoded.savedPC
				cpu.lastOpCode = decoded.lastOpCode
				cpu.powerOffFlag = decoded.powerOffFlag
				cpu.opcode = decoded.opcode
				cpu.prevPT = decoded.prevPT
			} catch {
				print(error)
			}
		}
		if let archivedCPURegisters = UserDefaults.standard.object(forKey: "reg") as? Data {
			let decoder = JSONDecoder()
			do {
				let decoded = try decoder.decode(CPURegisters.self, from: archivedCPURegisters)
				cpu.reg.A = decoded.A
				cpu.reg.B = decoded.B
				cpu.reg.C = decoded.C
				cpu.reg.M = decoded.M
				cpu.reg.N = decoded.N
				cpu.reg.P = decoded.P
				cpu.reg.Q = decoded.Q
				cpu.reg.PC = decoded.PC
				cpu.reg.G = decoded.G
				cpu.reg.ST = decoded.ST
				cpu.reg.T = decoded.T
				cpu.reg.FI = decoded.FI
				cpu.reg.XST = decoded.XST
				cpu.reg.stack = decoded.stack
				cpu.reg.R = decoded.R
				cpu.reg.mode = decoded.mode
				cpu.reg.ramAddress = decoded.ramAddress
				cpu.reg.peripheral = decoded.peripheral
			} catch {
				print(error)
			}
		}
	}
	
	private func getMemoryContents() -> [Digits14] {
		var memoryArray = [Digits14](repeating: Digits14(), count: MAX_RAM_SIZE)
		for addr in 0..<MAX_RAM_SIZE {
			do {
				let tmpReg = try bus.readRamAddress(Bits12(addr))
				memoryArray[Int(addr)] = tmpReg
				print("save from \(addr): \(tmpReg)")
			} catch {
				if TRACE != 0 {
					print("error RAM address: \(addr)")
				}
			}
		}

		return memoryArray
	}
	
	func readCalculatorDescriptionFromDefaults() {
		readROMModule()
		
		// Now we fill each port
        let defaults = UserDefaults.standard
		do {
			if let port1 = defaults.string(forKey: HPPort1) {
				portMod[0] = MOD()
				try portMod[0]?.readModFromFile(Bundle.main.resourcePath! + "/" + port1)
			}
			if let port2 = defaults.string(forKey: HPPort2) {
				portMod[1] = MOD()
				try portMod[1]?.readModFromFile(Bundle.main.resourcePath! + "/" + port2)
			}
			if let port3 = defaults.string(forKey: HPPort3) {
				portMod[2] = MOD()
				try portMod[2]?.readModFromFile(Bundle.main.resourcePath! + "/" + port3)
			}
			if let port4 = defaults.string(forKey: HPPort4) {
				portMod[3] = MOD()
				try portMod[3]?.readModFromFile(Bundle.main.resourcePath! + "/" + port4)
			}
		} catch _ {
			
		}
	}
	
    func readROMModule() {
        var filename: String
		switch CalculatorType.getDefault() {
		case .hp41C:
			filename = Bundle.main.resourcePath! + "/" + "nut-c.mod"
		case .hp41CV:
			filename = Bundle.main.resourcePath! + "/" + "nut-cv.mod"
		case .hp41CX:
			filename = Bundle.main.resourcePath! + "/" + "nut-cx.mod"
		}
		
		do {
			try calculatorMod.readModFromFile(filename)
		} catch let error as NSError {
			displayAlert(error.description)
		}
	}
	
	private func digits14FromArray(_ array: [Digit], position: Int) -> Digits14 {
		var to = Digits14()
		for idx in 0...13 {
			to[idx] = array[position + idx]
		}

		return to
	}
	
	@objc func timeSlice(_ timer: Foundation.Timer)
	{
		cpu.timeSlice(timer)
		display?.timeSlice(timer)
		timerModule?.timeSlice(timer)
	}
}
