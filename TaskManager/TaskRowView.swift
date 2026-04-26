import SwiftUI

struct TaskRowView: View {
    let task: Task

    private static let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .none
        return f
    }()

    var body: some View {
        HStack(spacing: 12) {
            // Цветная полоска слева по приоритету
            RoundedRectangle(cornerRadius: 2)
                .fill(task.priorityColor)
                .frame(width: 4)

            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .firstTextBaseline) {
                    Text(task.title)
                        .font(.headline)
                        .foregroundStyle(task.status == .done ? Color.secondary : (task.isOverdue ? Color.red : Color.primary))
                        .strikethrough(task.status == .done)

                    Spacer()

                    Text(task.priority.rawValue)
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 7)
                        .padding(.vertical, 3)
                        .background(task.priorityColor.opacity(0.15))
                        .foregroundStyle(task.priorityColor)
                        .clipShape(Capsule())
                }

                if let due = task.dueDate {
                    HStack(spacing: 3) {
                        Image(systemName: "calendar")
                        Text("до \(Self.dateFormatter.string(from: due))")
                    }
                    .font(.caption)
                    .foregroundStyle(task.isOverdue ? .red : .secondary)
                }
            }
        }
        .padding(.vertical, 4)
    }
}
