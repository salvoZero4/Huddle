

//
//  RegisterView.swift
//  Hubble
//
//  Created by Yasmine Ghomrassi on 19/02/26.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var username = ""
    @State private var email = ""
    @State private var verificationCode = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                // MARK: - Logo
                Image("HuddleLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .padding(.top, 80)
                    .padding(.bottom, 20)
                // MARK: - Title
                Text("Welcome To Huddle")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 36)
                
                // MARK: - Form Fields
                VStack(spacing: 22) {
                    
                    // Username Field
                    FieldGroup(
                        label: "Username",
                        hint: "3-20 characters, letters and numbers only"
                    ) {
                        CustomTextField(
                            placeholder: "Choose a unique username",
                            text: $username,
                            icon: "person"
                        )
                    }
                    
                    // Email Field
                    FieldGroup(
                        label: "University Email",
                        hint: "Use your official email address"
                    ) {
                        CustomTextField(
                            placeholder: "your.name@comunity.unipa.it",
                            text: $email,
                            icon: "envelope",
                            keyboardType: .emailAddress
                        )
                    }
                    
                    // Verification Code Field
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 4) {
                            Text("Verification Code")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.black)
                            Text("*")
                                .foregroundColor(.red)
                                .font(.system(size: 16, weight: .semibold))
                        }
                        
                        HStack(spacing: 10) {
                            // Code input
                            HStack {
                                TextField("Enter code from email", text: $verificationCode)
                                    .font(.system(size: 15))
                                    .keyboardType(.numberPad)
                            }
                            .padding(.horizontal, 14)
                            .padding(.vertical, 14)
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            
                            // Send Code Button
                            Button(action: {
                                print("Send verification code")
                            }) {
                                Text("Send Code")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 18)
                                    .padding(.vertical, 14)
                                    .background(Color.blue)
                                    .cornerRadius(12)
                            }
                        }
                        
                        Text("Click \"Send Code\" to receive verification")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal, 24)
                
                // MARK: - Sign In Button
                Button(action: {
                    print("Sign In pressed")
                }) {
                    Text("Sign In")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(Color.blue)
                        .cornerRadius(16)
                }
                .padding(.horizontal, 24)
                .padding(.top, 36)
                .padding(.bottom, 40)
            }
        }
        .background(Color.white)
        .ignoresSafeArea(edges: .top)
    }
}

// MARK: - Reusable Field Group
struct FieldGroup<Content: View>: View {
    let label: String
    let hint: String
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 4) {
                Text(label)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                Text("*")
                    .foregroundColor(.red)
                    .font(.system(size: 16, weight: .semibold))
            }
            
            content
            
            Text(hint)
                .font(.system(size: 13))
                .foregroundColor(.gray)
        }
    }
}

// MARK: - Custom Text Field with Icon
struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    let icon: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .foregroundColor(.gray)
                .frame(width: 20)
            
            TextField(placeholder, text: $text)
                .font(.system(size: 15))
                .keyboardType(keyboardType)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 14)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

#Preview {
    RegisterView()
}
