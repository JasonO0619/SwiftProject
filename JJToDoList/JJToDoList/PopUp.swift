import SwiftUI

struct PopupModifier: ViewModifier {
    @Binding var showPopup: Bool
    @ObservedObject var taskManager: TaskManager  // Add TaskManager instance

    func body(content: Content) -> some View {
        ZStack {
            content

            if showPopup {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showPopup = false
                    }

                AddTaskPopup(showPopup: $showPopup, taskManager: taskManager) // Pass taskManager
                    .transition(.scale)
                    .zIndex(1)
            }
        }
        .animation(.easeInOut, value: showPopup)
    }
}

extension View {
    func addPopup(showPopup: Binding<Bool>, taskManager: TaskManager) -> some View {
        self.modifier(PopupModifier(showPopup: showPopup, taskManager: taskManager)) // Pass taskManager here
    }
}
