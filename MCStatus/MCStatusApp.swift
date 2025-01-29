import ScrechKit
import MCStatusDataLayer
import AppIntents

@main
struct MCStatusApp: App {
    init() {
        print("Main App Init")
    }
    
    var body: some Scene {
        WindowGroup {
            MainAppContentView()
        }
        .modelContainer(SwiftDataHelper.getModelContainter())
    }
}
