//
//  welcomeView.swift
//  Huddle
//
//  Created by Salvatore Scaravalle on 26/02/26.
//

import SwiftUI

struct WelcomeView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.white, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            TabView {
                OnboardingPage(
                    imageName: "person.3.fill",
                    title: "Explore Huddle",
                    description: "Find study group for your subject"
                )
                
                OnboardingPage(
                    imageName: "plus.circle.fill",
                    title: "Create Huddle",
                    description: "Create a study group for your subject"
                )
                
                ZStack {
                    OnboardingPage(
                        imageName: "fireworks",
                        title: "Are you ready?",
                        description: ""
                    )
                    
                    VStack {
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                isOnboarding = false
                            }
                        }) {
                            Text("START NOW")
                                .font(.headline).bold()
                                .foregroundStyle(.blue)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(16)
                                .shadow(radius: 10)
                        }
                        .padding(.horizontal, 40)
                        .padding(.bottom, 60)
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
}

struct OnboardingPage: View {
    let imageName: String
    let title: String
    let description: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: imageName)
                .font(.system(size: 100))
                .foregroundStyle(.white)
                .padding(.bottom, 20)
            
            Text(title)
                .font(.largeTitle).bold()
                .foregroundStyle(.white)
            
            Text(description)
                .font(.title3)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.opacity(0.9))
                .padding(.horizontal)
        }
    }
}

#Preview {
    WelcomeView()
}
