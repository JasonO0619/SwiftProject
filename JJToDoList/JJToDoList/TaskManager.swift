import Foundation
import UserNotifications

class TaskManager: ObservableObject {
    @Published var tasks: [Task] = [] {
        didSet {
            saveTasks()
        }
    }
    
    init() {
        loadTasks()
    }
    
    func addTask(_ task: Task) {
        tasks.append(task)
        scheduleReminder(for: task)
    }
    
    func updateTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
            scheduleReminder(for: task)
        }
    }
    
    func removeTask(_ task: Task) {
        tasks.removeAll { $0.id == task.id }
        cancelReminder(for: task)
    }
    
    func clearAllTasks() {
        tasks.forEach { cancelReminder(for: $0) }
        tasks.removeAll()
    }

    // MARK: - Reminder Scheduling
    
    func scheduleReminder(for task: Task) {
        let offsetMinutes = UserDefaults.standard.integer(forKey: "reminderOffsetMinutes")
        let reminderTime = Calendar.current.date(byAdding: .minute, value: -offsetMinutes, to: task.dueDate) ?? task.dueDate

        if reminderTime < Date() {
            print("🕐 Skipping reminder: Too close or past for \(task.title)")
            return
        }

        let content = UNMutableNotificationContent()
        content.title = "📝 Reminder: \(task.title)"
        content.body = "Due at \(task.dueDate.formatted(date: .omitted, time: .shortened))"
        content.sound = .default

        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: reminderTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        let request = UNNotificationRequest(identifier: task.id.uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Failed to schedule notification: \(error.localizedDescription)")
            } else {
                print("✅ Reminder scheduled for \(task.title) at \(reminderTime)")
            }
        }
    }

    func cancelReminder(for task: Task) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [task.id.uuidString])
        print("🗑️ Canceled reminder for \(task.title)")
    }

    // MARK: - Local Persistence
    
    private func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: "tasks")
        }
    }
    
    private func loadTasks() {
        if let savedData = UserDefaults.standard.data(forKey: "tasks"),
           let decoded = try? JSONDecoder().decode([Task].self, from: savedData) {
            tasks = decoded
        }
    }
}
