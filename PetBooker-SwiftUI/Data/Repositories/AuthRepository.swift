//
//  DefaultAuthRepository.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 7/11/25.
//

import Foundation

class AuthRepository: AuthRepositoryProtocol {
    
    private let remoteDataSource: AuthDataSourceProtocol
    
    init(remoteDataSource: AuthDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func login(email: String, password: String) async throws -> User {
        let authUserDTO = try await remoteDataSource.login(email: email, password: password)
        let appUser = UserMapper.map(authUserDTO: authUserDTO)
        return appUser
    }
    
    func logout() async throws {
        try await remoteDataSource.logout()
    }
    
    func getCurrentUser() async throws -> User? {
        let authUserDTO = try await remoteDataSource.getCurrentUser()
        
        guard let authUserDTO = authUserDTO else {
            return nil
        }
    
        let appUser = UserMapper.map(authUserDTO: authUserDTO)
        return appUser
    }
    
    func checkSession() async -> Bool {
        return await remoteDataSource.checkSession()
    }
}
