//
//  EditProfileView.swift
//  Hubble
//
//  Created by Salvatore Scaravalle on 19/02/26.
//

import Foundation
import SwiftUI

struct EditProfileView: View {
    
    @Binding var user: User?
    @State var userName = ""
    var body: some View {
        VStack{
            Spacer()
            VStack{
                TextField("Inserisci il nuovo Username", text: $userName)
                    .font(.system(size: 20))
                    .padding()
                
                
            }
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color(.systemGray6))
            ).padding(.horizontal)

            Button(action: {
                if var currentUser = user {
                    currentUser.userName = userName
                    user = currentUser
                    _ = HuddleService.shared.updateUser(utenteAggiornato: currentUser)

                }
            }){
                Text("Conferma")
                    .padding()
                
            }.frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(.systemGray6))
                ).padding(.horizontal)
              
            Spacer()
            Spacer()

            
            
            
            }
 
        
    }
}

#Preview {
    EditProfileView(user: .constant(User(userName: "userName", mail: "salvo", huddles: [])))
}
