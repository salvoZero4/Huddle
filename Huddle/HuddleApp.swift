import SwiftUI

@main
struct HuddleApp: App {
    
    @ObservedObject private var session = SessionManager.shared
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                
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
