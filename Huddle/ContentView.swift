//
//  ContentView.swift
//  Huddle
//
//  Created by Salvatore Scaravalle on 17/02/26.
//

import SwiftUI

struct ContentView: View {
    @State var huddles = [
            Huddle(subject: "Calculus I",
                   building: "Building 6",
                   room: "A330" ,
                   description: "Let's do a general recap",
                   date: Calendar.current.date(from: DateComponents(year: 2026, month: 3, day: 20, hour: 10)) ?? Date(),
                   linkW: "",
                   linkT: "",
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
                   users:
                    [User(userName: "Salvatore Scaravalle",
                          mail:"salvatore.scaravalle@community.unipa.it"),
                     User(userName: "Matteo Raimondi",
                          mail: "matteo.raimondi@community.unipa.it")
                    ])
        ]
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("ciao")
        }
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello!")
        }
        .padding()
    }
}

struct User: Identifiable, Codable{
    var id = UUID()
    var userName: String
    var mail: String
    
    mutating func setUserName(userName: String){
        self.userName = userName
    }
    
    mutating func setMail(mail: String){
        self.mail = mail
    }
    
    
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
    var users: [User]
    mutating func setBuilding(building: String){
        self.building = building
    }
    
    mutating func setRoom(room: String){
        self.room = room
    }
    mutating func setSubject(subject: String){
        self.subject = subject
    }
    
    mutating func setDate(date: Date){
        self.date = date
    }
}

    
    



#Preview {
    ContentView()
}
