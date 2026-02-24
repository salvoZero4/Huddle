//
//  ContentView.swift
//  Huddle
//
//  Created by Salvatore Scaravalle on 17/02/26.
//

import SwiftUI

    struct ContentView: View {
        @State private var user = User(userName: "test", mail: "test@test.com", huddles: [])
        @State private var huddles: [Huddle] = []
        var body: some View {
            TabView {
                SearchView(huddles: huddles, user: $user)
                    .tabItem {
                        Label("Explore", systemImage: "magnifyingglass")
                    }
                
                MyGroupView(user: $user, huddles: huddles)
                    .tabItem {
                        Label("My Group", systemImage: "person.2.fill")
                    }
                CreateView(user: $user)
                    .tabItem {
                        Label("Create", systemImage: "plus.circle")
                    }
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
            }
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
    var counter = 0
    var users: [User]
    
    mutating func setBuilding(building: String) { self.building = building }
    mutating func setRoom(room: String) { self.room = room }
    mutating func setSubject(subject: String) { self.subject = subject }
    
    // Ecco come completare la funzione che avevi lasciato in sospeso
    mutating func setDate(date: Date) {
        self.date = date
    }
}



#Preview {
    ContentView()
}
