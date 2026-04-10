//
//  AuthRepositoryImpl.swift
//  PetBooker-SwiftUI
//

import Foundation
import Auth

class AuthRepositoryImpl: AuthRepositoryProtocol {

    private let remoteDataSource: AuthDataSourceProtocol

    init(remoteDataSource: AuthDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }

    func login(email: String, password: String) async throws -> User {
        do {
            let authUserDTO = try await remoteDataSource.login(email: email, password: password)
            return UserMapper.map(authUserDTO: authUserDTO)
        } catch let error as AuthError {
            throw mapToAuthDomainError(error)
        } catch {
            throw AuthDomainError.unknown(error.localizedDescription)
        }
    }

    func logout() async throws {
        try await remoteDataSource.logout()
    }

    func getCurrentUser() async throws -> User? {
        do {
            guard let authUserDTO = try await remoteDataSource.getCurrentUser() else {
                return nil
            }
            return UserMapper.map(authUserDTO: authUserDTO)
        } catch {
            throw AuthDomainError.sessionExpired
        }
    }

    func checkSession() async -> Bool {
        return await remoteDataSource.checkSession()
    }

    // MARK: - Private

    private func mapToAuthDomainError(_ error: AuthError) -> AuthDomainError {
        let message = error.message.lowercased()
        if message.contains("invalid login credentials") || message.contains("invalid") {
            return .invalidCredentials
        }
        if message.contains("user not found") {
            return .userNotFound
        }
        if message.contains("network") || message.contains("connection") {
            return .networkError
        }
        return .unknown(error.message)
    }
}
