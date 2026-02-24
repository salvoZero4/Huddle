//
//  ProfileView.swift
//
//  Created by Daniele Giammarresi on 18/02/26.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @Binding var user: User?
    @EnvironmentObject private var session: SessionManager
    @State private var showLogoutConfirmation = false
    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var profileImage: Image? = nil
    
    var body: some View {
        VStack(spacing: 16) {
            
            Text("My Profile")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding(.top)
            
            NavigationStack {
                VStack(spacing: 12) {
                    
                    // MARK: - Avatar + Info
                    VStack {
                        HStack {
                            Spacer()
                            VStack(spacing: 8) {
                                
                                // Profile Photo
                                PhotosPicker(selection: $selectedPhoto, matching: .images) {
                                    ZStack(alignment: .bottomTrailing) {
                                        if let profileImage {
                                            profileImage
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 90, height: 90)
                                                .clipShape(Circle())
                                        } else {
                                            Image(systemName: "person.circle.fill")
                                                .resizable()
                                                .frame(width: 90, height: 90)
                                                .foregroundColor(.blue)
                                        }
                                        Image(systemName: "pencil.circle.fill")
                                            .foregroundColor(.blue)
                                            .background(Color.white)
                                            .clipShape(Circle())
                                            .offset(x: 4, y: 4)
                                    }
                                }
                                .padding(.top)
                                .onChange(of: selectedPhoto) { newItem in
                                    Task {
                                        if let data = try? await newItem?.loadTransferable(type: Data.self),
                                           let uiImage = UIImage(data: data) {
                                            profileImage = Image(uiImage: uiImage)
                                        }
                                    }
                                }
                                
                                // Name and email from session
                                Text(session.currentUsername ?? user?.userName ?? "Unknown")
                                    .font(.system(size: 28))
                                    .fontWeight(.bold)
                                
                                Text(session.currentEmail ?? user?.mail ?? "")
                                    .font(.system(size: 14))
                                    .foregroundColor(.blue)
                                    .fontWeight(.bold)
                                    .padding(.bottom)
                            }
                            Spacer()
                        }
                    }
                    .background(RoundedRectangle(cornerRadius: 25).fill(Color(.systemGray6)))
                    
                    // MARK: - Edit Profile
                    NavigationLink(destination: EditProfileView(user: $user)) {
                        HStack {
                            Image(systemName: "pencil")
                                .foregroundColor(.primary)
                            Text("Edit Profile")
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                    }
                    .background(RoundedRectangle(cornerRadius: 25).fill(Color(.systemGray6)))
                    
                    // MARK: - Logout
                    Button(action: {
                        showLogoutConfirmation = true
                    }) {
                        Text("Exit (Logout)")
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                    .background(RoundedRectangle(cornerRadius: 25).fill(Color(.systemGray6)))
                    .alert("Are you sure you want to logout?", isPresented: $showLogoutConfirmation) {
                        Button("Logout", role: .destructive) {
                            session.clearSession()
                        }
                        Button("Cancel", role: .cancel) { }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ProfileView(user: .constant(User(userName: "salvo", mail: "salvatore.scaravalle@community.unipa.it")))
        .environmentObject(SessionManager.shared)
}
