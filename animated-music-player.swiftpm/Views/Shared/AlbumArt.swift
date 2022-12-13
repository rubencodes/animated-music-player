//
//  Artwork.swift
//  Music ✨
//
//  Created by Ruben Martinez Jr. on 12/11/22.
//

import SwiftUI

struct AlbumArt: View {

    // MARK: - Internal Properties

    let track: Track?

    // MARK: - Body

    var body: some View {
        Image(track?.artwork ?? "unknown")
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(12)
    }
}
