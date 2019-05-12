//
//  Keyboard.swift
//  my41
//
//  Created by Miroslav Perovic on 9/5/14.
//  Copyright (c) 2014 iPera. All rights reserved.
//

import Foundation
import Cocoa
import AVFoundation

final class Keyboard : NSObject {
	@IBOutlet weak var functionGroup: KeyGroup!
	@IBOutlet weak var arithmeticGroup: KeyGroup!
	@IBOutlet weak var numberGroup: KeyGroup!

	@IBOutlet weak var keyOn: Key!
	@IBOutlet weak var keyUser: Key!
	@IBOutlet weak var keyPrgm: Key!
	@IBOutlet weak var keyAlpha: Key!
	
	func keyWithCode(code: Bits8, pressed: Bool) {
		cpu.keyWithCode(code, pressed: pressed)
	}
}

final class KeyGroup : NSView {
	@IBOutlet weak var keyboard: Keyboard!
	
	var audioPlayer:AVAudioPlayer? = nil
	
	override func draw(_ dirtyRect: NSRect) {
		NSColor.clear.setFill()
        dirtyRect.fill()

		
		super.draw(dirtyRect)
	}
	
	func key(key: Key, pressed: Bool) {
        keyboard.keyWithCode(code: key.keyCode, pressed: pressed)

//		if pressed {
//			playSound()
//		}
	}
	
	override var acceptsFirstResponder: Bool { return true }
	
	override func keyDown(with theEvent: NSEvent) {
	}
	
	override func keyUp(with theEvent: NSEvent) {
	}
	
	func playSound() {
		let url = NSURL.fileURL(withPath: Bundle.main.path(forResource: "keyPressSound", ofType: "wav")!)
		
		do {
			audioPlayer = try AVAudioPlayer(contentsOf: url)
		} catch _ as NSError {
			audioPlayer = nil
		}
		audioPlayer?.prepareToPlay()
		audioPlayer?.play()
	}
}
