//
//  ContentView.swift
//  Huddle
//
//  Created by Salvatore Scaravalle on 17/02/26.
//

import SwiftUI

struct ContentView: View {
    
    @State var selection: Int = 0
    @State var userCurrent: User? = User(
        userName: "Daniele Giammarresi",
        mail: "daniele.giammarresi@community.unipa.it"
    )
    
    @State var huddles = [
        Huddle(subject: "Calculus I", building: "Building 6", room: "A330",
               description: "Let's do a general recap",
               date: Calendar.current.date(from: DateComponents(year: 2026, month: 3, day: 20, hour: 10)) ?? Date(),
               linkW: "", linkT: "", engineering: "Computer Science",
               users: [User(userName: "Daniele Giammarresi", mail: "daniele.giammarresi@community.unipa.it"),
                       User(userName: "Gabriele Barone", mail: "gabriele.barone@community.unipa.it")]),
        
        Huddle(subject: "Physics I", building: "Building 9", room: "U010",
               description: "Let's study the first 50 pages",
               date: Calendar.current.date(from: DateComponents(year: 2026, month: 2, day: 28, hour: 17)) ?? Date(),
               linkW: "", linkT: "", engineering: "Computer Science",
               users: [User(userName: "Salvatore Scaravalle", mail: "salvatore.scaravalle@community.unipa.it"),
                       User(userName: "Matteo Raimondi", mail: "matteo.raimondi@community.unipa.it")]),
        
        Huddle(subject: "Data Mining", building: "Building 7", room: "B210",
               description: "Clustering algorithms review",
               date: Calendar.current.date(from: DateComponents(year: 2026, month: 3, day: 5, hour: 10, minute: 15)) ?? Date(),
               linkW: "", linkT: "", engineering: "Computer Science",
               users: [User(userName: "Yasmine Ghomrassi", mail: "yasmine.ghomrassi@community.unipa.it")]),
        
        Huddle(subject: "Linear Algebra", building: "Building 6", room: "A110",
               description: "Eigenvalues and eigenvectors practice",
               date: Calendar.current.date(from: DateComponents(year: 2026, month: 3, day: 10, hour: 9)) ?? Date(),
               linkW: "", linkT: "", engineering: "Computer Science",
               users: [User(userName: "Matteo Raimondi", mail: "matteo.raimondi@community.unipa.it")]),
        
        Huddle(subject: "Chemistry", building: "Building 8", room: "C305",
               description: "Organic chemistry exam prep",
               date: Calendar.current.date(from: DateComponents(year: 2026, month: 3, day: 12, hour: 10)) ?? Date(),
               linkW: "", linkT: "", engineering: "Biology",
               users: [User(userName: "Gabriele Barone", mail: "gabriele.barone@community.unipa.it")]),
        
        Huddle(subject: "Journalism", building: "Building 10", room: "D401",
               description: "Media writing workshop",
               date: Calendar.current.date(from: DateComponents(year: 2026, month: 3, day: 15, hour: 16, minute: 30)) ?? Date(),
               linkW: "", linkT: "", engineering: "Design",
               users: [User(userName: "Lucia Ferrara", mail: "lucia.ferrara@community.unipa.it")]),
        
        Huddle(subject: "Anatomy", building: "Building 3", room: "M101",
               description: "Cardiovascular system review",
               date: Calendar.current.date(from: DateComponents(year: 2026, month: 3, day: 18, hour: 11)) ?? Date(),
               linkW: "", linkT: "", engineering: "Medicine",
               users: [User(userName: "Marco Vitale", mail: "marco.vitale@community.unipa.it")]),
        
        Huddle(subject: "Physics II", building: "Building 9", room: "U205",
               description: "Electromagnetism problem session",
               date: Calendar.current.date(from: DateComponents(year: 2026, month: 3, day: 22, hour: 14)) ?? Date(),
               linkW: "", linkT: "", engineering: "Electrical",
               users: [User(userName: "Luca Marino", mail: "luca.marino@community.unipa.it")]),
        
        Huddle(subject: "Calculus II", building: "Building 6", room: "A220",
               description: "Integrals and series review",
               date: Calendar.current.date(from: DateComponents(year: 2026, month: 3, day: 25, hour: 15)) ?? Date(),
               linkW: "", linkT: "", engineering: "Civil",
               users: [User(userName: "Sofia Rizzo", mail: "sofia.rizzo@community.unipa.it")])
    ]
    
    var body: some View {
        TabView(selection: $selection) {
            SearchView(huddles: $huddles, user: Binding($userCurrent)!)
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }
                .tag(0)
            
            MyGroupView(huddles: huddles)
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
    }
}

struct User: Identifiable, Codable {
    var id = UUID()
    var userName: String
    var mail: String
}

struct Huddle: Identifiable, Codable {
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
}
