import SwiftUI
import UserNotifications

struct SettingsScreen: View {
    @ObservedObject var taskManager = TaskManager()

    @AppStorage("isLightMode") private var isLightMode = true
    @State private var notificationsEnabled = false

    @AppStorage("reminderOffsetMinutes") private var reminderOffsetMinutes: Int = 10
    @State private var showClearAlert = false

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.teal.opacity(0.6), Color.cyan.opacity(0.3)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 20) {
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

                    Text("Settings")
                        .font(.headline)
                        .padding(.top, 10)

                    VStack(spacing: 0) {
                        // Light Mode Toggle
                        Toggle(isOn: $isLightMode) {
                            Text("Light Mode")
                        }
                        .padding()
                        .onChange(of: isLightMode) { newValue in
                            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = newValue ? .light : .dark
                        }

                        Divider()

                        // Notifications Toggle
                        Toggle(isOn: $notificationsEnabled) {
                            Text("Notifications")
                        }
                        .padding()
                        .onChange(of: notificationsEnabled) { newValue in
                            if newValue {
                                requestNotificationPermission()
                            }
                        }

                        Divider()

                        // Reminder Offset Picker
                        VStack(alignment: .leading) {
                            Text("Default Reminder Time")
                                .font(.subheadline)
                                .padding(.horizontal)

                            Stepper(value: $reminderOffsetMinutes, in: 1...1440, step: 5) {
                                Text("Reminder Time: \(reminderOffsetMinutes) min before due")
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical, 10)
                    }
                    .background(Color.white.opacity(0.85))
                    .cornerRadius(16)
                    .padding(.horizontal, 20)
                    .shadow(radius: 5)

                    // Clear All Tasks
                    Button(role: .destructive) {
                        showClearAlert = true
                    } label: {
                        Text("Clear All Tasks")
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red.opacity(0.9))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                    }
                    .alert("Are you sure?", isPresented: $showClearAlert) {
                        Button("Delete All", role: .destructive) {
                            taskManager.clearAllTasks()
                        }
                        Button("Cancel", role: .cancel) { }
                    } message: {
                        Text("This will permanently delete all tasks.")
                    }

                    Spacer()
                }
            }
        }
    }

    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("✅ Notification permission granted")
            } else {
                print("❌ Permission denied or error: \(String(describing: error))")
            }
        }
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
    }
}
