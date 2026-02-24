//
//  EditProfileView.swift
//
//  Created by Daniele Giammarresi on 18/02/26.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Binding var user: User?
    @EnvironmentObject private var session: SessionManager
    @Environment(\.dismiss) private var dismiss
    
    @State private var newUsername: String = ""
    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var profileImage: Image? = nil
    @State private var showSavedConfirmation = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Edit Profile")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding(.top)
            
            // MARK: - Photo
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
            .onChange(of: selectedPhoto) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        profileImage = Image(uiImage: uiImage)
                    }
                }
            }
            
            // MARK: - Username Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Username")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                TextField("Enter new username", text: $newUsername)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(16)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                Text("Email cannot be changed")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(session.currentEmail ?? user?.mail ?? "")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemGray5))
                    .cornerRadius(16)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            
            // MARK: - Save Button
            Button(action: {
                guard !newUsername.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                
                // Update session
                let email = session.currentEmail ?? user?.mail ?? ""
                session.saveSession(email: email, username: newUsername)
                
                // Update local user binding
                user?.userName = newUsername
                
                // Update UserDefaults users dictionary
                var users = UserDefaults.standard.dictionary(forKey: "huddle_users") as? [String: String] ?? [:]
                users[email] = newUsername
                UserDefaults.standard.set(users, forKey: "huddle_users")
                
                showSavedConfirmation = true
            }) {
                Text("Save Changes")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(16)
            }
            .padding(.horizontal)
            .alert("Saved!", isPresented: $showSavedConfirmation) {
                Button("OK") { dismiss() }
            } message: {
                Text("Your profile has been updated.")
            }
            
            Spacer()
        }
        .onAppear {
            newUsername = session.currentUsername ?? user?.userName ?? ""
        }
    }
}

#Preview {
    EditProfileView(user: .constant(User(userName: "salvo", mail: "salvatore.scaravalle@community.unipa.it")))
        .environmentObject(SessionManager.shared)
}
