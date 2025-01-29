import SwiftUI
import MCStatusDataLayer

@main
struct MCStatusWatchApp_App: App {
    var body: some Scene {
        WindowGroup {
            WatchContentView()
        }
        .modelContainer(SwiftDataHelper.getModelContainter())
    }
}
