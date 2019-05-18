//
//  CocoaSpecific.swift
//  my41
//
//  Created by Miroslav Perovic on 2/7/15.
//  Copyright (c) 2015 iPera. All rights reserved.
//

import Foundation
import Cocoa

func displayAlert(_ message: String) {
    let alert = NSAlert()
    alert.messageText = message
    alert.runModal()
}

extension String {

    func attributedString(color: NSColor? = nil, font: NSFont? = NSFont(name: "Helvetica", size: 11.0)) -> NSMutableAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [:]
        if let font = font {
            attributes[.font] = font
        }
        if let color = color {
            attributes[.foregroundColor] = color
        }
        return NSMutableAttributedString(string: self, attributes: attributes)

    }

}
