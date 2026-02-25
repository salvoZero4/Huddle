//
//  DetailView.swift
//  Hubble
//
//  Created by Salvatore Scaravalle on 20/02/26.
//

import Foundation
import SwiftUI

struct DetailView: View {
    @Binding var user: User
    @State var huddle: Huddle
    @Environment(\.openURL) var openURL //--> serve per aprire u linkeone
    
    // Controlla se l'utente attuale è già dentro l'Huddle
    var isUserJoined: Bool {
        huddle.users.contains(where: { $0.id == user.id })
    }
    
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
                    Text(huddle.date.formatted(date: .abbreviated, time: .shortened))
                        .foregroundColor(.gray)
                        .padding(.bottom, 2)
                }
                HStack {
                    Image(systemName: "person.circle.fill")
                    
                    // Controlliamo in modo sicuro se la lista degli utenti è vuota
                    if huddle.users.isEmpty {
                        Text("Nessun partecipante")
                            .foregroundColor(.gray)
                            .padding(.bottom, 2)
                    } else {
                        Text(huddle.users[0].userName) // Ora è sicuro farlo!
                            .foregroundColor(.gray)
                            .padding(.bottom, 2)
                    }
                }
                .padding()
                
                // BOX GRIGIO CON BOTTONI E DESCRIZIONE
                
                VStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Huddle description")
                            .font(.title2).bold()
                        
                        Text(huddle.description)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading) // Allinea perfettamente a sinistra!
                    Divider().padding()
                    if !huddle.linkW.isEmpty {
                        // BOTTONE WHATSAPP
                        Button(action: {
                            // Controlla che il link non sia vuoto e lo apre
                            if let url = URL(string: huddle.linkW), !huddle.linkW.isEmpty {
                                openURL(url)
                            }
                        }) {
                            Label("Whatsapp Group", systemImage: "message.fill")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(.systemGreen))
                                .foregroundColor(.white)
                                .cornerRadius(25)
                        }
                    }
                    if !huddle.linkT.isEmpty {
                        // BOTTONE TELEGRAM
                        Button(action: {
                            if let url = URL(string: huddle.linkT), !huddle.linkT.isEmpty {
                                openURL(url)
                            }
                        }) {
                            Label("Telegram Group", systemImage: "message.fill")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(.systemCyan))
                                .foregroundColor(.white)
                                .cornerRadius(25)
                        }
                    }

                   
                    // ------
                    // BOTTONE JOIN / LEAVE INTELLIGENTE
                    Button(action: {
                        // 1. Vibrazione tattile per un feedback premium!
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                        
                        // 2. Controllo: Entriamo o Usciamo?
                        if isUserJoined {
                            // Se sei già dentro, rimuoviamo la tua mail dalla lista
                            huddle.users.removeAll(where: { $0.id == user.id })
                            user.huddles.removeAll(where: { $0.id == huddle.id })
                            print("Sei uscito dall'Huddle!")
                        } else {
                            // Se non ci sei, ti aggiungiamo
                            huddle.users.append(user)
                            user.huddles.append(huddle)
                            print("Ti sei unito all'Huddle con successo!")
                        }
                        
                        // 3. Salviamo sul database la modifica (in entrambi i casi!)
                        let _ = HuddleService.shared.updateHuddle(huddleAggiornato: huddle)
                        
                    }) {
                        // Il testo e l'icona cambiano in base allo stato
                        Label(isUserJoined ? "Leave the Huddle" : "Join the Huddle",
                              systemImage: isUserJoined ? "minus.circle.fill" : "plus.circle.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            // Rosso se sei dentro (per farti capire che esci), Blu se devi entrare
                            .background(isUserJoined ? Color.red : Color(.systemBlue))
                            .foregroundColor(.white)
                            .cornerRadius(25)
                            // Animazione fluida quando cambia colore!
                            .animation(.easeInOut(duration: 0.3), value: isUserJoined)
                    }
                    
            
                      
                    
                  
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(25)
                .padding(.horizontal) // Dà un po' di respiro ai lati
                
            }
        }
    }
}

#Preview {
    DetailView(
        user: .constant(User(userName: "Daniele", mail: "daniele@community.unipa.it", huddles: [])) , huddle: Huddle(
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
    )
}
