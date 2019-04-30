//
//  RomChip.swift
//  my41
//
//  Created by Miroslav Perovic on 8/1/14.
//  Copyright (c) 2014 iPera. All rights reserved.
//

import Foundation

final class RomChip {
	var writable: Bool
	var words: [word]
	var actualBankGroup: byte
	var altPage: ModulePage?
	var HEPAX: UInt8 = 0
	var WWRAMBOX: UInt8 = 0
	var RAM: byte = 0
	
	init(isWritable: Bool) {
		words = [word](repeating: 0x0, count: 0x1000)
		writable = isWritable
		actualBankGroup = 1
	}

	convenience init(fromBIN bin: [byte], actualBankGroup bankGroup: byte) {
        self.init(isWritable: false)
		binToWords(bin)
		actualBankGroup = bankGroup
	}

	convenience init(fromFile path: String) {
        self.init(isWritable: false)
		loadFromFile(path)
	}
	
	convenience init() {
        self.init(isWritable: false)
	}
	
	func binToWords(_ bin: [byte]) {
		if bin.count == 0 {
			return
		}
		
		var ptr: Int = 0
//		for var idx = 0; idx < 5120; idx += 5 {
		for idx in stride(from: 0, to: 5120, by: 5) {
			words[ptr] = word(((word(bin[idx+1]) & 0x03) << 8) | word(bin[idx]))
			ptr += 1
			words[ptr] = word(((word(bin[idx+2]) & 0x0f) << 6) | ((word(bin[idx+1]) & 0xfc) >> 2))
			ptr += 1
			words[ptr] = word(((word(bin[idx+3]) & 0x3f) << 4) | ((word(bin[idx+2]) & 0xf0) >> 4))
			ptr += 1
			words[ptr] = word((word(bin[idx+4]) << 2) | ((word(bin[idx+3]) & 0xc0) >> 6))
			ptr += 1
		}
	}
	
	func loadFromFile(_ path: String) {
		let data: Data?
		do {
			data = try Data(contentsOf: URL(fileURLWithPath: path), options: [.mappedIfSafe])
			
//			var range = NSRange(location: 0, length: 2)
			var location = 0
			for idx in 0..<0x1000 {
				var i16be: UInt16 = 0
				var i16: UInt16 = 0
				let buffer = UnsafeMutableBufferPointer(start: &i16be, count: 2)
				let _ = data?.copyBytes(to: buffer, from: location..<location+2)
//				data?.getBytes(&i16be, range: range)
				location += 2
				i16 = UInt16(bigEndian: i16be)
				
				words[idx] = i16
			}
		} catch _ {
			data = nil
		}
	}
	
	subscript(addr: Int) -> UInt16 {
		get {
			return words[addr]
		}
		
		set {
			if writable {
				words[addr] = newValue
			}
		}
	}
}
