import SwiftUI
import SwiftData

struct TaskListView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: TaskListViewModel?
    @State private var showingAddTask = false

    var body: some View {
        NavigationStack {
            Group {
                if let vm = viewModel {
                    content(vm: vm)
                }
            }
            .navigationTitle("Мои задачи")
        }
        .onAppear {
            if viewModel == nil {
                viewModel = TaskListViewModel(modelContext: modelContext)
            }
        }
    }

    @ViewBuilder
    private func content(vm: TaskListViewModel) -> some View {
        VStack(spacing: 0) {
            statusFilterPicker(vm: vm)
                .padding(.horizontal)
                .padding(.vertical, 8)

            Divider()

            if vm.filteredTasks.isEmpty {
                emptyState
            } else {
                taskList(vm: vm)
            }
        }
        .searchable(text: Bindable(vm).searchText, prompt: "Поиск задач")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showingAddTask = true
                } label: {
                    Label("Добавить", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddTask) {
            AddTaskView(viewModel: vm)
        }
    }

    private func statusFilterPicker(vm: TaskListViewModel) -> some View {
        Picker("Статус", selection: Bindable(vm).selectedStatus) {
            Text("Все").tag(Optional<TaskStatus>.none)
            Text("В работе").tag(Optional(TaskStatus.inProgress))
            Text("Закрытые").tag(Optional(TaskStatus.done))
        }
        .pickerStyle(.segmented)
    }

    private func taskList(vm: TaskListViewModel) -> some View {
        List {
            ForEach(vm.filteredTasks) { task in
                NavigationLink {
                    TaskDetailView(task: task, viewModel: vm)
                } label: {
                    TaskRowView(task: task)
                }
                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                    if task.status != .done {
                        Button {
                            vm.updateStatus(task, status: .done)
                        } label: {
                            Label("Готово", systemImage: "checkmark.circle.fill")
                        }
                        .tint(.green)
                    }
                }
            }
            .onDelete { indexSet in
                for index in indexSet {
                    vm.deleteTask(vm.filteredTasks[index])
                }
            }
        }
        .listStyle(.plain)
        .animation(.default, value: vm.filteredTasks.map(\.id))
    }

    private var emptyState: some View {
        ContentUnavailableView(
            "Задач пока нет",
            systemImage: "checkmark.circle",
            description: Text("Нажмите +, чтобы добавить первую задачу.")
        )
    }
}

#Preview {
    TaskListView()
        .modelContainer(for: Task.self, inMemory: true)
}
