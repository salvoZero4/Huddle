//
//  ContentView.swift
//  Huddle
//
//  Created by Salvatore Scaravalle on 17/02/26.
//

import SwiftUI

struct ContentView: View {
    
    @State var selection: Int = 0
    @State var userCurrent = User(
        userName: "Daniele Giammarresi",
        mail: "daniele.giammarresi@community.unipa.it"
        )
    
    @State var huddles = [
        Huddle(subject: "Calculus I",
               building: "Building 6",
               room: "A330" ,
               description: "Let's do a general recap",
               date: Calendar.current.date(from: DateComponents(year: 2026, month: 3, day: 20, hour: 10)) ?? Date(),
               linkW: "",
               linkT: "",
               engineering: "Computer Science",
               users:
                [User(userName: "Daniele Giammarresi",
                      mail:"daniele.giammarresi@community.unipa.it"),
                 User(userName: "Gabriele Barone",
                      mail: "gabriele.barone@community.unipa.it")
                ]),
        
        Huddle(subject: "Physics",
               building: "Building 9",
               room: "U010" ,
               description: "Let's study the first 50 pages",
               date: Calendar.current.date(from: DateComponents(year: 2026, month: 2, day: 28, hour: 17)) ?? Date(),
               linkW: "",
               linkT: "",
               engineering: "Computer Science",
               users:
                [User(userName: "Salvatore Scaravalle",
                      mail:"salvatore.scaravalle@community.unipa.it"),
                 User(userName: "Matteo Raimondi",
                      mail: "matteo.raimondi@community.unipa.it")
                ])
    ]
    
    
    
    
    var body: some View {
        /*TabView(selection: $selection) {
            SearchView(huddles: $huddles, user: $userCurrent)
                .tabItem {
                    Label("Search",systemImage: "magnifyingglass")
                        .accentColor(.primary)
                }
                .tag(0)
            
            
            MyGroupView(huddles: $huddles, user: $userCurrent)
                .tabItem { //mi permette di definire come deve essere il bottone di quella view
                    Label("MyGroup",systemImage: "person.2")
                        .accentColor(.primary)
                }
                .tag(1) //ti permette di capire qual era la tab aperta... ad esempio se in photos avessi aperto un elemento, cliccando su back mi aspetto di ritornare in photos, il tag permette di assicurarci che sia questo il  comportamento
            
            CreateView(user: $userCurrent)
                .tabItem {
                    Label("Add",systemImage: "plus.circle")
                        .accentColor(.primary)
                }
                .tag(2)
            
            
            ProfileView(user: $userCurrent)
                .tabItem {
                    Label("Profile",systemImage: "person.crop.circle")
                        .accentColor(.primary)
                }
                .tag(3)
            
            
            
        }*/ //DOBBIAMO INSERIRE L'ON APPEAR
    }
}





struct User: Identifiable, Codable{
    var id = UUID()
    var userName: String
    var mail: String
}

struct Huddle: Identifiable,Codable{
    var id = UUID()
    var subject: String
    var building: String
    var room: String
    var description: String
    var date : Date
    var linkW: String
    var linkT: String
    var engineering: String
    var users: [User]
   
}

#Preview {
    ContentView()
}
