//
//  ToggleableView.swift
//  Music ✨
//
//  Created by Ruben Martinez Jr. on 12/11/22.
//

import SwiftUI

struct ToggleableView: View {

    // MARK: - Internal Properties

    @StateObject var viewModel: PlayerViewModel

    // MARK: - Private Properties

    @State private var isExpanded: Bool = false

    // MARK: - Body

    var body: some View {
        VStack(spacing: 16) {
            Spacer(minLength: 0)

            AlbumArt(track: viewModel.track)
                .onTapGesture {
                    withAnimation(.spring()) {
                        isExpanded.toggle()
                    }
                }

            if isExpanded {
                Spacer(minLength: 0)
            }

            TrackInfo()
        }
    }

    // MARK: - View Builders

    @ViewBuilder
    private func TrackInfo() -> some View {
        if let track = viewModel.track,
           let location = viewModel.location {
            VStack(spacing: isExpanded ? 30 : 8) {
                if isExpanded {
                    TitleExpanded(track: track)

                    ProgressView(track: track, location: location)

                    HStack(spacing: 50) {
                        Spacer(minLength: 0)

                        PlaybackControls()

                        Spacer(minLength: 0)
                    }
                } else {
                    Title(track: track)

                    HStack(spacing: 8) {
                        PlaybackControls()

                        ProgressView(track: track, location: location)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func TitleExpanded(track: Track) -> some View {
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
    private func Title(track: Track) -> some View {
        HStack(spacing: 4) {
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
    private func ProgressView(track: Track,
                              location: CGFloat) -> some View {
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
        Button { viewModel.prevTrack() } label: {
            Icon(named: "backward.fill", size: isExpanded ? 24 : 10)
                .foregroundColor(.primary)
        }

        Button { viewModel.isPlaying.toggle() } label: {
            Icon(named: viewModel.isPlaying ? "pause.fill" : "play.fill",
                 size: isExpanded ? 40 : 10)
            .foregroundColor(.primary)
        }
        .frame(width: isExpanded ? 44 : 12)

        Button { viewModel.nextTrack() } label: {
            Icon(named: "forward.fill", size: isExpanded ? 24 : 10)
                .foregroundColor(.primary)
        }
    }
}
