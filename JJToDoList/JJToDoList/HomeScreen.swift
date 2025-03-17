import SwiftUI

struct HomeScreen: View {
    @ObservedObject var taskManager: TaskManager
    @State private var showAddTaskPopup = false
    @State private var navigateToAddTaskScreen = false
    @State private var selectedCategory: String = "All"

    let categories = ["All", "Work", "School", "Business", "Personal", "Other"]

    var filteredTasks: [Task] {
        if selectedCategory == "All" {
            return taskManager.tasks
        } else {
            return taskManager.tasks.filter { $0.category == selectedCategory }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.teal.opacity(0.6), Color.cyan.opacity(0.3)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                VStack {
                    HeaderView(title: "TO-DO LIST", date: Date().formatted(date: .abbreviated, time: .omitted))

                    // Category Filter Section
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(categories, id: \.self) { category in
                                Button(action: {
                                    selectedCategory = category
                                }) {
                                    Text(category)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(selectedCategory == category ? Color.white : Color.clear)
                                        .cornerRadius(8)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            ForEach(filteredTasks) { task in
                                TaskCard(task: task, taskManager: taskManager)
                            }

                            // "Add a full task" button
                            Button(action: {
                                navigateToAddTaskScreen = true
                            }) {
                                VStack {
                                    Text("+ Add a full task")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                }
                                .frame(height: 100)
                                .frame(maxWidth: .infinity)
                                .background(Color.white.opacity(0.3))
                                .cornerRadius(12)
                                .shadow(radius: 3)
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.black, style: StrokeStyle(lineWidth: 1, dash: [5])))
                            }
                        }
                        .padding()
                    }

                    Spacer()
                    AddTaskButton(showPopup: $showAddTaskPopup)
                }
            }
            .addPopup(showPopup: $showAddTaskPopup, taskManager: taskManager)
            .navigationDestination(isPresented: $navigateToAddTaskScreen) {
                AddTaskScreen(taskManager: taskManager)  // Navigate to full task screen
            }
        }
    }
}
