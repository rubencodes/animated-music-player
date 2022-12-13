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
        TabView {
            BasicView(viewModel: viewModel)
                .padding(.horizontal, 30)
                .padding(.vertical, 40)
                .background(BlurredBackground(named: viewModel.track?.background))
                .tabItem {
                    Label("Basic", systemImage: "1.circle.fill")
                }

            ToggleableView(viewModel: viewModel)
                .padding(.horizontal, 30)
                .padding(.vertical, 40)
                .background(BlurredBackground(named: viewModel.track?.background))
                .tabItem {
                    Label("Expand", systemImage: "2.circle.fill")
                }

            MatchedView(viewModel: viewModel)
                .padding(.horizontal, 30)
                .padding(.vertical, 40)
                .background(BlurredBackground(named: viewModel.track?.background))
                .tabItem {
                    Label("Match", systemImage: "3.circle.fill")
                }

            ObservedView(viewModel: viewModel)
                .padding(.horizontal, 30)
                .padding(.vertical, 40)
                .background(BlurredBackground(named: viewModel.track?.background))
                .tabItem {
                    Label("Observe", systemImage: "4.circle.fill")
                }
        }
        .tint(.primary)
    }
}
