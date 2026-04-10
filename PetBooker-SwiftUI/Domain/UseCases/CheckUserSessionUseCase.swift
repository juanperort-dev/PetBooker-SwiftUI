//
//  CheckUserSessionUseCase.swift
//  PetBooker-SwiftUI
//

import Foundation

public protocol CheckUserSessionUseCaseProtocol {
    func execute() async -> User?
}

public class CheckUserSessionUseCase: CheckUserSessionUseCaseProtocol {
    private let authRepository: AuthRepositoryProtocol

    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }

    public func execute() async -> User? {
        do {
            return try await authRepository.getCurrentUser()
        } catch {
            return nil
        }
    }
}
