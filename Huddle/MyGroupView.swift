//
//  MyGroupView.swift
//  
//
//  Created by Daniele Giammarresi on 18/02/26.
//

import Foundation
import SwiftUI

struct MyGroupView: View {
    var huddles: [Huddle]
        var body: some View {
            NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    Text("My Huddle")
                        .font(.largeTitle).bold()
                        .foregroundColor(.blue)
                    
                    Text("In Progress")
                        .font(.title2).bold()
                        .foregroundColor(.gray)
                    
                    ForEach(huddles) { huddle in
                        NavigationLink(destination: DetailView(huddle: huddle)) {
                                                    HuddleCardView(huddle: huddle)
                                                }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

//Singolo evento
struct HuddleCardView: View {
  //è costante perchè ci sono gia i dati
    let huddle: Huddle
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(huddle.engineering)
                .font(.title2)
                .foregroundColor(.blue)
            
            Text(huddle.subject)
                .font(.title).bold()
            
            HStack {
                Image(systemName: "mappin.and.ellipse").bold()
                Text("\(huddle.building), \(huddle.room)")
                    .foregroundColor(.gray)
            }
            
            HStack {
                Image(systemName:"calendar").bold()
                Text(huddle.date.formatted(date: .abbreviated, time: .shortened))
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6))
        .cornerRadius(25)
    }
}

#Preview {
    MyGroupView(huddles: [
        Huddle(
            subject: "Physics",
            building: "Building 9",
            room: "U010",
            description: "Let's study the first 50 pages of the new chapter. Bring your notes!",
            date: Calendar.current.date(from: DateComponents(year: 2026, month: 2, day: 28, hour: 17)) ?? Date(),
            linkW: "",
            linkT: "",
            engineering: "Computer Engineering",
            users: [
                User(userName: "Salvatore Scaravalle", mail: "salvatore.scaravalle@community.unipa.it"),
                User(userName: "Matteo Raimondi", mail: "matteo.raimondi@community.unipa.it")
            ]
        )
    ])
}
