//
//  SupabaseAuthDataSource.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 7/11/25.
//

import Foundation
import Supabase

class SupabaseAuthDataSource: AuthDataSourceProtocol {
    
    private let client: SupabaseClient
    
    init(client: SupabaseClient) {
        self.client = client
    }
    
    func login(email: String, password: String) async throws -> AuthUserDTO{
        do {
            let session = try await client.auth.signIn(email: email, password: password)
            return AuthUserDTO(
                id: session.user.id.uuidString,
                email: session.user.email ?? "",
                userMetadata: session.user.userMetadata
            )
            
        } catch {
            throw error
        }
    }
    
    func checkSession() async -> Bool {
        return (try? await self.client.auth.session) != nil
    }
    
    func getCurrentUser() async throws -> AuthUserDTO? {
        let session = try await client.auth.session
        return AuthUserDTO(
            id: session.user.id.uuidString,
            email: session.user.email ?? "",
            userMetadata: session.user.userMetadata
        )
    }
    
    func logout() async throws {
        try await client.auth.signOut()
    }
}
