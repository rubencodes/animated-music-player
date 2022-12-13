//
//  Artwork.swift
//  Music ✨
//
//  Created by Ruben Martinez Jr. on 12/11/22.
//

import SwiftUI

struct AlbumArt: View {
    let name: String

    var body: some View {
        Image(name)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(12)
    }
}
