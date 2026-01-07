//
//  Config.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 7/11/25.
//

import Foundation

enum Config {
    
    enum Key: String {
        case supabaseURL = "SupabaseURL"
        case supabaseKey = "SupabaseKey"
    }
    
    static func string(forKey key: Key) -> String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key.rawValue) as? String else {
            fatalError("La clave '\(key.rawValue)' no se encontró en Info.plist.")
        }
        
        if value.starts(with: "$(") {
            fatalError("El valor para '\(key.rawValue)' no fue sustituido. Revisa tu configuración .xcconfig.")
        }
        
        return value
    }
}
