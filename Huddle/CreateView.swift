//
//  CreateView.swift
//  
//
//  Created by Daniele Giammarresi on 18/02/26.
//

import SwiftUI

struct CreateView: View {
    @State var title: String = ""
    @Binding var Huddle: []
    @Binding var Huddle: []
    @State var aula: String = ""
    @State var date: Date = Date()
    //@State var linkWhatsapp: String
    //@State var linkTelegram: String
    
    var body: some View {
        ScrollView {
            Text("Create a Huddle")
                .font(.system(size: 20))
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
                    TextField("Insert Huddle title: ", text: $title)
                        .padding(.vertical, 5)
                    Divider()
                    TextField("Insert Huddle subject: ", text: $subject)
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
                    //TextField("Insert Huddle building: ", text: $building)
                        //.padding(.vertical, 5)
                    Divider()
                    TextField("Insert Huddle aula: ", text: $aula)
                        .padding(.vertical, 5)
                    Divider()
                    DatePicker(selection: $date, label: {Text("Huddle date: ")} )
        
                              
                              
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(25)
            }
            .padding()
        }
    }
}
#Preview {
    CreateView()
}
