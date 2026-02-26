//
//  ContentView.swift
//  Huddle
//
//  Created by Salvatore Scaravalle on 17/02/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var session: SessionManager
    @State private var user = User(userName: "Caricamento...", mail: "", huddles: [])
    @State private var huddles: [Huddle] = []
    @State var selction: Int = 0
    
    var body: some View {
        TabView {
            SearchView(huddles: huddles, user: $user)
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }
                .tag(0)
            
            MyGroupView(user: $user)
                .tabItem {
                    Label("My Group", systemImage: "person.2.fill")
                }
                .tag(1)
            
        
        }
        .onAppear {
                caricaUtente()
        }
    }
    
    private func caricaUtente() {
        guard let email = session.currentEmail, let username = session.currentUsername else { return }
        
        if let utenteScaricato = HuddleService.shared.fetchUser(email: email) {
            print("Bentornato, \(utenteScaricato.userName)!")
            self.user = utenteScaricato
        } else {
            print("Nuovo utente! Creo il profilo su ParthenoKit")
            let nuovoUtente = User(userName: username, mail: email, huddles: [])
            self.user = nuovoUtente
            _ = HuddleService.shared.updateUser(utenteAggiornato: nuovoUtente)
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
    var users: [User]
    
    mutating func setBuilding(building: String) { self.building = building }
    mutating func setRoom(room: String) { self.room = room }
    mutating func setSubject(subject: String) { self.subject = subject }
    
    mutating func setDate(date: Date) {
        self.date = date
    }
}



#Preview {
    ContentView()
        .environmentObject(SessionManager())
}
