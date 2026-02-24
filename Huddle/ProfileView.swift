//
//  ProfileView.swift
//  Huddle
//
//  Created by Daniele Giammarresi on 18/02/26.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var session: SessionManager
    @State private var showLogoutConfirmation = false
    @State private var user: User? = nil
    
    var body: some View {
        VStack {
            Text("My Profile")
                .padding()
                .font(.system(size: 20))
                .fontWeight(.bold)
            
            NavigationStack {
                VStack {
                    VStack {
                        HStack {
                            Spacer()
                            VStack {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .colorMultiply(.blue)
                                    .padding()
                                    .aspectRatio(contentMode: .fill)
                                
                                Text(session.currentUsername ?? "Unknown")
                                    .font(.system(size: 30))
                                    .fontWeight(.bold)
                                
                                Text(session.currentEmail ?? "")
                                    .padding([.bottom])
                                    .font(.system(size: 15))
                                    .foregroundColor(.blue)
                                    .fontWeight(.bold)
                            }
                            Spacer()
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color(.systemGray6))
                    )
                }
                
                NavigationLink(destination: EditProfileView(user: $user)) {
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
                    .alert("Are you sure you want to logout?", isPresented: $showLogoutConfirmation) {
                        Button("Logout", role: .destructive) {
                            session.clearSession()
                        }
                        Button("Cancel", role: .cancel) { }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(.systemGray6))
                )
                
                Spacer()
            }
        }
        .padding()
        .onAppear {
            // Load full user from ParthenoKit
            if let email = session.currentEmail {
                user = HuddleService.shared.fetchUser(email: email)
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(SessionManager.shared)
}
