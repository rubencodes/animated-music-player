import SwiftUI

@main
struct Player: App {
    @ObservedObject private var viewModel: PlayerViewModel = .init(tracks: [
        .init(name: "Picture to Burn",
              artist: "Taylor Swift",
              length: 175,
              artwork: "taylor-swift",
              background: "taylor-swift"),
        .init(name: "Love Story",
              artist: "Taylor Swift",
              length: 237,
              artwork: "fearless",
              background: "fearless"),
        .init(name: "Long Live",
              artist: "Taylor Swift",
              length: 317,
              artwork: "speak-now",
              background: "speak-now"),
        .init(name: "All Too Well (Taylor's Version)",
              artist: "Taylor Swift",
              length: 615,
              artwork: "red",
              background: "red"),
        .init(name: "Clean",
              artist: "Taylor Swift",
              length: 270,
              artwork: "1989",
              background: "1989"),
        .init(name: "New Year's Day",
              artist: "Taylor Swift",
              length: 235,
              artwork: "reputation",
              background: "reputation"),
        .init(name: "The Archer",
              artist: "Taylor Swift",
              length: 211,
              artwork: "lover",
              background: "lover"),
        .init(name: "Mirrorball",
              artist: "Taylor Swift",
              length: 209,
              artwork: "folklore",
              background: "folklore"),
        .init(name: "No Body, No Crime",
              artist: "Taylor Swift (feat. HAIM)",
              length: 215,
              artwork: "evermore",
              background: "evermore"),
        .init(name: "Anti-Hero",
              artist: "Taylor Swift",
              length: 200,
              artwork: "midnights",
              background: "midnights"),
    ].reversed())

    var body: some Scene {
        WindowGroup {
            MainView(viewModel: viewModel)
                .environment(\.colorScheme, .dark)
        }
    }
}
