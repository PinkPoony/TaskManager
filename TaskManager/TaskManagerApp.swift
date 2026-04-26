import SwiftUI
import SwiftData

@main
struct TaskManagerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Task.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashScreenView {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        showSplash = false
                    }
                }
            } else {
                ContentView()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
