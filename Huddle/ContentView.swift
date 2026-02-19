//
//  ContentView.swift
//  Huddle
//
//  Created by Salvatore Scaravalle on 17/02/26.
//

import SwiftUI

struct ContentView: View {
    
    
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
    var users: [User]?
    //var date : ???
    mutating func setBuilding(building: String){
        self.building = building
    }
    
    mutating func setRoom(room: String){
        self.room = room
    }
    mutating func setSubject(subject: String){
        self.subject = subject
    }
    
    /* mutating func setData(data: ???){
        ???
     }
     */
    
    
}
#Preview {
    ContentView()
}

