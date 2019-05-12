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
        return self[self.index(startIndex, offsetBy: integerIndex)]
    }

    func pad(with string: String = "0", toSize: Int) -> String {
        var padded = self
        for _ in 0..<toSize - count {
            padded = string + padded
        }

        return padded
    }

}
