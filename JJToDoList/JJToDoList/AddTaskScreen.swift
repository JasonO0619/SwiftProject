import SwiftUI

struct AddTaskScreen: View {
    @ObservedObject var taskManager: TaskManager
    @Environment(\.presentationMode) var presentationMode

    @State private var title = ""
    @State private var description = ""
    @State private var selectedDate = Date()
    @State private var priority = "Normal"
    @State private var category = "Work"

    let categories = ["Work", "School", "Business", "Personal", "Other"]

    var body: some View {
        Form {
            Section(header: Text("Task Title")) {
                TextField("Enter task title", text: $title)
            }

            Section(header: Text("Task Description")) {
                TextField("Enter description", text: $description)
            }

            Section(header: Text("Category")) {
                Picker("Category", selection: $category) {
                    ForEach(categories, id: \.self) { cat in
                        Text(cat).tag(cat)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }

            Section(header: Text("Priority")) {
                Picker("Priority", selection: $priority) {
                    Text("🔴 Urgent").tag("Urgent")
                    Text("🟡 Important").tag("Important")
                    Text("🟢 Normal").tag("Normal")
                }
                .pickerStyle(SegmentedPickerStyle())
            }

            Section(header: Text("Due Date & Time")) {
                DatePicker("Select Date & Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
            }

            Button("Save Task") {
                let newTask = Task(title: title, description: description, dueDate: selectedDate, priority: priority, category: category)
                taskManager.addTask(newTask)
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationTitle("Add New Task")
    }
}
