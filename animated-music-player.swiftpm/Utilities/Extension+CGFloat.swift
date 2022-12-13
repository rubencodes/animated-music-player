//
//  Extension+CGFloat.swift
//  Music ✨
//
//  Created by Ruben Martinez Jr. on 12/11/22.
//

import Foundation

extension CGFloat {
    func formatAsTimestamp() -> String {
        let seconds = "\(Int(self) % 60)".leftPadding(toLength: 2, withPad: "0")
        let minutes = "\(Int(floor(Double(self) / 60)))"

        return "\(minutes):\(seconds)"
    }
}
