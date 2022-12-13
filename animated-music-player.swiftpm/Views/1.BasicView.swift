//
//  BasicView.swift
//  Music ✨
//
//  Created by Ruben Martinez Jr. on 12/11/22.
//

import SwiftUI

struct BasicView: View {

    // MARK: - Internal Properties

    @StateObject var viewModel: PlayerViewModel

    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer(minLength: 0)

            AlbumArt(track: viewModel.track)
            
            TrackInfo()
        }
    }

    // MARK: - View Builders

    @ViewBuilder
    private func TrackInfo() -> some View {
        if let track = viewModel.track,
           let location = viewModel.location {
            VStack(spacing: 8) {
                Title(track: track)

                HStack(spacing: 8) {
                    PlaybackControls()

                    ProgressView(track: track, location: location)
                }
            }
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
        Button { viewModel.prevTrack() } label: {
            Icon(named: "backward.fill", size: 10)
                .foregroundColor(.primary)
        }

        Button { viewModel.isPlaying.toggle() } label: {
            Icon(named: viewModel.isPlaying ? "pause.fill" : "play.fill",
                 size: 10)
            .foregroundColor(.primary)
        }
        .frame(width: 12)

        Button { viewModel.nextTrack() } label: {
            Icon(named: "forward.fill", size: 10)
                .foregroundColor(.primary)
        }
    }
}
