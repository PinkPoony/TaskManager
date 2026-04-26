import SwiftUI
import SwiftData

struct TaskDetailView: View {
    let task: Task
    let viewModel: TaskListViewModel

    @Environment(\.dismiss) private var dismiss

    @State private var title: String
    @State private var taskDescription: String
    @State private var priority: Priority
    @State private var status: TaskStatus
    @State private var hasDueDate: Bool
    @State private var dueDate: Date

    init(task: Task, viewModel: TaskListViewModel) {
        self.task = task
        self.viewModel = viewModel
        _title = State(initialValue: task.title)
        _taskDescription = State(initialValue: task.taskDescription)
        _priority = State(initialValue: task.priority)
        _status = State(initialValue: task.status)
        _hasDueDate = State(initialValue: task.dueDate != nil)
        _dueDate = State(initialValue: task.dueDate ?? .now.addingTimeInterval(86400))
    }

    var body: some View {
        NavigationStack {
            Form {
                if task.isOverdue {
                    Section {
                        Label("Просрочено", systemImage: "exclamationmark.circle.fill")
                            .foregroundStyle(.red)
                            .fontWeight(.semibold)
                    }
                }

                Section("Название") {
                    TextField("Название задачи", text: $title)
                }

                Section("Описание") {
                    TextField("Описание", text: $taskDescription, axis: .vertical)
                        .lineLimit(4, reservesSpace: true)
                }

                Section("Приоритет") {
                    Picker("Приоритет", selection: $priority) {
                        ForEach(Priority.allCases, id: \.self) { p in
                            Text(p.rawValue).tag(p)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Статус") {
                    Picker("Статус", selection: $status) {
                        ForEach(TaskStatus.allCases, id: \.self) { s in
                            Text(s.rawValue).tag(s)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Срок выполнения") {
                    Toggle("Установить срок", isOn: $hasDueDate.animation())
                    if hasDueDate {
                        DatePicker(
                            "Срок выполнения",
                            selection: $dueDate,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                    }
                }
            }
            .navigationTitle(task.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") { save() }
                        .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }

    private func save() {
        viewModel.updateTask(
            task,
            title: title.trimmingCharacters(in: .whitespaces),
            description: taskDescription.trimmingCharacters(in: .whitespaces),
            priority: priority,
            status: status,
            dueDate: hasDueDate ? dueDate : nil
        )
        dismiss()
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Task.self, configurations: config)
    let vm = TaskListViewModel(modelContext: container.mainContext)
    let overdueTask = Task(
        title: "Просроченная задача",
        taskDescription: "Описание задачи",
        priority: .high,
        dueDate: .now.addingTimeInterval(-86400)
    )
    container.mainContext.insert(overdueTask)
    return TaskDetailView(task: overdueTask, viewModel: vm)
}
