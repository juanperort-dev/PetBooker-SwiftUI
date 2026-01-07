//
//  AuthDataSourceProtocol.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 8/11/25.
//

import Foundation

public protocol AuthDataSourceProtocol {
    func login(email: String, password: String) async throws -> AuthUserDTO
    func getCurrentUser() async throws -> AuthUserDTO?
    func checkSession() async -> Bool
    func logout() async throws
}
