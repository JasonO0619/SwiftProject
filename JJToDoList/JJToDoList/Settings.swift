import SwiftUI

struct SettingsScreen: View {
    @ObservedObject var taskManager: TaskManager  // Ensure TaskManager is available

    @State private var isLightMode = true
    @State private var autoRemove = false
    @State private var notifications = false
    @State private var showAddTaskPopup = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.teal.opacity(0.6), Color.cyan.opacity(0.3)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack {
                HeaderView(title: "TO-DO LIST", date: "FEB 16, 2025 | 12:00 AM")

                Text("Settings")
                    .font(.headline)
                    .padding(.top, 10)

                Form {
                    Section {
                        Toggle("Light Mode", isOn: $isLightMode)
                        Toggle("Automatic remove when completed", isOn: $autoRemove)
                        Toggle("Notifications", isOn: $notifications)
                    }
                }
                .frame(maxHeight: 220)
                .cornerRadius(12)
                .padding(.horizontal, 20)

                Spacer()

                AddTaskButton(showPopup: $showAddTaskPopup)
            }
        }
        .addPopup(showPopup: $showAddTaskPopup, taskManager: taskManager)  // Pass taskManager here
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen(taskManager: TaskManager())  // Ensure preview works
    }
}
