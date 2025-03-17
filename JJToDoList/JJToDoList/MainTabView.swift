import SwiftUI

struct MainTabView: View {
    @StateObject var taskManager = TaskManager() // Create a single instance of TaskManager

    init (){
        UITabBar.appearance().backgroundColor = UIColor.white
    }

    var body: some View {
        TabView {
            HomeScreen(taskManager: taskManager) // Pass taskManager
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            FullListScreen(taskManager: taskManager) // Pass taskManager
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Full List")
                }

            CalendarScreen(taskManager: taskManager) // Pass taskManager
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }

            SettingsScreen(taskManager: taskManager) // Pass taskManager
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
        .accentColor(.blue)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
