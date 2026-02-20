//
//  CreateView.swift
//  
//
//  Created by Daniele Giammarresi on 18/02/26.
//

import Foundation
import SwiftUI

struct CreateView: View {
    @State var engineering: String = "Select engineering"
    @State var subject: String = "Select subject"
    @State var building: String = "Select Building"
    @State var room: String = ""
    @State var date: Date = Date()
    @State var description: String = ""
    @State var linkWhatsapp: String = ""
    @State var linkTelegram: String = ""
    let materieDisponiobili = ["Select subject","Calculus", "Biology", "History", "Philosophy", "Sociology"]
    let edificiDisponibili = ["Select Building","building 6", "building 7", "building 8", "building 9", "building 10"]
    let facoltaIngegneristica = ["Select engineering","Computer", "Electrical", "Civil", "Mechanical"]
    
    var body: some View {
        ScrollView {
            Text("Create an Huddle")
                .font(.system(size: 30)).bold()
                .foregroundColor(.blue)
                .padding()
            VStack{
                HStack {
                    Text("Info")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.leading, 5)
                    Spacer()
                }
                VStack {
                    Picker("engineering", selection: $engineering){
                        ForEach(facoltaIngegneristica, id: \.self) {
                            ingegneria in Text(ingegneria)
                        }
                    }
                    Divider()
                    Picker("Subject", selection: $subject){
                        ForEach(materieDisponiobili, id: \.self) {
                            materia in Text(materia)
                        }
                    }
                    .tint(.blue)
                    Divider()
                    TextField("Insert Huddle description", text: $description)
                        .padding(.vertical, 5)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(25)
            }
            .padding(.horizontal)
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
                    .tint(.blue)
                    Divider()
                    TextField("Insert Huddle room: ", text: $room)
                        .padding(.vertical, 5)
                    Divider()
                    DatePicker(selection: $date, label: {Text("Huddle date: ")} )
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(25)
                Button(action:{
                    //colegamenton con il link università
                }) {
                    Text("Check free rooms")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemOrange))
                        .foregroundColor(.white)
                        .cornerRadius(25)
                }
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
                    TextField("Insert Whatsapp Link: ", text: $linkWhatsapp)
                        .padding(.vertical, 5)
                        .foregroundColor(.green)
                    Divider()
                    TextField("Insert Telegram Link: ", text: $linkTelegram)
                        .padding(.vertical, 5)
                        .foregroundColor(.cyan)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(25)
            }
            .padding()
            
        }
        
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
                    .font(.title2).bold()
                    .frame(maxWidth: 350)
                    .padding()
                    .background(Color(.blue))
                    .foregroundColor(.white)
                    .cornerRadius(25)
            }
            
            .background(.ultraThinMaterial)
        }
    }
}
#Preview {
    CreateView()
}
