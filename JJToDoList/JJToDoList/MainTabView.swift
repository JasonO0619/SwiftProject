import SwiftUI

struct MainTabView: View {
    init (){
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    var body: some View {
        TabView {
            HomeScreen()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                            FullListScreen()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Full List")
                            }

            CalendarScreen()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }

            SettingsScreen()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
            
        }
        .accentColor(.blue)
    }
}
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View{
        MainTabView()
    }
}
