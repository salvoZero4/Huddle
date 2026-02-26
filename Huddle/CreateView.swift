//
//  CreateView.swift
//  
//
//  Created by Daniele Giammarresi on 18/02/26.
//

import Foundation
import SwiftUI

struct CreateView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.openURL) var openURL
    @Binding var user: User
    
    @State var engineering: String = "Select engineering"
    @State var subject: String = "Select subject"
    @State var building: String = "Select Building"
    @State var room: String = ""
    @State var date: Date = Date()
    @State var description: String = ""
    @State var linkWhatsapp: String = ""
    @State var linkTelegram: String = ""
    
    let materieDisponibili: [String] = ["Select Subject"]
    let materieComputer = ["Select subject","Calculus I","Calculus II","Physics I", "Physics II","Geometry","Algebra","Fundaments of Programming","Algorithms and Data Structures","Computer Architecture","Programming","Data Base","Computer Networks and the Internet","Automatic controls","Signal theory","Electrical Engineering","Eletronics","Software Engineering", "Operating System", "Web and Mobile Programming" ]
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
    let materieBiomedical = [
        "Select subject",
        "Calculus I",
        "Geometry and Algebra",
        "Physics I",
        "Chemistry",
        "Fundamentals of Computer Science",
        "Calculus II",
        "Physics II",
        "Anatomy and Physiology",
        "Biomaterials",
        "Biomechanics",
        "Biomedical Instrumentation",
        "Signals and Systems",
        "Electronics",
        "Control Systems",
        "Clinical Engineering",
        "Medical Image Processing",
        "Bioinformatics",
        "Tissue Engineering"
    ]
    let materieManagement = [
        "Select subject", "Calculus I", "Geometry and Algebra", "Physics I", "Chemistry", "Fundamentals of Computer Science", "Microeconomics", "Calculus II", "Physics II", "Statistics", "Operations Research", "Business Economics and Organization", "Electrical Engineering", "Applied Mechanics", "Industrial Plants", "Manufacturing Technology", "Information Systems", "Logistics and Supply Chain Management", "Quality Engineering", "Project Management"
    ]

    let edificiDisponibili = ["Select Building","Building 6", "Building 7", "Building 8", "Building 9", "Building 10"]
    let facoltaIngegneristica = ["Select engineering","Management", "Computer", "Electrical", "Civil","Biomedical", "Mechanical"]
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Info")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.leading, 5)
                    Spacer()
                }
                VStack {
                    Picker("engineering", selection: $engineering){
                        ForEach(facoltaIngegneristica, id: \.self) { ingegneria in
                            Text(ingegneria)
                        }
                    }
                    Divider()
                    if engineering == "Computer"{
                        Picker("Subject", selection: $subject){
                            ForEach(materieComputer, id: \.self) {
                                materia in Text(materia)
                            }.tint(.blue)
                        }
                    } else if(engineering == "Electrical"){
                        Picker("Subject", selection: $subject){
                            ForEach(materieElectrical, id: \.self) {
                                materia in Text(materia)
                            }.tint(.blue)
                        }
                    } else if(engineering == "Mechanical"){
                        Picker("Subject", selection: $subject){
                            ForEach(materieMechanical, id: \.self) {
                                materia in Text(materia)
                            }.tint(.blue)
                        }
                    } else if(engineering == "Civil"){
                        Picker("Subject", selection: $subject){
                            ForEach(materieCivil, id: \.self) {
                                materia in Text(materia)
                            }.tint(.blue)
                        }
                    } else if(engineering == "Biomedical"){
                            Picker("Subject", selection: $subject){
                                ForEach(materieBiomedical, id: \.self) {
                                    materia in Text(materia)
                                }.tint(.blue)
                            }
                    } else if(engineering == "Management"){
                            Picker("Subject", selection: $subject){
                                ForEach(materieManagement, id: \.self) {
                                    materia in Text(materia)
                                }.tint(.blue)
                            }
                    } else {
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
            .padding(.top, 10)
            
            VStack {
                HStack {
                    Text("Place and Date")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.leading)
                    Spacer()
                }
                VStack {
                    Picker("building", selection: $building){
                        ForEach(edificiDisponibili, id: \.self) { edificio in
                            Text(edificio)
                        }
                    }
                    .tint(.blue)
                    Divider()
                    TextField("Insert Huddle room: ", text: $room)
                        .padding(.vertical, 5)
                    Divider()
                    DatePicker(selection: $date, label: { Text("Huddle date: ") })
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
            
            VStack {
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
        // MARK: - STILE APPLE: Titolo e Tasto in alto a destra
        .navigationTitle("New Huddle")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    // 1. Creiamo l'oggetto Huddle
                    var nuovoHuddle = Huddle(
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
                    nuovoHuddle.users.append(user)
                    user.huddles.append(nuovoHuddle)
                    
                    let _ = HuddleService.shared.updateUser(utenteAggiornato: user)
                    
                    let salvataggioRiuscito = HuddleService.shared.addHuddle(nuovoHuddle: nuovoHuddle)
                    
                    if salvataggioRiuscito {
                        print("Huddle salvato con successo!")
                        dismiss()
                    } else {
                        print("Errore nel salvataggio")
                    }
                }) {
                    Text("Done")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CreateView(user: .constant(User(userName: "Daniele", mail: "daniele@community.unipa.it", huddles: [])))
    }
}
