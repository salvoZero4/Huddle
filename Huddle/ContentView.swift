//
//  ContentView.swift
//  Huddle
//
//  Created by Salvatore Scaravalle on 17/02/26.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var session: SessionManager
    @State var selection: Int = 0
    @State var userCurrent: User? = nil
    
    @State var huddles = [
        Huddle(subject: "Calculus I", building: "Building 6", room: "A330",
               description: "Let's do a general recap",
               date: Calendar.current.date(from: DateComponents(year: 2026, month: 3, day: 20, hour: 10)) ?? Date(),
               linkW: "",
               linkT: "",
               engineering: "Computer",
               users:
                [User(userName: "Daniele Giammarresi",
                      mail:"daniele.giammarresi@community.unipa.it", huddles: []),
                 User(userName: "Gabriele Barone",
                      mail: "gabriele.barone@community.unipa.it", huddles: [])
                ]),
        
        Huddle(subject: "Physics I", building: "Building 9", room: "U010",
               description: "Let's study the first 50 pages",
               date: Calendar.current.date(from: DateComponents(year: 2026, month: 2, day: 28, hour: 17)) ?? Date(),
               linkW: "",
               linkT: "",
               engineering: "Civil",
               users:
                [User(userName: "Salvatore Scaravalle",
                      mail:"salvatore.scaravalle@community.unipa.it", huddles: []),
                 User(userName: "Matteo Raimondi",
                      mail: "matteo.raimondi@community.unipa.it", huddles:[])
                ])
    ]
    
    var body: some View {
        TabView(selection: $selection) {
            SearchView(huddles: $huddles, user: Binding($userCurrent) ?? .constant(User(userName: "", mail: "", huddles: [])))
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }
                .tag(0)
            
            MyGroupView(huddles: huddles, user: Binding($userCurrent) ?? .constant(User(userName: "", mail: "", huddles: [])))
                .tabItem {
                    Label("My Huddle", systemImage: "person.2")
                }
                .tag(1)
            
            CreateView()
                .tabItem {
                    Label("Add", systemImage: "plus.circle")
                }
                .tag(2)
            
            ProfileView(user: $userCurrent)
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
                .tag(3)
        }
        .onAppear {
            syncUserFromSession()
        }
        .onChange(of: session.currentUsername) { _, _ in
            syncUserFromSession()
        }
    }
    
    private func syncUserFromSession() {
        guard let email = session.currentEmail,
              let username = session.currentUsername else { return }
        userCurrent = User(userName: username, mail: email, huddles: [])
    }
}

struct User: Identifiable, Codable {
    var id = UUID()
    var userName: String
    var mail: String
    var huddles: [Huddle]
}

struct Huddle: Identifiable, Codable, Equatable {
    static func == (lhs: Huddle, rhs: Huddle) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID()
    var subject: String
    var building: String
    var room: String
    var description: String
    var date: Date
    var linkW: String
    var linkT: String
    var engineering: String
    var users: [User]
}

#Preview {
    ContentView()
        .environmentObject(SessionManager.shared)
}
