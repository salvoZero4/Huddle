//
//  CreateView.swift
//  
//
//  Created by Daniele Giammarresi on 18/02/26.
//

import Foundation
import SwiftUI

struct CreateView: View {
    @State var subject: String = "Calculus"
    @State var building: String = "building 6"
    @State var room: String = ""
    @State var date: Date = Date()
    @State var description: String = ""
    @State var linkW: String = ""
    @State var linkT: String = ""
    let materieDisponiobili = ["Calculus", "Biology", "History", "Philosophy", "Sociology"]
    let edificiDisponibili = ["building 6", "building 7", "building 8", "building 9", "building 10"]
    
    var body: some View {
        ScrollView {
            Text("Create a Huddle")
                .font(.system(size: 30))
                .foregroundColor(.blue)
                .padding()
            VStack () {
                
                HStack {
                        Text("Info")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding(.leading)
                        Spacer()
                    }
                VStack {
                    Picker("Subject", selection: $subject){
                        ForEach(materieDisponiobili, id: \.self) {
                            materia in Text(materia)
                        }
                    }
                    .tint(.red)
                    Divider()
                    TextField("Insert Huddle description", text: $description)
                        .padding(.vertical, 5)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(25)
            }
            .padding()
            VStack{
                    HStack {
                        Text("Place and Date")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding(.leading)
                        Spacer()
                    }
                VStack {
                    Picker("building", selection: $building){
                        ForEach(edificiDisponibili, id: \.self) {
                            edificio in
                            Text(edificio)
                        }
                    }
                    .tint(.purple)
                    Divider()
                    TextField("Insert Huddle room: ", text: $room)
                        .padding(.vertical, 5)
                    Divider()
                    DatePicker(selection: $date, label: {Text("Huddle date: ")} )
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(25)
            }
            .padding()
            VStack{
                    HStack {
                        Text("Social group")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding(.leading)
                        Spacer()
                    }
                VStack {
                    TextField("Insert Whatsapp Link: ", text: $linkW)
                        .padding(.vertical, 5)
                        .foregroundColor(.green)
                    Divider()
                    TextField("Insert Telegram Link: ", text: $linkT)
                        .padding(.vertical, 5)
                        .foregroundColor(.cyan)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(25)
            }
            .padding()
            
            VStack{
                Button(action: {
                    //logica del bottone
                   /* _ = Huddle(
                        subject: subject,
                        building: building,
                        room: room
                    )*/
                    //Salvo qui i dati nell main
                    //DatabaseManager.shared.saveHuddle(nuovo: nuovoGruppo)
                    
                    /* subject = ""
                    building = ""
                    room = ""
                    linkWhatsapp = ""
                    linkTelegram = "" */
                    
                
                    
                }) {
                    Text("Create")
                        .font(.headline)
                        .frame(maxWidth: 320)
                        .padding()
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}
#Preview {
    CreateView()
}
