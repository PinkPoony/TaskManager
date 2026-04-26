import SwiftUI
import SwiftData

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss

    let viewModel: TaskListViewModel

    @State private var title: String = ""
    @State private var description: String = ""
    @State private var priority: Priority = .medium
    @State private var showDatePicker: Bool = false
    @State private var dueDate: Date = .now.addingTimeInterval(86400)

    var body: some View {
        NavigationStack {
            Form {
                Section("Название задачи") {
                    TextField("Название задачи", text: $title)
                }

                Section("Описание") {
                    TextField("Описание", text: $description, axis: .vertical)
                        .lineLimit(4, reservesSpace: true)
                }

                Section("Приоритет") {
                    Picker("Приоритет", selection: $priority) {
                        ForEach(Priority.allCases, id: \.self) { p in
                            HStack {
                                Circle()
                                    .fill(p.color)
                                    .frame(width: 8, height: 8)
                                Text(p.rawValue)
                            }
                            .tag(p)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Срок выполнения") {
                    Toggle("Установить срок", isOn: $showDatePicker.animation())
                    if showDatePicker {
                        DatePicker(
                            "Срок выполнения",
                            selection: $dueDate,
                            in: Date.now...,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                    }
                }
            }
            .navigationTitle("Новая задача")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") { save() }
                        .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }

    private func save() {
        viewModel.addTask(
            title: title.trimmingCharacters(in: .whitespaces),
            description: description.trimmingCharacters(in: .whitespaces),
            priority: priority,
            dueDate: showDatePicker ? dueDate : nil
        )
        dismiss()
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Task.self, configurations: config)
    let vm = TaskListViewModel(modelContext: container.mainContext)

    return AddTaskView(viewModel: vm)
}
