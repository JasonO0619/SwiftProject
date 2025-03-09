import SwiftUI

struct PopupModifier: ViewModifier {
    @Binding var showPopup: Bool

    func body(content: Content) -> some View {
        ZStack {
            content

            if showPopup {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showPopup = false
                    }

                AddTaskPopup(showPopup: $showPopup)
                    .transition(.scale)
                    .zIndex(1)
            }
        }
        .animation(.easeInOut, value: showPopup)
    }
}


extension View {
    func addPopup(showPopup: Binding<Bool>) -> some View {
        self.modifier(PopupModifier(showPopup: showPopup))
    }
}
