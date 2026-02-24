//  RegisterView.swift
//  Huddle
//
//  Created by Yasmine Ghomrassi on 19/02/26.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var vm = RegisterViewModel()
    @EnvironmentObject private var session: SessionManager
    @State private var onboardingComplete = false
    
    var body: some View {
        if onboardingComplete {
            RegisterFormView(vm: vm)
                .environmentObject(session)
        } else {
            OnboardingWizardView(onboardingComplete: $onboardingComplete)
        }
    }
}

// MARK: - Onboarding Wizard
struct OnboardingWizardView: View {
    @Binding var onboardingComplete: Bool
    
    let slides: [(image: String, title: String, description: String)] = [
        (
            image: "wizard_1",
            title: "Find Study Groups",
            description: "Discover huddles created by students in your faculty. Filter by subject and join the ones that fit you."
        ),
        (
            image: "wizard_2",
            title: "Create Your Huddle",
            description: "Organize a study session, pick a room, set a date and invite your classmates to join."
        ),
        (
            image: "wizard_3",
            title: "Connect & Collaborate",
            description: "Share WhatsApp or Telegram links with your group and stay connected with your study partners."
        )
    ]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(0..<slides.count, id: \.self) { index in
                        ZStack(alignment: .bottom) {
                            
                            Image(slides[index].image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: geo.size.width, height: geo.size.height)
                                .clipped()
                            
                            LinearGradient(
                                colors: [Color.clear, Color.black.opacity(0.75)],
                                startPoint: .center,
                                endPoint: .bottom
                            )
                            .frame(width: geo.size.width, height: geo.size.height)
                            
                            VStack(spacing: 12) {
                                Text(slides[index].title)
                                    .font(.system(size: 28, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                
                                Text(slides[index].description)
                                    .font(.system(size: 15))
                                    .foregroundColor(.white.opacity(0.85))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 24)
                                
                                if index == slides.count - 1 {
                                    Button(action: {
                                        withAnimation {
                                            onboardingComplete = true
                                        }
                                    }) {
                                        Text("Get Started")
                                            .fontWeight(.bold)
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(15)
                                            .shadow(radius: 5)
                                    }
                                    .padding(.horizontal, 32)
                                    .padding(.top, 8)
                                } else {
                                    HStack(spacing: 4) {
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.white.opacity(0.7))
                                            .font(.system(size: 20))
                                        Text("Swipe")
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.6))
                                    }
                                    .padding(.top, 8)
                                }
                            }
                            .padding(.bottom, 60)
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                    }
                }
            }
            .ignoresSafeArea()
            .scrollTargetBehavior(.paging)
        }
        .ignoresSafeArea()
    }
}

// MARK: - Register Form
struct RegisterFormView: View {
    @ObservedObject var vm: RegisterViewModel
    @EnvironmentObject private var session: SessionManager
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                Image("HuddleLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .padding(.top, 80)
                    .padding(.bottom, 20)
                
                Text("Welcome To Huddle")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 36)
                
                VStack(spacing: 22) {
                    
                    FieldGroup(
                        label: "Username",
                        hint: "3-20 characters, letters and numbers only"
                    ) {
                        CustomTextField(
                            placeholder: "Choose a unique username",
                            text: $vm.username,
                            icon: "person"
                        )
                    }
                    
                    FieldGroup(
                        label: "University Email",
                        hint: "Use your official email address"
                    ) {
                        CustomTextField(
                            placeholder: "your.name@community.unipa.it",
                            text: $vm.email,
                            icon: "envelope",
                            keyboardType: .emailAddress
                        )
                    }
                    
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
                            TextField("Enter code from email", text: $vm.verificationCode)
                                .font(.system(size: 15))
                                .keyboardType(.numberPad)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 14)
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            
                            Button(action: {
                                Task { await vm.sendCode() }
                            }) {
                                if vm.isLoading && !vm.codeSent {
                                    ProgressView().tint(.white)
                                        .padding(.horizontal, 18)
                                        .padding(.vertical, 14)
                                        .background(Color.blue)
                                        .cornerRadius(12)
                                } else {
                                    Text(vm.codeSent ? "Resend" : "Send Code")
                                        .font(.system(size: 15, weight: .semibold))
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 18)
                                        .padding(.vertical, 14)
                                        .background(Color.blue)
                                        .cornerRadius(12)
                                }
                            }
                            .disabled(vm.isLoading)
                        }
                        
                        if let success = vm.successMessage {
                            Text(success)
                                .font(.system(size: 13))
                                .foregroundColor(.green)
                        } else {
                            Text("Click \"Send Code\" to receive verification")
                                .font(.system(size: 13))
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.horizontal, 24)
                
                Button(action: {
                    Task { await vm.submit() }
                }) {
                    if vm.isLoading && vm.codeSent {
                        ProgressView().tint(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(Color.blue)
                            .cornerRadius(16)
                    } else {
                        Text("Sign In")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(Color.blue)
                            .cornerRadius(16)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 36)
                .disabled(vm.isLoading)
                
                if let error = vm.errorMessage {
                    Text(error)
                        .font(.system(size: 14))
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .padding(.top, 12)
                }
                
                Spacer().frame(height: 40)
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
        .environmentObject(SessionManager.shared)
}
