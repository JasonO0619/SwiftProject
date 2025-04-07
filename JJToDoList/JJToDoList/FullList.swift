import SwiftUI

struct FullListScreen: View {
    @ObservedObject var taskManager: TaskManager
    @State private var searchText = ""
    @State private var showAddTaskPopup = false
    @State private var selectedTask: Task? = nil

    var filteredTasks: [Task] {
        if searchText.isEmpty {
            return taskManager.tasks
        } else {
            return taskManager.tasks.filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.teal.opacity(0.6), Color.cyan.opacity(0.3)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack {
                    // Header
                    HStack {
                        Text("TO-DO LIST")
                            .font(.title)
                            .bold()

                        Spacer()

                        Text(Date().formatted(date: .long, time: .shortened))
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)

                    // Search bar
                    TextField("Enter task here...", text: $searchText)
                        .padding(8)
                        .background(Color.white.opacity(0.4))
                        .cornerRadius(8)
                        .padding(.horizontal)

                    // List with swipe-to-delete
                    List {
                        ForEach(filteredTasks) { task in
                            Button {
                                selectedTask = task
                            } label: {
                                TaskCard(task: task, taskManager: taskManager)
                                    .listRowInsets(EdgeInsets())
                                    .background(Color.clear)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let taskToDelete = filteredTasks[index]
                                if let realIndex = taskManager.tasks.firstIndex(where: { $0.id == taskToDelete.id }) {
                                    taskManager.tasks.remove(at: realIndex)
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)// ✅ removes white bg under List
                    .background(Color.clear)
                    
                    Spacer()

                    AddTaskButton(showPopup: $showAddTaskPopup)
                }
            }
            .addPopup(showPopup: $showAddTaskPopup, taskManager: taskManager)
            .navigationDestination(item: $selectedTask) { task in
                TaskDetailScreen(task: task, taskManager: taskManager)
            }
        }
    }
}
