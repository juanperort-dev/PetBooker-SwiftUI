//
//  AuthRepository.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 7/11/25.
//

import Foundation

protocol AuthRepositoryProtocol {
    func login(email: String, password: String) async throws -> User
    func logout() async throws
    func getCurrentUser() async throws -> User?
    func checkSession() async -> Bool
}
