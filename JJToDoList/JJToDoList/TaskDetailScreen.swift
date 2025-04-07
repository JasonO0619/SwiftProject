import SwiftUI

struct TaskDetailScreen: View {
    @State var task: Task
    @ObservedObject var taskManager: TaskManager
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            Section(header: Text("Task Title")) {
                TextField("Enter task title", text: $task.title)
            }
            
            Section(header: Text("Task Description")) {
                TextField("Enter description", text: $task.description)
            }
            
            Section(header: Text("Priority")) {
                Picker("Priority", selection: $task.priority) {
                    Text("🔴 Urgent").tag("Urgent")
                    Text("🟡 Important").tag("Important")
                    Text("🟢 Normal").tag("Normal")
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Due Date")) {
                DatePicker("Select Date", selection: $task.dueDate, displayedComponents: [.date])
            }
            
            Button("Update Task") {
                taskManager.updateTask(task)
                presentationMode.wrappedValue.dismiss()
            }
            
            Button("Delete/Complete Task", role: .destructive) {
                taskManager.removeTask(task)
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationTitle("Edit Task")
    }
}
