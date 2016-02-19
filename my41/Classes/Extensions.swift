//
//  Extensions.swift
//  i41CV
//
//  Created by Miroslav Perovic on 8/14/14.
//  Copyright (c) 2014 iPera. All rights reserved.
//

import Foundation

extension String {
	subscript(integerIndex: Int) -> Character {
		let index = self.startIndex.advancedBy(integerIndex)
//		let index = advance(startIndex, integerIndex)
			return self[index]
	}
	
	subscript(integerRange: Range<Int>) -> String {
		let start = self.startIndex.advancedBy(integerRange.startIndex)
		let end = self.startIndex.advancedBy(integerRange.endIndex)
//		let start = advance(startIndex, integerRange.startIndex)
//		let end = advance(startIndex, integerRange.endIndex)
		let range = start..<end
		return self[range]
	}
}
