import SwiftUI

@main
struct Player: App {
    @ObservedObject private var viewModel: PlayerViewModel = .init(tracks: [
        .init(name: "All Too Well (Taylor's Version)",
              artist: "Taylor Swift",
              length: 615,
              artwork: "red_tv",
              background: "autumn"),
    ])

    var body: some Scene {
        WindowGroup {
            MainView(viewModel: viewModel)
                .environment(\.colorScheme, .dark)
        }
    }
}
