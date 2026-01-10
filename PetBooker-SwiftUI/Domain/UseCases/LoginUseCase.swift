//
//  LoginUseCase.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 7/11/25.
//

import Foundation

protocol LoginUseCaseProtocol {
    func execute(email: String, password: String) async throws -> User
}

class LoginUseCase: LoginUseCaseProtocol {
    private let authRepository: AuthRepositoryProtocol
    private let sessionService: any UserSessionServiceProtocol
    
    init(authRepository: AuthRepositoryProtocol,
         sessionService: any UserSessionServiceProtocol) {
        self.authRepository = authRepository
        self.sessionService = sessionService
    }
    
    func execute(email: String, password: String) async throws -> User {
        let loggedInUser = try await authRepository.login(email: email, password: password)
        await sessionService.login(user: loggedInUser)
        
        return loggedInUser
    }
}
