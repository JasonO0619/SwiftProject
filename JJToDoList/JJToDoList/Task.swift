import SwiftUI

struct Task: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var dueDate: Date
    var priority: String
    var category: String
    var isCompleted: Bool = false

    var priorityIcon: String {
        switch priority {
        case "Urgent": return "🔴"
        case "Important": return "🟡"
        case "Normal": return "🟢"
        default: return "⚪️"
        }
    }
}
