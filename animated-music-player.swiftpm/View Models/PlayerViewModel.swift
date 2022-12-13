//
//  PlayerViewModel.swift
//  Music ✨
//
//  Created by Ruben Martinez Jr. on 12/11/22.
//

import SwiftUI
import Combine

class PlayerViewModel: ObservableObject {

    // MARK: - Internal Properties

    @Published var track: Track?
    @Published var location: CGFloat?
    @Published var isPlaying: Bool

    // MARK: - Private Properties

    private let tracks: [Track]
    private var trackIndex: Int? {
        tracks.firstIndex(where: { $0 == track })
    }
    private var timer: AnyCancellable?
    private var time: Date = .now {
        didSet {
            self.incrementLocation()
        }
    }

    // MARK: - Lifecycle

    init(tracks: [Track]) {
        self.tracks = tracks
        guard let track = tracks.first else {
            isPlaying = false
            return
        }

        self.track = track
        isPlaying = true
        location = .zero
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .receive(on: DispatchQueue.main)
            .assign(to: \.time, on: self)
    }

    // MARK: - Internal Properties

    func prevTrack() {
        guard let trackIndex = trackIndex else {
            return
        }

        let prevIndex = (trackIndex - 1) < 0 ? tracks.count - 1 : trackIndex - 1
        track = tracks[prevIndex]
        location = .zero
    }

    func nextTrack() {
        guard let trackIndex = trackIndex else {
            return
        }

        let nextIndex = (trackIndex + 1) < tracks.count ? trackIndex + 1 : 0
        track = tracks[nextIndex]
        location = .zero
    }

    // MARK: - Private Functions

    private func incrementLocation() {
        guard let track = track,
              let location = location,
              let trackIndex = trackIndex,
              isPlaying else { return }

        let nextLocation = (location + 1)
        let shouldPlayNextTrack = nextLocation > track.length
        if shouldPlayNextTrack {
            let nextTrackIndex = tracks.index(after: trackIndex)
            if nextTrackIndex < tracks.count {
                self.track = tracks[nextTrackIndex]
                self.location = .zero
            } else if let firstTrack = tracks.first {
                self.track = firstTrack
                self.location = .zero
            } else {
                self.track = nil
                self.location = nil
            }
        } else {
            self.location = nextLocation
        }
    }
}
