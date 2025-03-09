import SwiftUI

struct AddTaskScreen: View {
    @State private var selectedCategory = "Work"
    @State private var taskTitle = ""
    @State private var taskDescription = ""
    @State private var selectedDate = Date()

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.teal.opacity(0.8), Color.blue.opacity(0.4)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack {
                HeaderView(title: "TO-DO LIST", date: "FEB 16, 2025 | 12:00 AM")

                Text("Add Task").font(.headline).padding()
                    .navigationTitle("Add Task")
                Form {
                    Section(header: Text("Select a Category:")) {
                        Picker("Category", selection: $selectedCategory) {
                            Text("Work").tag("Work")
                            Text("School").tag("School")
                            Text("Business").tag("Business")
                            Text("Personal").tag("Personal")
                            Text("Other").tag("Other")
                        }
                    }

                    Section(header: Text("Enter Details of Task:")) {
                        TextField("Task Title", text: $taskTitle)
                        TextField("Task Description", text: $taskDescription)
                    }

                    Section(header: Text("Select a Priority:")) {
                        HStack {
                            Text("🔴 Urgent")
                            Text("🟡 Important")
                            Text("🟢 Normal")
                            Text("⚪️ Optional")
                        }
                    }

                    Section(header: Text("Select the Date/Time:")) {
                        DatePicker("Due Date", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                    }

                    Section(header: Text("Additional Notes:")) {
                        TextField("Additional Notes", text: .constant(""))
                    }
                }
                .cornerRadius(12)
                .padding(.horizontal, 20)
                Button("Add") { }
                    .buttonStyle(.borderedProminent)
                    .padding()
            }
        }
    }
}
struct AddTaskScreen_Previews: PreviewProvider {
    static var previews: some View{
        AddTaskScreen()
    }
}
