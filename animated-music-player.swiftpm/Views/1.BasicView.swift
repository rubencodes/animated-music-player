//
//  BasicView.swift
//  Music ✨
//
//  Created by Ruben Martinez Jr. on 12/11/22.
//

import SwiftUI

struct BasicView: View {
    let track: Track
    let location: CGFloat
    @Binding var isPlaying: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer(minLength: 0)

            AlbumArt(name: track.artwork)
            
            Controls()
        }
    }

    @ViewBuilder
    private func Controls() -> some View {
        VStack(spacing: 8) {
            Title()

            HStack(spacing: 8) {
                PlaybackControls()

                TrackProgress()
            }
        }
    }

    @ViewBuilder
    private func Title() -> some View {
        HStack {
            Spacer(minLength: 0)
            
            Text(track.artist)
                .foregroundColor(.secondary)
                .font(.caption)
                .lineLimit(1)
                .fixedSize()

            Text(track.name)
                .foregroundColor(.primary)
                .font(.caption)
                .bold()
                .lineLimit(1)
                .fixedSize()
        }
    }

    @ViewBuilder
    private func TrackProgress() -> some View {
        HStack {
            Text(location.formatAsTimestamp())
                .monospacedDigit()
                .font(.caption)
                .foregroundColor(.secondary)

            Scrubber(location: location,
                     length: track.length,
                     color: .primary)
            
            Text("-\((track.length - location).formatAsTimestamp())")
                .monospacedDigit()
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }

    @ViewBuilder
    private func PlaybackControls() -> some View {
        Icon(named: "backward.fill", size: 10)
            .foregroundColor(.primary)

        Button(action: { isPlaying.toggle() }) {
            Icon(named: isPlaying ? "pause.fill" : "play.fill",
                 size: 10)
        }
        .frame(width: 12)
        .foregroundColor(.primary)

        Icon(named: "forward.fill", size: 10)
            .foregroundColor(.primary)
    }
}
