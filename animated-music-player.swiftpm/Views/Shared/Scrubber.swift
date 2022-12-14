//
//  Scrubber.swift
//  Music ✨
//
//  Created by Ruben Martinez Jr. on 12/11/22.
//

import SwiftUI

struct Scrubber: View {

    // MARK: - Internal Properties

    let location: CGFloat
    let length: CGFloat
    let color: Color

    // MARK: - Private Properties

    private let cornerRadius = 4.0
    private var percentFull: CGFloat {
        location / length
    }

    // MARK: - Body

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .foregroundColor(.secondary.opacity(0.4))
            .frame(maxWidth: .infinity)
            .frame(height: 4)
            .overlay(
                GeometryReader { proxy in
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .foregroundColor(color)
                        .frame(width: percentFull * proxy.size.width)
                }
            )
    }
}
