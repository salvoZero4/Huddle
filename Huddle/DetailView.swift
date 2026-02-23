//
//  DetailView.swift
//  Hubble
//
//  Created by Salvatore Scaravalle on 20/02/26.
//

import Foundation
import SwiftUI

struct DetailView: View {
    @State var huddle: Huddle //DISCUTERE RIGUARDO L'IDENTIFICATORE
    
    
    var body: some View {
        ScrollView {
            VStack{
                Text(huddle.engineering)
                    .padding()
                    .background(Color.purple.opacity(0.2))
                    .cornerRadius(25)
                    .foregroundColor(.purple)
                    .padding()
                Text(huddle.subject)
                    .padding()
                    .font(.largeTitle).bold()
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    Text("\(huddle.building), \(huddle.room)")
                        .foregroundColor(.gray)
                        .padding(.bottom, 2)
                }
                HStack {
                    Image(systemName: "calendar")
                    Text(huddle.date.formatted(date: .abbreviated, time: .shortened))                        .foregroundColor(.gray)
                        .padding(.bottom, 2)
                }
                HStack {
                    Image(systemName: "person.circle.fill")
                    Text("\(huddle.users[0].userName)")
                        .foregroundColor(.gray)
                        .padding(.bottom, 2)
                }
                .padding()
                
                VStack {
                       Text("Huddle description")
                        .font(.title2).bold()
                        .padding(.leading, -150)
                    Text("\(huddle.description)")
                        .padding()
                    Divider()
                    Button(action: {
                        //azione del bottone join
                    }) {
                        Label("Join the Huddle", systemImage: "plus.circle.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemBlue))
                            .foregroundColor(.white)
                            .cornerRadius(25)
                    }
                    Button(action: {
                        //azione bottone whatsapp
                    }) {
                        Label("Whatsapp Group", systemImage: "message.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemGreen))
                            .foregroundColor(.white)
                            .cornerRadius(25)
                    }
                    Button(action: {
                        //azione bottone Telegram
                    }) {
                        Label("Telegram Group", systemImage: "message.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemCyan))
                            .foregroundColor(.white)
                            .cornerRadius(25)
                    }
                    
                    
                    
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(.systemGray6))
                )
            }
        }
    }
}




#Preview {
    DetailView(huddle: Huddle(
        subject: "Physics",
        building: "Building 9",
        room: "U010",
        description: "Let's study the first 50 pages of the new chapter. Bring your notes!",
        date: Calendar.current.date(from: DateComponents(year: 2026, month: 2, day: 28, hour: 17)) ?? Date(),
        linkW: "",
        linkT: "",
        engineering: "Computer Engineering",
        users: [
            User(userName: "Salvatore Scaravalle", mail: "salvatore.scaravalle@community.unipa.it",huddles: []),
            User(userName: "Matteo Raimondi", mail: "matteo.raimondi@community.unipa.it",huddles: [])
        ]
    ))
}
