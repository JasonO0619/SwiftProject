import SwiftUI

struct HeaderView: View {
    let title: String
    let date: String

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.3), Color.white.opacity(0.9)]),
                           startPoint: .leading,
                           endPoint: .trailing)
                .frame(height: 80)
                
                
            HStack {
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                    

                Spacer()

                Text(date)
                    .font(.system(size: 18))
                    .foregroundColor(.black.opacity(0.7))
            }
            .padding(.horizontal, 16)
            }
        .frame(maxWidth: .infinity)
    }
}

struct TaskCard: View {
    var body: some View {
        NavigationLink(destination: TaskDetailScreen()) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Task Title").font(.headline)
                    .foregroundColor(.black)
                Text("Task Description").font(.subheadline).foregroundColor(.black)
                HStack {
                    Text("Priority: 🔴")
                            Spacer()
                    Text("Due: Jan 10, 2025")
                }
                .foregroundColor(.black)                .font(.caption)
                ProgressView(value: 0.5)
                    .progressViewStyle(LinearProgressViewStyle())
                    .padding(.top, 5)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
        }
    }
}
struct FullTaskCard: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 8) {
                Text("Task Title")
                    .font(.headline)
                Text("Task Description")
                    .font(.subheadline)
                    .foregroundColor(.black)

                Text("Task Progress:")
                    .font(.caption)
                ProgressView(value: 0.5)
                    .progressViewStyle(LinearProgressViewStyle())
                    .frame(maxWidth: .infinity)

                HStack {
                    Text("Priority:")
                    Text("🔴")
                    Spacer()
                    
                    Button(action: {
                    }) {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text("Mark as Complete")
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.green)
                        .cornerRadius(8)
                    }
                    
                    HStack {
                        Image(systemName: "calendar")
                        Text("Jun 10, 2025")
                            .foregroundColor(.black)
                    }
                    .padding(.leading, 6)
                }
                .font(.caption)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)

            Button(action: {
            }) {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.red)
            }
            .padding(10)
        }
     
    }
}
struct AddTaskButton: View {
    @Binding var showPopup: Bool

    var body: some View {
        HStack {
            Spacer()
            Button {
                showPopup = true
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.blue)
            }
            
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}


struct TaskGridView: View {
    let taskList = Array(repeating: TaskCard(), count: 4)
    @State private var navigateToAddTaskScreen = false

    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            ForEach(0..<taskList.count, id: \.self) { _ in
                TaskCard()
            }

            Button(action: {
                navigateToAddTaskScreen = true
            }) {
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
}

struct AddTaskPopup: View {
    @Binding var showPopup: Bool
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Text("Add Quick Task").font(.headline)
            TextField("Task Name", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            DatePicker("Due Date", selection: .constant(Date()), displayedComponents: [.date, .hourAndMinute])
            Button("Add Task") {
                showPopup = false
            }
            .buttonStyle(.borderedProminent)
            .padding(.top)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .frame(maxWidth: 300)
    }
}

