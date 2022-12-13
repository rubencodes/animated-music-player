//
//  BlurredBackground.swift
//  Music ✨
//
//  Created by Ruben Martinez Jr. on 12/11/22.
//

import SwiftUI

struct BlurredBackground: View {

    // MARK: - Internal Properties

    let named: String?

    // MARK: - Body

    var body: some View {
        Image(named ?? "unknownBackground")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .overlay(.ultraThinMaterial)
    }
}
