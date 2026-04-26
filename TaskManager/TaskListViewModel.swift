import Foundation
import SwiftData
import Observation

@Observable
final class TaskListViewModel {
    var tasks: [Task] = []
    var searchText: String = ""
    var selectedStatus: TaskStatus? = nil
    var selectedPriority: Priority? = nil

    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchTasks()
    }

    var filteredTasks: [Task] {
        tasks
            .filter { task in
                if !searchText.isEmpty {
                    let query = searchText.lowercased()
                    guard task.title.lowercased().contains(query)
                       || task.taskDescription.lowercased().contains(query)
                    else { return false }
                }
                if let status = selectedStatus, task.status != status { return false }
                if let priority = selectedPriority, task.priority != priority { return false }
                return true
            }
            .sorted { $0.createdAt > $1.createdAt }
    }

    func addTask(
        title: String,
        description: String = "",
        priority: Priority = .medium,
        dueDate: Date? = nil
    ) {
        let task = Task(
            title: title,
            taskDescription: description,
            priority: priority,
            dueDate: dueDate
        )
        modelContext.insert(task)
        save()
    }

    func deleteTask(_ task: Task) {
        modelContext.delete(task)
        save()
    }

    func updateStatus(_ task: Task, status: TaskStatus) {
        task.status = status
        save()
    }

    func updateTask(
        _ task: Task,
        title: String,
        description: String,
        priority: Priority,
        status: TaskStatus,
        dueDate: Date?
    ) {
        task.title = title
        task.taskDescription = description
        task.priority = priority
        task.status = status
        task.dueDate = dueDate
        save()
    }

    // MARK: - Private

    private func fetchTasks() {
        let descriptor = FetchDescriptor<Task>(
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        tasks = (try? modelContext.fetch(descriptor)) ?? []
    }

    private func save() {
        try? modelContext.save()
        fetchTasks()
    }
}
