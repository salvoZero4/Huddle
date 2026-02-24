//  RegisterViewModel.swift
//  Huddle

import Foundation
import SwiftUI
import Combine
import ParthenoKit

@MainActor
class RegisterViewModel: ObservableObject {
    
    // MARK: - Input
    @Published var username         = ""
    @Published var email            = ""
    @Published var verificationCode = ""
    
    // MARK: - State
    @Published var isLoading      = false
    @Published var errorMessage:   String? = nil
    @Published var successMessage: String? = nil
    @Published var codeSent        = false
    @Published var isNewUser:      Bool?   = nil
    
    private var generatedCode: String? = nil
    private var codeExpiry:    Date?   = nil
    
    private let session = SessionManager.shared
    private let emails  = EmailService.shared
    private let db      = ParthenoKit()
    
    private let team = "PA4ZQ2S678QH"
    private let tag  = "users"
    
    // MARK: - Step 1: Send Code
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
        
        let existing = db.readSync(team: team, tag: tag, key: email)
        isNewUser = existing.isEmpty
        
        if isNewUser == true {
            let takenResult = db.readSync(team: team, tag: "usernames", key: username.lowercased())
            if !takenResult.isEmpty {
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
    
    // MARK: - Step 2: Submit
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
    
    // MARK: - Register
    private func register() async {
        isLoading = true
        
        let takenResult = db.readSync(team: team, tag: "usernames", key: username.lowercased())
        if !takenResult.isEmpty {
            errorMessage = "This username is already taken. Please choose another."
            isLoading    = false
            return
        }
        
        let _ = db.writeSync(team: team, tag: tag, key: email, value: username)
        let _ = db.writeSync(team: team, tag: "usernames", key: username.lowercased(), value: email)
        
        session.saveSession(email: email, username: username)
        isLoading = false
    }
    
    // MARK: - Login
    private func login() async {
        isLoading = true
        
        let _ = db.writeSync(team: team, tag: tag, key: email, value: username)
        let _ = db.writeSync(team: team, tag: "usernames", key: username.lowercased(), value: email)
        
        session.saveSession(email: email, username: username)
        isLoading = false
    }
    
    // MARK: - Code Verification
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
    
    // MARK: - Validation
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
