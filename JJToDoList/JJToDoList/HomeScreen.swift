import SwiftUI

struct HomeScreen: View {
    @State private var showAddTaskPopup = false
    @State private var navigateToAddTaskScreen = false

    let taskList = Array(repeating: TaskCard(), count: 4)
    let categories = ["Work", "School", "Business", "Personal", "Other"]

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.teal.opacity(0.6), Color.cyan.opacity(0.3)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                VStack {
                    HeaderView(title: "TO-DO LIST", date: "FEB 16, 2025 | 12:00 AM")

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(categories, id: \.self) { category in
                                Text(category)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.white.opacity(0.3))
                                    .cornerRadius(10)
                                    .font(.subheadline)
                            }
                        }
                        .padding(.horizontal)
                    }

                    
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            ForEach(0..<taskList.count, id: \.self) { _ in
                                NavigationLink(destination: TaskDetailScreen()) {
                                    TaskCard()
                                }
                            }

                            NavigationLink(destination: AddTaskScreen()) {
                                VStack {
                                    Text("+ Add a full task")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                }
                                .frame(height: 100)
                                .frame(maxWidth: .infinity)
                                .background(Color.white.opacity(0.3))
                                .cornerRadius(12)
                                .shadow(radius: 3)
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.black, style: StrokeStyle(lineWidth: 1, dash: [5])))
                            }
                        }
                        .padding()
                    }

                    Spacer()

                    AddTaskButton(showPopup: $showAddTaskPopup)
                }
            }
            .addPopup(showPopup: $showAddTaskPopup)
            }
        }
    }


struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

