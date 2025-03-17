import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            MainTabView()
        } else {
            ZStack {
               
                LinearGradient(gradient: Gradient(colors: [Color.teal.opacity(0.6), Color.cyan.opacity(0.3)]),
                               startPoint: .leading,
                               endPoint: .trailing)
                    .ignoresSafeArea()

                VStack(spacing: 50) {
                    Text("J & J's \nTO-DO LIST")
                        .font(.system(size: 24, weight: .bold))
                        .multilineTextAlignment(.center)
                        .frame(width: 180, height: 100)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(50)

                   
                    Text("JASON OPOKU\nJASON GUNAWAN")
                        .font(.system(size: 14, weight: .bold))
                        .multilineTextAlignment(.center)
                        .frame(width: 200, height: 60)
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(30)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View{
        SplashScreen()
    }
}
