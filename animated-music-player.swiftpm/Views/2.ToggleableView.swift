//
//  ToggleableView.swift
//  Music ✨
//
//  Created by Ruben Martinez Jr. on 12/11/22.
//

import SwiftUI

struct ToggleableView: View {
    let track: Track
    let location: CGFloat
    @Binding var isPlaying: Bool

    @State private var isExpanded: Bool = false
    @State private var animationState: CGFloat = .zero

    var body: some View {
        VStack(spacing: 16) {
            Spacer(minLength: 0)

            AlbumArt(name: track.artwork)

            if isExpanded {
                Spacer(minLength: 0)
            }

            Controls()
        }
        .onTapGesture {
            withAnimation {
                isExpanded.toggle()
            }
        }
    }

    private func Controls() -> some View {
        VStack(spacing: isExpanded ? 30 : 8) {
            if isExpanded {
                TitleExpanded()

                TrackProgress()

                HStack(spacing: 50) {
                    Spacer(minLength: 0)

                    PlaybackControls()

                    Spacer(minLength: 0)
                }
            } else {
                Title()

                HStack(spacing: 8) {
                    PlaybackControls()

                    TrackProgress()
                }
            }
        }
    }

    @ViewBuilder
    private func TitleExpanded() -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(track.name)
                    .foregroundColor(.primary)
                    .font(.title3)
                    .bold()
                    .lineLimit(1)
                    .fixedSize()

                Text(track.artist)
                    .foregroundColor(.primary.opacity(0.8))
                    .font(.title3)
                    .lineLimit(1)
                    .fixedSize()
            }

            Spacer(minLength: 0)
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
        VStack {
            HStack {
                if isExpanded == false {
                    Text(location.formatAsTimestamp())
                        .monospacedDigit()
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Scrubber(location: location,
                         length: track.length,
                         color: .primary)

                if isExpanded == false {
                    Text("-\((track.length - location).formatAsTimestamp())")
                        .monospacedDigit()
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            if isExpanded {
                HStack {
                    Text(location.formatAsTimestamp())
                        .monospacedDigit()
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Spacer(minLength: 0)

                    Text("-\((track.length - location).formatAsTimestamp())")
                        .monospacedDigit()
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }

    @ViewBuilder
    private func PlaybackControls() -> some View {
        Icon(named: "backward.fill", size: isExpanded ? 24 : 10)
            .foregroundColor(.primary)

        Button(action: { isPlaying.toggle() }) {
            Icon(named: isPlaying ? "pause.fill" : "play.fill",
                 size: isExpanded ? 40 : 10)
        }
        .scaleEffect(0.5 + (1 - abs(animationState - 0.5)))
        .animationObserver(for: isPlaying ? 1 : 0, currentState: $animationState)
        .frame(width: isExpanded ? 44 : 12)
        .foregroundColor(.primary)

        Icon(named: "forward.fill", size: isExpanded ? 24 : 10)
            .foregroundColor(.primary)
    }
}
