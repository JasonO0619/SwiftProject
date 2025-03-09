import SwiftUI

struct FullListScreen: View {
    @State private var searchText = ""
    @State private var showAddTaskPopup = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.teal.opacity(0.6), Color.cyan.opacity(0.3)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack {
                HeaderView(title: "TO-DO LIST", date: "FEB 16, 2025 | 12:00 AM")

                TextField("Enter task here...", text: $searchText)
                    .padding(8)
                    .background(Color.white.opacity(0.6))
                    .cornerRadius(8)
                    .padding(.horizontal)

                ScrollView {
                    FullTaskCard()
                    FullTaskCard()
                    FullTaskCard()
                }
                .padding(.horizontal, 15)

                Spacer()

                AddTaskButton(showPopup: $showAddTaskPopup)
            }
        }
        .addPopup(showPopup: $showAddTaskPopup)        }
    }

struct FullList_Previews: PreviewProvider {
    static var previews: some View{
        FullListScreen()
    }
}

