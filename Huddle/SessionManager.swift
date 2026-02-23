//  SessionManager.swift
//  Hubble

import Foundation
import SwiftUI
import Combine

class SessionManager: ObservableObject {
    
    static let shared = SessionManager()
    
    @Published var isLoggedIn: Bool = false
    @Published var currentEmail: String? = nil
    @Published var currentUsername: String? = nil
    
    private let emailKey    = "huddle_email"
    private let usernameKey = "huddle_username"
    
    init() {
        if let email = UserDefaults.standard.string(forKey: emailKey) {
            self.currentEmail    = email
            self.currentUsername = UserDefaults.standard.string(forKey: usernameKey)
            self.isLoggedIn      = true
        }
    }
    
    func saveSession(email: String, username: String) {
        UserDefaults.standard.set(email,    forKey: emailKey)
        UserDefaults.standard.set(username, forKey: usernameKey)
        self.currentEmail    = email
        self.currentUsername = username
        self.isLoggedIn      = true
    }
    
    func clearSession() {
        UserDefaults.standard.removeObject(forKey: emailKey)
        UserDefaults.standard.removeObject(forKey: usernameKey)
        self.currentEmail    = nil
        self.currentUsername = nil
        self.isLoggedIn      = false
    }
}
