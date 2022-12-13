//
//  ObservedView.swift
//  Music ✨
//
//  Created by Ruben Martinez Jr. on 12/11/22.
//

import SwiftUI

struct ObservedView: View {

    // MARK: - Internal Properties

    @StateObject var viewModel: PlayerViewModel

    // MARK: - Private Properties

    @State private var isExpanded: Bool = false
    @State private var isAnimatingPrev: Bool = false
    @State private var prevAnimationState: CGFloat = .zero
    @State private var isAnimatingNext: Bool = false
    @State private var nextAnimationState: CGFloat = .zero
    @Namespace private var contentView
    private enum ViewID: String {
        case backwardButton
        case playPauseToggle
        case forwardButton

        case track
        case artist

        case scrubber
        case scrubberLocation
        case scrubberRemaining
    }

    // MARK: - Body

    var body: some View {
        VStack(spacing: 16) {
            Spacer(minLength: 0)

            AlbumArt(track: viewModel.track)
                .shadow(radius: isExpanded ? 10 : 0)
                .opacity(isExpanded ? 1 : 0.5)
                .rotation3DEffect(isExpanded ? .degrees(180) : .zero,
                                  axis: (x: 0, y: 1, z: 0))
                .scaleEffect(isExpanded ? 1.1 : 0.9)
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
            VStack(alignment: .leading, spacing: isExpanded ? 30 : 8) {
                if isExpanded {
                    TitleVertical(track: track)

                    ProgressView(location: location,
                                 length: track.length)

                    HStack(spacing: 50) {
                        Spacer(minLength: 0)

                        PlaybackControls()

                        Spacer(minLength: 0)
                    }
                } else {
                    TitleHorizontal(track: track)

                    HStack(spacing: 8) {
                        PlaybackControls()

                        ProgressView(location: location,
                                     length: track.length)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func TitleVertical(track: Track) -> some View {
        VStack(alignment: .leading) {
            Text(track.name)
                .foregroundColor(.primary)
                .font(.title3)
                .bold()
                .lineLimit(1)
                .fixedSize()
                .matchedGeometryEffect(id: ViewID.track.rawValue,
                                       in: contentView)

            Text(track.artist)
                .foregroundColor(.secondary)
                .font(.title3)
                .lineLimit(1)
                .fixedSize()
                .matchedGeometryEffect(id: ViewID.artist.rawValue,
                                       in: contentView)
        }
    }

    @ViewBuilder
    private func TitleHorizontal(track: Track) -> some View {
        HStack(spacing: 4) {
            Spacer(minLength: 0)

            Text(track.artist)
                .foregroundColor(.secondary)
                .font(.caption)
                .lineLimit(1)
                .fixedSize()
                .matchedGeometryEffect(id: ViewID.artist.rawValue,
                                       in: contentView)

            Text(track.name)
                .foregroundColor(.primary)
                .font(.caption)
                .bold()
                .lineLimit(1)
                .fixedSize()
                .matchedGeometryEffect(id: ViewID.track.rawValue,
                                       in: contentView)
        }
    }

    @ViewBuilder
    private func ProgressView(location: CGFloat,
                              length: CGFloat) -> some View {
        VStack {
            HStack {
                if isExpanded == false {
                    Text(location.formatAsTimestamp())
                        .monospacedDigit()
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .matchedGeometryEffect(id: ViewID.scrubberLocation.rawValue,
                                               in: contentView)
                }

                Scrubber(location: location,
                         length: length,
                         color: .primary)
                .matchedGeometryEffect(id: ViewID.scrubber.rawValue,
                                       in: contentView)

                if isExpanded == false {
                    Text("-\((length - location).formatAsTimestamp())")
                        .monospacedDigit()
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .matchedGeometryEffect(id: ViewID.scrubberRemaining.rawValue,
                                               in: contentView)
                }
            }

            if isExpanded {
                HStack {
                    Text(location.formatAsTimestamp())
                        .monospacedDigit()
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .matchedGeometryEffect(id: ViewID.scrubberLocation.rawValue,
                                               in: contentView)

                    Spacer(minLength: 0)

                    Text("-\((length - location).formatAsTimestamp())")
                        .monospacedDigit()
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .matchedGeometryEffect(id: ViewID.scrubberRemaining.rawValue,
                                               in: contentView)
                }
            }
        }
    }

    @ViewBuilder
    private func PlaybackControls() -> some View {
        Button {
            withAnimation { isAnimatingPrev = true }
            viewModel.prevTrack()
        } label: {
            Icon(named: "backward.fill", size: isExpanded ? 24 : 10)
                .foregroundColor(.primary)
        }
        .scaleEffect((1.5 - abs(prevAnimationState - 0.5)))
        .animationObserver(for: isAnimatingPrev ? 1 : 0,
                           currentState: $prevAnimationState) { _ in
            isAnimatingPrev = false
        }
        .matchedGeometryEffect(id: ViewID.backwardButton.rawValue,
                               in: contentView)

        Button { viewModel.isPlaying.toggle() } label: {
            Icon(named: viewModel.isPlaying ? "pause.fill" : "play.fill",
                 size: isExpanded ? 40 : 10)
            .foregroundColor(.primary)
        }
        .frame(width: isExpanded ? 44 : 12)
        .matchedGeometryEffect(id: ViewID.playPauseToggle.rawValue,
                               in: contentView)

        Button {
            withAnimation { isAnimatingNext = true }
            viewModel.nextTrack()
        } label: {
            Icon(named: "forward.fill", size: isExpanded ? 24 : 10)
                .foregroundColor(.primary)
        }
        .scaleEffect((1.5 - abs(nextAnimationState - 0.5)))
        .animationObserver(for: isAnimatingNext ? 1 : 0,
                           currentState: $nextAnimationState) { _ in
            isAnimatingNext = false
        }
        .matchedGeometryEffect(id: ViewID.forwardButton.rawValue,
                               in: contentView)
    }
}
