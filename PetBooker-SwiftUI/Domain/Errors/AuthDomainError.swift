//
//  AuthDomainError.swift
//  PetBooker-SwiftUI
//

import Foundation

enum AuthDomainError: LocalizedError {
    case invalidCredentials
    case userNotFound
    case networkError
    case sessionExpired
    case unknown(String)

    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Credenciales incorrectas. Revisa tu email y contraseña."
        case .userNotFound:
            return "No se encontró ninguna cuenta con ese email."
        case .networkError:
            return "Error de conexión. Comprueba tu red e inténtalo de nuevo."
        case .sessionExpired:
            return "Tu sesión ha expirado. Por favor, inicia sesión de nuevo."
        case .unknown(let message):
            return message
        }
    }
}
