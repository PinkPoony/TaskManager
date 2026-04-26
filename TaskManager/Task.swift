import Foundation
import SwiftData
import SwiftUI

enum TaskStatus: String, Codable, CaseIterable {
    case inProgress = "В работе"
    case done = "Закрытые"
}

enum Priority: String, Codable, CaseIterable {
    case low = "Низкий"
    case medium = "Средний"
    case high = "Высокий"

    var color: Color {
        switch self {
        case .low:    return .green
        case .medium: return .orange
        case .high:   return .red
        }
    }
}

@Model
final class Task {
    var id: UUID
    var title: String
    var taskDescription: String
    var status: TaskStatus
    var priority: Priority
    var dueDate: Date?
    var createdAt: Date

    init(
        title: String,
        taskDescription: String = "",
        status: TaskStatus = .inProgress,
        priority: Priority = .medium,
        dueDate: Date? = nil
    ) {
        self.id = UUID()
        self.title = title
        self.taskDescription = taskDescription
        self.status = status
        self.priority = priority
        self.dueDate = dueDate
        self.createdAt = Date()
    }

    var isOverdue: Bool {
        guard let dueDate, status != .done else { return false }
        return dueDate < Date()
    }

    var priorityColor: Color { priority.color }
}
