import SwiftUI

// MARK: - Header View
struct HeaderView: View {
    let title: String
    let date: String

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.3), Color.white.opacity(0.9)]),
                           startPoint: .leading,
                           endPoint: .trailing)
                .frame(height: 80)

            HStack {
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)

                Spacer()

                Text(date)
                    .font(.system(size: 18))
                    .foregroundColor(.black.opacity(0.7))
            }
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Task Card (Displays a Single Task)
struct TaskCard: View {
    var task: Task
    @ObservedObject var taskManager: TaskManager

    var body: some View {
        NavigationLink(destination: TaskDetailScreen(task: task, taskManager: taskManager)) {
            VStack(alignment: .leading, spacing: 6) {
                Text(task.title).font(.headline)
                    .foregroundColor(.black)
                Text(task.description).font(.subheadline).foregroundColor(.black)

                HStack {
                    Text("Priority: \(task.priorityIcon) \(task.priority)")
                    Spacer()
                    Text("Due: \(task.dueDate.formatted(date: .abbreviated, time: .shortened))")
                }
                .foregroundColor(.black)
                .font(.caption)

                ProgressView(value: 0.5)
                    .progressViewStyle(LinearProgressViewStyle())
                    .padding(.top, 5)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
        }
    }
}


// MARK: - Full Task Card (Expanded Task View)
struct FullTaskCard: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 8) {
                Text("Task Title")
                    .font(.headline)
                Text("Task Description")
                    .font(.subheadline)
                    .foregroundColor(.black)

                Text("Task Progress:")
                    .font(.caption)
                ProgressView(value: 0.5)
                    .progressViewStyle(LinearProgressViewStyle())
                    .frame(maxWidth: .infinity)

                HStack {
                    Text("Priority:")
                    Text("🔴")
                    Spacer()
                    
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text("Mark as Complete")
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.green)
                        .cornerRadius(8)
                    }

                    HStack {
                        Image(systemName: "calendar")
                        Text("Jun 10, 2025")
                            .foregroundColor(.black)
                    }
                    .padding(.leading, 6)
                }
                .font(.caption)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)

            Button(action: {}) {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.red)
            }
            .padding(10)
        }
    }
}

// MARK: - Add Task Button (Floating Button for Adding Tasks)
struct AddTaskButton: View {
    @Binding var showPopup: Bool

    var body: some View {
        HStack {
            Spacer()
            Button {
                showPopup = true
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.blue)
            }
        }
        .padding()
    }
}

// MARK: - Task Grid View (Displays Tasks in a Grid Format)
struct TaskGridView: View {
    @ObservedObject var taskManager: TaskManager
    @State private var navigateToAddTaskScreen = false

    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            ForEach(taskManager.tasks) { task in
                TaskCard(task: task, taskManager: taskManager)
            }

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
}

// MARK: - Add Task Popup (Quick Add Task Modal)
import SwiftUI

struct AddTaskPopup: View {
    @Binding var showPopup: Bool
    @ObservedObject var taskManager: TaskManager // Task Manager is required

    @State private var taskTitle = ""
    @State private var selectedDate = Date()
    @State private var priority = "Normal"
    @State private var category = "Work"

    let categories = ["Work", "School", "Business", "Personal", "Other"]

    var body: some View {
        VStack {
            Text("Add Quick Task").font(.headline)

            TextField("Task Name", text: $taskTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Picker("Category", selection: $category) {
                ForEach(categories, id: \.self) { cat in
                    Text(cat).tag(cat)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()

            Picker("Priority", selection: $priority) {
                Text("🔴 Urgent").tag("Urgent")
                Text("🟡 Important").tag("Important")
                Text("🟢 Normal").tag("Normal")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            DatePicker("Due Date & Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                .padding()

            Button("Add Task") {
                let newTask = Task(title: taskTitle, description: "", dueDate: selectedDate, priority: priority, category: category)
                taskManager.addTask(newTask) // Saves the task
                showPopup = false // Closes popup
            }
            .buttonStyle(.borderedProminent)
            .padding(.top)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .frame(maxWidth: 300)
    }
}
