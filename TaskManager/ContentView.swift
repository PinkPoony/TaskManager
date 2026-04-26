import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TaskListView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Task.self, inMemory: true)
}
