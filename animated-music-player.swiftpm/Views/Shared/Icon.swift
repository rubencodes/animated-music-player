//
//  Icon.swift
//  Music ✨
//
//  Created by Ruben Martinez Jr. on 12/11/22.
//

import SwiftUI

struct Icon: View {
    let named: String
    let size: CGFloat

    var body: some View {
        Image(systemName: named)
            .resizable()
            .scaledToFit()
            .frame(height: size)
    }
}
