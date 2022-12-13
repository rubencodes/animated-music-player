//
//  Icon.swift
//  Music ✨
//
//  Created by Ruben Martinez Jr. on 12/11/22.
//

import SwiftUI

struct Icon: View {

    // MARK: - Internal Properties

    let named: String
    let size: CGFloat

    // MARK: - Body

    var body: some View {
        Image(systemName: named)
            .resizable()
            .scaledToFit()
            .frame(height: size)
    }
}
