//
//  UserMapper.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 7/11/25.
//

import Foundation
import Supabase

struct UserMapper {
    static func map(authUserDTO: AuthUserDTO) -> User {
        let metadata = authUserDTO.userMetadata ?? [:]
        
        let dateString = metadata["date_of_birth"] as? String
        let dateOfBirth = SupabaseDateUtils.date(from: dateString)
        let phoneNumber = metadata["phone_number"] as? String
        guard let userID = UUID(uuidString: authUserDTO.id) else {
            fatalError("Error de mapeo: El ID de usuario del servidor no es un UUID válido: \(authUserDTO.id)")
        }
        
        return User(
            id: userID,
            email: authUserDTO.email,
            name: metadata["name"] as? String ?? "DefaultNameMapper",
            surnames: metadata["surnames"] as? String ?? "DefaultSurnameMapper",
            phoneNumber: phoneNumber,
            dateOfBirth: dateOfBirth
        )
    }
}
