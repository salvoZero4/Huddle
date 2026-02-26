//  RegisterViewModel.swift
//  Huddle

import Foundation
import SwiftUI
import Combine

@MainActor
class RegisterViewModel: ObservableObject {
    @Published var username         = ""
    @Published var email            = ""
    @Published var verificationCode = ""
    @Published var isLoading      = false
    @Published var errorMessage:   String? = nil
    @Published var successMessage: String? = nil
    @Published var codeSent        = false
    @Published var isNewUser:      Bool?   = nil
    
    private var generatedCode: String? = nil
    private var codeExpiry:    Date?   = nil
    
    private let session = SessionManager.shared
    private let emails  = EmailService.shared
    
    func sendCode() async {
        errorMessage   = nil
        successMessage = nil
        
        guard isValidEmail(email) else {
            errorMessage = "Please use your university email (@community.unipa.it)"
            return
        }
        
        guard isValidUsername(username) else {
            errorMessage = "Username must be 3–20 characters, letters and numbers only."
            return
        }
        
        isLoading = true
        
        let existingUsers = UserDefaults.standard.dictionary(forKey: "huddle_users") as? [String: String] ?? [:]
        isNewUser = existingUsers[email] == nil
       
        if isNewUser == true {
            let takenUsernames = existingUsers.values.map { $0.lowercased() }
            if takenUsernames.contains(username.lowercased()) {
                errorMessage = "This username is already taken. Please choose another."
                isLoading    = false
                return
            }
        }
        
        let code = String(format: "%06d", Int.random(in: 0..<1000000))
        generatedCode = code
        codeExpiry    = Date().addingTimeInterval(600)
        
        do {
            try await emails.sendVerificationCode(to: email, code: code)
            codeSent       = true
            successMessage = "Code sent! Check your university email."
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func submit() async {
        errorMessage = nil
        
        guard !verificationCode.isEmpty else {
            errorMessage = "Please enter the verification code."
            return
        }
        
        guard verifyCode() else { return }
        
        if isNewUser == true {
            await register()
        } else {
            await login()
        }
    }
    
    private func register() async {
        isLoading = true
        
        var users = UserDefaults.standard.dictionary(forKey: "huddle_users") as? [String: String] ?? [:]
        
        let takenUsernames = users.values.map { $0.lowercased() }
        if takenUsernames.contains(username.lowercased()) {
            errorMessage = "This username is already taken. Please choose another."
            isLoading    = false
            return
        }
        
        users[email] = username
        UserDefaults.standard.set(users, forKey: "huddle_users")
        session.saveSession(email: email, username: username)
        
        isLoading = false
    }
    
    private func login() async {
        isLoading = true
        
        var users = UserDefaults.standard.dictionary(forKey: "huddle_users") as? [String: String] ?? [:]
        users[email] = username  // ← overwrite with new username
        UserDefaults.standard.set(users, forKey: "huddle_users")
        
        session.saveSession(email: email, username: username)
        
        isLoading = false
    }
    
    private func verifyCode() -> Bool {
        guard let stored = generatedCode, let expiry = codeExpiry else {
            errorMessage = "Please request a code first."
            return false
        }
        guard Date() < expiry else {
            errorMessage = "Code expired. Please request a new one."
            return false
        }
        guard verificationCode == stored else {
            errorMessage = "Incorrect code. Please try again."
            return false
        }
        return true
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        email.hasSuffix("@community.unipa.it") || email.hasSuffix("@unipa.it")
    }
    
    private func isValidUsername(_ username: String) -> Bool {
        let range = 3...20
        let regex = "^[a-zA-Z0-9]+$"
        return range.contains(username.count) &&
               username.range(of: regex, options: .regularExpression) != nil
    }
}
