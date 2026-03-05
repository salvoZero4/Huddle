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
    
<<<<<<< Updated upstream
    let team = "PA4ZQ2S678QH" // Il tuo team corretto!
=======
    let team = SecretsManager.shared.parthenokitTeam
>>>>>>> Stashed changes
    let tag = "HUDDLES"
    let chiaveLista = "TUTTI_GLI_HUDDLE" // La nostra scatola unica!
    
    var p = ParthenoKit()
    
    // Costruttore privato
    private init() {}
    
    // MARK: - SCARICA TUTTI GLI EVENTI
    public func fetchAllHuddles() -> [Huddle] {
        let dic = p.readSync(team: team, tag: tag, key: chiaveLista)
        
        if let extracted = dic[chiaveLista] {
            if let jsonData = extracted.replacingOccurrences(of: "\\", with: "", options: .literal, range: nil).data(using: .utf8) {
                do {
                    // Decodifica un intero array di Huddle!
                    let lista = try JSONDecoder().decode([Huddle].self, from: jsonData)
                    return lista
                } catch {
                    print("Errore nella deserializzazione della lista: \(error)")
                }
            }
        }
        return [] // Se non c'è nulla, restituisce una lista vuota
    }
    
    // MARK: - AGGIUNGI UN NUOVO EVENTO ALLA LISTA
    public func addHuddle(nuovoHuddle: Huddle) -> Bool {
        // 1. Scarica la lista vecchia da ParthenoKit
        var listaAttuale = fetchAllHuddles()
        
        // 2. Aggiunge il tuo nuovo evento alla fine della lista
        listaAttuale.append(nuovoHuddle)
        
        // 3. Risalva l'intera lista aggiornata su internet
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
    // MARK: - AGGIORNA UN EVENTO ESISTENTE
        public func updateHuddle(huddleAggiornato: Huddle) -> Bool {
            var listaAttuale = fetchAllHuddles()
            
            // Cerca l'evento vecchio nella lista e lo sostituisce con quello nuovo (con l'utente aggiunto)
            if let index = listaAttuale.firstIndex(where: { $0.id == huddleAggiornato.id }) {
                listaAttuale[index] = huddleAggiornato
                
                // Risalva l'intera lista aggiornata su internet
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
    // MARK: - AGGIORNA E SALVA L'UTENTE
    public func updateUser(utenteAggiornato: User) -> Bool {
        // Usiamo come chiave l'email o l'ID dell'utente per non sovrascrivere gli altri!
        let chiaveUtente = "UTENTE_\(utenteAggiornato.mail)"
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(utenteAggiornato)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                // Salva su ParthenoKit l'utente con la sua lista "personale" di huddle
                return p.writeSync(team: team, tag: "USERS", key: chiaveUtente, value: jsonString)
            }
        } catch {
            print("Errore nel salvataggio dell'utente: \(error)")
        }
        return false
    }
    // MARK: - RECUPERA L'UTENTE DAL PARTHENOKIT
    public func fetchUser(email: String) -> User? {
        // Usiamo la stessa identica chiave che abbiamo usato per salvare!
        let chiaveUtente = "UTENTE_\(email)"
        
        // Leggiamo dal database (ricorda di usare lo stesso tag, ad esempio "USERS")
        let dic = p.readSync(team: team, tag: "USERS", key: chiaveUtente)
        
        if let extracted = dic[chiaveUtente] {
            // Puliamo la stringa dai backslash di troppo e la trasformiamo in dati
            if let jsonData = extracted.replacingOccurrences(of: "\\", with: "", options: .literal, range: nil).data(using: .utf8) {
                do {
                    // Decodifichiamo il singolo oggetto User
                    let utente = try JSONDecoder().decode(User.self, from: jsonData)
                    return utente
                } catch {
                    print("Errore nella deserializzazione dell'utente: \(error)")
                }
            }
        }
        
        // Se l'utente non è stato trovato (es. è il primo avvio) o c'è un errore, restituiamo nil
        return nil
    }

}