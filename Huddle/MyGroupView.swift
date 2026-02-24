//
//  MyGroupView.swift
//  
//
//  Created by Daniele Giammarresi on 18/02/26.
//

import SwiftUI

struct MyGroupView: View {
    @Binding var user: User
    @State var huddles: [Huddle] // 1. Aggiunto @State per farla aggiornare da sola
    
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    HStack{
                        Text("My Group")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                            .padding()
                            .foregroundColor(.blue)
                        Spacer()
                    }
                    
                    Text("In Progress")
                        .font(.title2).bold()
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                        .padding()
                    
                    // 3. USIAMO LA LISTA FILTRATA (mieiHuddle) AL POSTO DI QUELLA GENERALE
                    ForEach(user.huddles) { huddle in
                        NavigationLink(destination: DetailView(user: $user, huddle: huddle)) {
                            HuddleCardView(huddle: huddle)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            
            // 4. RICARICA I DATI FRESCHI OGNI VOLTA CHE APRI LA SCHERMATA
            //.onAppear {
              //  self.huddles = //HuddleService.shared.fetchAllHuddles()
            }
        }
    }
//}

//Singolo evento
struct HuddleCardView: View {
  //è costante perchre ci sono gia i dati
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
    MyGroupView(
        user: .constant(User(userName: "Daniele", mail: "daniele@community.unipa.it", huddles: [])),
        huddles: [
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
                    User(userName: "Salvatore Scaravalle", mail: "salvatore.scaravalle@community.unipa.it", huddles: []),
                    User(userName: "Matteo Raimondi", mail: "matteo.raimondi@community.unipa.it", huddles: [])
                ]
            )
        ]
    )
}
