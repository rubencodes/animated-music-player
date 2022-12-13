//
//  Extension+String.swift
//  Music ✨
//
//  Created by Ruben Martinez Jr. on 12/11/22.
//

import Foundation

extension String {
    func leftPadding(toLength: Int, withPad character: Character) -> String {
        let newLength = count
        if newLength < toLength {
            return String(repeatElement(character, count: toLength - newLength)) + self
        }

        return self
    }
}

