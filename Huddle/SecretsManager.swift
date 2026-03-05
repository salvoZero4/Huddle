//  SecretsManager.swift
//  Huddle

import Foundation

struct SecretsManager {
    static let shared = SecretsManager()

    private var secrets: [String: String] = [:]

    private init() {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path) as? [String: String]
        else {
            fatalError("⚠️ Secrets.plist not found. Copy Secrets.plist.example to Secrets.plist and fill in your keys.")
        }
        secrets = dict
    }

    func value(for key: String) -> String {
        guard let val = secrets[key], !val.isEmpty else {
            fatalError("⚠️ Missing value for key '\(key)' in Secrets.plist")
        }
        return val
    }

    var emailjsServiceID:  String { value(for: "EMAILJS_SERVICE_ID") }
    var emailjsTemplateID: String { value(for: "EMAILJS_TEMPLATE_ID") }
    var emailjsPublicKey:  String { value(for: "EMAILJS_PUBLIC_KEY") }
    var parthenokitTeam:   String { value(for: "PARTHENOKIT_TEAM") }
}