//
//  DatabaseManager.swift
//  Hubble
//
//  Created by Salvatore Scaravalle on 24/02/26.
//

import Foundation
import ParthenoKit

class HuddleService {
    static let shared = HuddleService()
    
    let team = SecretsManager.shared.parthenokitTeam
    let tag = "HUDDLES"
    let chiaveLista = "TUTTI_GLI_HUDDLE"
    
    var p = ParthenoKit()
    
    private init() {}
    
    public func fetchAllHuddles() -> [Huddle] {
        let dic = p.readSync(team: team, tag: tag, key: chiaveLista)
        
        if let extracted = dic[chiaveLista] {
            if let jsonData = extracted.replacingOccurrences(of: "\\", with: "", options: .literal, range: nil).data(using: .utf8) {
                do {
                    let lista = try JSONDecoder().decode([Huddle].self, from: jsonData)
                    return lista
                } catch {
                    print("Errore nella deserializzazione della lista: \(error)")
                }
            }
        }
        return []
    }
    
    public func addHuddle(nuovoHuddle: Huddle) -> Bool {
        var listaAttuale = fetchAllHuddles()
        
        listaAttuale.append(nuovoHuddle)
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(listaAttuale)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return p.writeSync(team: team, tag: tag, key: chiaveLista, value: jsonString)
            }
        } catch {
            print("Errore nella serializzazione: \(error)")
        }
        return false
    }
    
        public func updateHuddle(huddleAggiornato: Huddle) -> Bool {
            var listaAttuale = fetchAllHuddles()
            
            if let index = listaAttuale.firstIndex(where: { $0.id == huddleAggiornato.id }) {
                listaAttuale[index] = huddleAggiornato
                
                let encoder = JSONEncoder()
                do {
                    let jsonData = try encoder.encode(listaAttuale)
                    if let jsonString = String(data: jsonData, encoding: .utf8) {
                        return p.writeSync(team: team, tag: tag, key: chiaveLista, value: jsonString)
                    }
                } catch {
                    print("Errore nella serializzazione: \(error)")
                }
            }
            return false
        }
    
    public func updateUser(utenteAggiornato: User) -> Bool {
        let chiaveUtente = "UTENTE_\(utenteAggiornato.mail)"
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(utenteAggiornato)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return p.writeSync(team: team, tag: "USERS", key: chiaveUtente, value: jsonString)
            }
        } catch {
            print("Errore nel salvataggio dell'utente: \(error)")
        }
        return false
    }
    public func fetchUser(email: String) -> User? {
        let chiaveUtente = "UTENTE_\(email)"
        let dic = p.readSync(team: team, tag: "USERS", key: chiaveUtente)
        
        if let extracted = dic[chiaveUtente] {
            if let jsonData = extracted.replacingOccurrences(of: "\\", with: "", options: .literal, range: nil).data(using: .utf8) {
                do {
                    let utente = try JSONDecoder().decode(User.self, from: jsonData)
                    return utente
                } catch {
                    print("Errore nella deserializzazione dell'utente: \(error)")
                }
            }
        }
        return nil
    }

}