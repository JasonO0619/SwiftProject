import SwiftUI

struct CalendarScreen: View {
    @ObservedObject var taskManager: TaskManager  // Ensure TaskManager is passed
    @State private var showAddTaskPopup = false
    @State private var selectedDate = Date()

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.teal.opacity(0.6), Color.cyan.opacity(0.3)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack {
                HeaderView(title: "TO-DO LIST", date: "FEB 16, 2025 | 12:00 AM")

                Text("Calendar")
                    .font(.headline)
                    .padding(.top, 10)

                DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 3)
                    .padding(.horizontal, 20)

                if taskManager.tasks.filter({ Calendar.current.isDate($0.dueDate, inSameDayAs: selectedDate) }).isEmpty {
                    Text("No tasks assigned for this date.")
                        .foregroundColor(.black)
                        .padding(.top, 10)
                } else {
                    ScrollView {
                        ForEach(taskManager.tasks.filter { Calendar.current.isDate($0.dueDate, inSameDayAs: selectedDate) }) { task in
                            TaskCard(task: task, taskManager: taskManager)
                        }
                    }
                    .padding(.horizontal, 20)
                }

                Spacer()
                
                AddTaskButton(showPopup: $showAddTaskPopup)
            }
        }
        .addPopup(showPopup: $showAddTaskPopup, taskManager: taskManager)  // Fix: Pass taskManager
    }
}

struct CalendarScreen_Previews: PreviewProvider {
    static var previews: some View {
        CalendarScreen(taskManager: TaskManager())  // Ensure preview works
    }
}
