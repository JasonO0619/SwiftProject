import SwiftUI

struct TaskDetailScreen: View {
    @State private var taskTitle = "Example Task"
    @State private var taskDescription = "Task description goes here..."
    @State private var taskProgress = 0.5
    @State private var showAddTaskPopup = false

    var body: some View {
            ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.teal.opacity(0.6), Color.cyan.opacity(0.3)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(alignment: .leading) {
                HeaderView(title: "TO-DO LIST", date: "FEB 16, 2025 | 12:00 AM")

                Text("Task Details")
                    .font(.headline)
                    .padding(.top, 10)
                    .padding(.leading, 15)
                    .navigationTitle("Task Detail")
                TextField("Task Title", text: $taskTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 15)

                
                Text("Task Description:")
                    .font(.subheadline)
                    .padding(.leading, 15)
                    .padding(.top, 5)

                TextEditor(text: $taskDescription)
                    .frame(height: 100)
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    .padding(.horizontal, 15)

                
                Text("Task Progress:")
                    .font(.subheadline)
                    .padding(.leading, 15)
                    .padding(.top, 5)

                ProgressView(value: taskProgress)
                    .progressViewStyle(LinearProgressViewStyle())
                    .padding(.horizontal, 15)

            
                HStack {
                    Text("Priority:")
                        .font(.subheadline)
                    Text("🔴")
                }
                .padding(.leading, 15)
                .padding(.top, 5)

               
                HStack {
                    Text("Date of completion:")
                        .font(.subheadline)
                    Spacer()
                    Text("MM/DD/YYYY")
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 15)
                .padding(.top, 5)

              
                Text("Additional Notes:")
                    .font(.subheadline)
                    .padding(.leading, 15)
                    .padding(.top, 5)

                TextEditor(text: .constant(""))
                    .frame(height: 80)
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    .padding(.horizontal, 15)

                Spacer()

              
                AddTaskButton(showPopup: $showAddTaskPopup)
            }
        }
            .addPopup(showPopup: $showAddTaskPopup)
        }
    }

struct TaskDetailScreen_Previews: PreviewProvider {
    static var previews: some View{
        TaskDetailScreen()
    }
}
