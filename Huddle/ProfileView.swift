//
//  ProfileView.swift
//  
//
//  Created by Daniele Giammarresi on 18/02/26.
//

import SwiftUI

struct ProfileView: View {
    @Binding var user : User?
    @EnvironmentObject private var session: SessionManager
    @State private var showLogoutConfirmation = false
    var body: some View {
        VStack{
            
            Text("My Profile")
                .padding()
                .font(.system(size: 20))
                .fontWeight(.bold)
            NavigationStack{
                VStack{
                    VStack{
                        HStack{
                            Spacer()
                            VStack{
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .colorMultiply(.blue)
                                    .padding()
                                    .aspectRatio(contentMode: .fill)
                                if let user {
                                    Text(user.userName)
                                        .font(.system(size: 30))
                                        .fontWeight(.bold)
                                    Text(user.mail)
                                        .padding([.bottom])
                                        .font(.system(size: 15))
                                        .foregroundColor(.blue)
                                        .fontWeight(.bold)
                                }
                            }
                            Spacer()
                        }
                        
                        
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color(.systemGray6))
                    )
                }
                NavigationLink(destination: EditProfileView(user: $user)){
                    Text("Edit Profile")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .fontWeight(.bold)
                }
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(.systemGray6))
                )
                VStack {
                    Button("Logout") {
                        showLogoutConfirmation = true
                    }
                    .foregroundStyle(.red)
                    .fontWeight(.bold)
                    .alert("Sei sicuro di voler uscire?", isPresented: $showLogoutConfirmation) {
                        Button("Accetta", role: .destructive) {
                            session.clearSession()
                            print("Logout effettuato")
                        }
                        Button("Annulla", role: .cancel) { }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(.systemGray6))
                )
                Spacer()
                
                       
            }
            
            
        }
        .padding()
    }
}
#Preview {
    ProfileView(user: .constant(User(userName: "salvo", mail: "salvatore.scaravalle@community.unipa.it",huddles:[])))
}

