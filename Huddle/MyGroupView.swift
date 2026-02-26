//
//  MyGroupView.swift
//  
//
//  Created by Daniele Giammarresi on 18/02/26.
//

import SwiftUI

struct MyGroupView: View {
    @Binding var user: User
    // Ho rimosso @State var huddles: [Huddle] perché non ci serve più, usiamo user.huddles!
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink(destination: CreateView(user: $user)) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .foregroundColor(.blue)
                            Text("Create a new Huddle")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                        .padding(.vertical, 8)
                    }
                }
                
                Section(header: Text("In Progress").font(.title3).bold().foregroundColor(.gray)) {
                    
                    if user.huddles.isEmpty {
                        Text("Non sei ancora in nessun Huddle.")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                            .padding(.vertical, 10)
                    } else {
                        ForEach(user.huddles) { huddle in
                            NavigationLink(destination: DetailView(user: $user, huddle: huddle)) {
                                HuddleCardView(huddle: huddle)
                            }
                            .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: deleteHuddle)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("My Group")
        }
    }
    
    private func deleteHuddle(at offsets: IndexSet) {
        let huddlesToLeave = offsets.map { user.huddles[$0] }
        user.huddles.remove(atOffsets: offsets)
        
        let salvataggioRiuscito = HuddleService.shared.updateUser(utenteAggiornato: user)
        
        for var huddle in huddlesToLeave {
            huddle.users.removeAll(where: { $0.id == user.id })
            let _ = HuddleService.shared.updateHuddle(huddleAggiornato: huddle)
        }
        
        if salvataggioRiuscito {
            print("Huddle rimosso dal profilo e abbandonato con successo!")
        } else {
            print("Errore durante la rimozione dell'Huddle.")
        }
    }
    
    struct HuddleCardView: View {
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
}
    #Preview {
        MyGroupView(
            user: .constant(User(
                userName: "Daniele",
                mail: "daniele@community.unipa.it",
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
                        users: []
                    )
                ]
            ))
        )
    }
