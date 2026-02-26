//  EmailService.swift
//  Huddle

import Foundation

class EmailService {
    
    static let shared = EmailService()
    
    private let serviceID  = "service_pl68vz2"
    private let templateID = "template_gl2qdlm"
    private let publicKey  = "p_S8MMkOsyTspeo__"
    
    func sendVerificationCode(to email: String, code: String) async throws {
        let url = URL(string: "https://api.emailjs.com/api/v1.0/email/send")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("http://localhost", forHTTPHeaderField: "origin")
        
        let body: [String: Any] = [
            "service_id":  serviceID,
            "template_id": templateID,
            "user_id":     publicKey,
            "template_params": [
                "to_email": email,
                "code":     code
            ]
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
        let responseString = String(data: data, encoding: .utf8) ?? ""
        print("📧 EmailJS status: \(statusCode)")
        print("📧 EmailJS response: \(responseString)")
        
        guard statusCode == 200 else {
            throw EmailError.sendFailed(responseString)
        }
    }
}

enum EmailError: LocalizedError {
    case sendFailed(String)
    var errorDescription: String? {
        switch self {
        case .sendFailed(let reason):
            return "Failed to send email: \(reason)"
        }
    }
}
