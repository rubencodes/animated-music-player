//
//  MainView.swift
//  Music ✨
//
//  Created by Ruben Martinez Jr. on 12/12/22.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel: PlayerViewModel

    var body: some View {
        if let track = viewModel.track,
           let location = viewModel.location {
            TabView {
                BasicView(track: track,
                          location: location,
                          isPlaying: $viewModel.isPlaying)
                .padding(.horizontal, 30)
                .padding(.vertical, 40)
                .background(BlurredBackground(named: track.background))
                .tabItem {
                    Label("Basic", systemImage: "1.circle.fill")
                }

                ToggleableView(track: track,
                               location: location,
                               isPlaying: $viewModel.isPlaying)
                .padding(.horizontal, 30)
                .padding(.vertical, 40)
                .background(BlurredBackground(named: track.background))
                .tabItem {
                    Label("Expand", systemImage: "2.circle.fill")
                }

                MatchedView(track: track,
                            location: location,
                            isPlaying: $viewModel.isPlaying)
                .padding(.horizontal, 30)
                .padding(.vertical, 40)
                .background(BlurredBackground(named: track.background))
                .tabItem {
                    Label("Match", systemImage: "3.circle.fill")
                }

                ObservedView(track: track,
                             location: location,
                             isPlaying: $viewModel.isPlaying)
                .padding(.horizontal, 30)
                .padding(.vertical, 40)
                .background(BlurredBackground(named: track.background))
                .tabItem {
                    Label("Observe", systemImage: "4.circle.fill")
                }
            }
            .tint(.primary)
        }
    }
}
