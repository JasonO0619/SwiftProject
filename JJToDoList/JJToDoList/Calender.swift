import SwiftUI

struct CalendarScreen: View {
    @ObservedObject var taskManager: TaskManager
    @State private var showAddTaskPopup = false
    @State private var selectedDate = Date()
    @State private var selectedTask: Task? = nil

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

                    // Title
                    Text("Calendar")
                        .font(.headline)
                        .padding(.top, 10)

                    // Date Picker
                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 3)
                        .padding(.horizontal, 20)

                    // Tasks for selected date
                    let tasksForDate = taskManager.tasks.filter {
                        Calendar.current.isDate($0.dueDate, inSameDayAs: selectedDate)
                    }

                    if tasksForDate.isEmpty {
                        Text("No tasks assigned for this date.")
                            .foregroundColor(.black)
                            .padding(.top, 10)
                    } else {
                        ScrollView {
                            ForEach(tasksForDate) { task in
                                Button {
                                    selectedTask = task
                                } label: {
                                    TaskCard(task: task, taskManager: taskManager)
                                }
                                .buttonStyle(PlainButtonStyle()) // Prevents default blue tap effect
                            }
                        }
                        .padding(.horizontal, 20)
                    }

                    Spacer()

                    AddTaskButton(showPopup: $showAddTaskPopup)
                }
            }
            .addPopup(showPopup: $showAddTaskPopup, taskManager: taskManager)

            // Navigation to Task Detail screen
            .navigationDestination(item: $selectedTask) { task in
                TaskDetailScreen(task: task, taskManager: taskManager)
            }
        }
    }
}

struct CalendarScreen_Previews: PreviewProvider {
    static var previews: some View {
        CalendarScreen(taskManager: TaskManager())
    }
}
