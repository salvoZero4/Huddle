//
//  ContentView.swift
//  Huddle
//
//  Created by Salvatore Scaravalle on 17/02/26.
//

import SwiftUI

struct ContentView: View {
    // 1. Leggiamo la sessione attuale
    @EnvironmentObject private var session: SessionManager
    @State var selection: Int = 0
    // 2. Partiamo con un utente "vuoto" che verrà riempito in una frazione di secondo
    @State private var user = User(userName: "Caricamento...", mail: "", huddles: [])
    @State private var huddles: [Huddle] = []
    
    var body: some View {
        TabView(selection: $selection) {
            SearchView(huddles: huddles, user: $user)
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }.tag(0)
            
            MyGroupView(user: $user, huddles: huddles)
                .tabItem {
                    Label("My Group", systemImage: "person.2.fill")
                }.tag(1)
            
            CreateView(user: $user)
                .tabItem {
                    Label("Create", systemImage: "plus.circle")
                }.tag(2)
            
            ProfileView(user: $user) // <-- Passiamo il binding anche qui se vuoi modificarlo!
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }.tag(3)
        }
        .onAppear {
            caricaUtente()
        }
    }
    
    // MARK: - LOGICA DI CARICAMENTO UTENTE
    private func caricaUtente() {
        // Prendiamo email e username salvati nel telefono dal RegisterViewModel
        guard let email = session.currentEmail, let username = session.currentUsername else { return }
        
        // Cerchiamo l'utente su ParthenoKit
        if let utenteScaricato = HuddleService.shared.fetchUser(email: email) {
            print("Bentornato, \(utenteScaricato.userName)!")
            self.user = utenteScaricato
        } else {
            // Se non esiste su ParthenoKit (primo accesso assoluto), lo creiamo e lo salviamo!
            print("Nuovo utente! Creo il profilo su ParthenoKit...")
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
