import SwiftUI

@main
struct HuddleApp: App {
    
    @ObservedObject private var session = SessionManager.shared
    
    var body: some Scene {
        WindowGroup {
            if session.isLoggedIn {
                ContentView()
                    .environmentObject(session)
            } else {
                RegisterView()
                    .environmentObject(session)
            }
        }
    }
}
