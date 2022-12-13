//
//  BlurredBackground.swift
//  Music ✨
//
//  Created by Ruben Martinez Jr. on 12/11/22.
//

import SwiftUI

struct BlurredBackground: View {
    let named: String

    var body: some View {
        Image(named)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .overlay(.ultraThinMaterial)
    }
}
