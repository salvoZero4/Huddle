import SwiftUI

@main
struct HuddleApp: App {
    
    @StateObject private var session = SessionManager.shared
    
    init() {
        // TEMP: Remove this line after testing is done
        SessionManager.shared.clearSession()
    }
    
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
