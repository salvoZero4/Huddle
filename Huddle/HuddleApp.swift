import SwiftUI

@main
struct HuddleApp: App {
    
    @ObservedObject private var session = SessionManager.shared
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                // Se è la prima volta (o non ha finito il tutorial)
                WelcomeView()
            } else if session.isLoggedIn {
                ContentView()
                    .environmentObject(session)
            } else {
                RegisterView()
                    .environmentObject(session)
            }
        }
        
    }
}
