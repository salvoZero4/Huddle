//
//  CreateView.swift
//  
//
//  Created by Daniele Giammarresi on 18/02/26.
//

import Foundation
import SwiftUI

struct CreateView: View {
    @Environment(\.openURL) var openURL
    @State var engineering: String = "Select engineering"
    @State var subject: String = "Select subject"
    @State var building: String = "Select Building"
    @State var room: String = ""
    @State var date: Date = Date()
    @State var description: String = ""
    @State var linkWhatsapp: String = ""
    @State var linkTelegram: String = ""
    let materieDisponibili: [String] = ["Select Subject"]
    let materieComputer = ["Select subject","Calculus I","Calculus II","Physics I", "Physics II","Geometry","Algebra","Fundaments of Programming","Algorithms and Data Structures","Computer Architecture","Programming","Base of Data","Computer Networks and the Internet","Automatic controls","Signal theory","Electrical Engineering","Eletronics","Software Engineering", "Operating System", "Web and Mobile Programming" ]
    let materieElectrical = [
        "Select subject",
        "Calculus I",
        "Geometry and Algebra",
        "Physics I",
        "Fundamentals of Computer Science",
        "Chemistry",
        "Calculus II",
        "Business Economics and Organization",
        "Physics II",
        "Electrical Engineering",
        "Signal Theory",
        "Electronic Devices",
        "Mathematical and Numerical Methods",
        "Analog Electronics",
        "Electronic Measurements",
        "Electromagnetic Fields",
        "Digital Electronics",
        "Automatic Control",
        "Microprocessor System Architectures",
        "Electronic Circuit Design"
    ]
    let materieMechanical = [
        "Select subject",
        "Calculus I",
        "Geometry and Algebra",
        "Physics I",
        "Chemistry",
        "Fundamentals of Computer Science",
        "Industrial Technical Drawing",
        "Calculus II",
        "Physics II",
        "Rational Mechanics",
        "Applied Mechanics",
        "Mechanics of Materials",
        "Thermodynamics and Heat Transfer",
        "Manufacturing Technology",
        "Machine Design",
        "Fluid Machines",
        "Industrial Plants",
        "Mechanical and Thermal Measurements"
    ]
    let materieCivil = [
        "Select subject",
        "Calculus I",
        "Geometry and Algebra",
        "Physics I",
        "Chemistry",
        "Fundamentals of Computer Science",
        "Calculus II",
        "Physics II",
        "Rational Mechanics",
        "Hydraulics",
        "Mechanics of Materials",
        "Geomatics",
        "Structural Engineering",
        "Geotechnics",
        "Roads, Railways and Airports Construction",
        "Environmental Engineering",
        "Technical Architecture"
    ]
    
    
    let edificiDisponibili = ["Select Building","building 6", "building 7", "building 8", "building 9", "building 10"]
    let facoltaIngegneristica = ["Select engineering","Computer", "Electrical", "Civil", "Mechanical"]
    
    var body: some View {
        VStack{
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
                        if engineering == "Computer"{
                            Picker("Subject", selection: $subject){
                                ForEach(materieComputer, id: \.self) {
                                    materia in Text(materia)
                                }.tint(.blue)
                            }
                        }else if(engineering == "Electrical"){
                            Picker("Subject", selection: $subject){
                                ForEach(materieElectrical, id: \.self) {
                                    materia in Text(materia)
                                }.tint(.blue)
                            }
                        }else if(engineering == "Mechanical"){
                            Picker("Subject", selection: $subject){
                                ForEach(materieMechanical, id: \.self) {
                                    materia in Text(materia)
                                }.tint(.blue)
                            }
                        }else if(engineering == "Civil"){
                            Picker("Subject", selection: $subject){
                                ForEach(materieCivil, id: \.self) {
                                    materia in Text(materia)
                                }.tint(.blue)
                            }
                        }else{
                            Picker("Subject", selection: $subject){
                                ForEach(materieDisponibili, id: \.self) {
                                    materia in Text(materia)
                                }.tint(.blue)
                            }
                        }
                        
                        
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
                        openURL(URL(string:"https://offertaformativa.unipa.it/offweb/public/aula/aulaCalendar.seam")!)
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
                        TextField("Insert Whatsapp Link:(Optional) ", text: $linkWhatsapp)
                            .padding(.vertical, 5)
                            .foregroundColor(.green)
                        Divider()
                        TextField("Insert Telegram Link:(Optional) ", text: $linkTelegram)
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
                    var _newHuddle = Huddle(
                        subject: subject,
                        building: building,
                        room: room,
                        description: description,
                        date: date,
                        linkW: linkWhatsapp,
                        linkT: linkTelegram,
                        engineering: engineering,
                        users: []
                        
                    )
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
                .padding(.bottom, 10)
                
                .background(.ultraThinMaterial)
            }
        }
    }
}
#Preview {
    CreateView()
}
