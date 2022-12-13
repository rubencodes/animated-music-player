//
//  PlayerViewModel.swift
//  Music ✨
//
//  Created by Ruben Martinez Jr. on 12/11/22.
//

import SwiftUI
import Combine

class PlayerViewModel: ObservableObject {
    @Published var track: Track?
    @Published var location: CGFloat?
    @Published var isPlaying: Bool

    private let tracks: [Track]
    private var timer: AnyCancellable?
    private var time: Date = .now {
        didSet {
            incrementLocation()
        }
    }

    init(tracks: [Track]) {
        self.tracks = tracks
        guard let track = tracks.first else {
            self.isPlaying = false
            return
        }

        self.track = track
        self.isPlaying = true
        self.location = .zero
        self.timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .receive(on: DispatchQueue.main)
            .assign(to: \.time, on: self)
    }

    private func incrementLocation() {
        guard let track = track,
              let location = location,
              let trackIndex = tracks.firstIndex(where: { $0 == track }),
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
