//
//  LogoutUseCase.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 9/11/25.
//

import Foundation

public protocol LogoutUseCaseProtocol {
    func execute() async throws
}

public class LogoutUseCase: LogoutUseCaseProtocol {
    private let authRepository: AuthRepositoryProtocol
    private let sessionService: any UserSessionServiceProtocol
    
    init(authRepository: AuthRepositoryProtocol,
         sessionService: any UserSessionServiceProtocol) {
        self.authRepository = authRepository
        self.sessionService = sessionService
    }
    
    public func execute() async throws {
        try await authRepository.logout()
        await sessionService.logout()
    }
}
