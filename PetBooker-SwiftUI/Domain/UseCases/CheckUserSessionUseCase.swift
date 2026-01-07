//
//  CheckUserSessionUseCase.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 9/11/25.
//

public protocol CheckUserSessionUseCaseProtocol {
    func execute() async -> User?
}

import Foundation

public class CheckUserSessionUseCase: CheckUserSessionUseCaseProtocol {
    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }
    
    public func execute() async -> User? {
        do {
            let user = try await authRepository.getCurrentUser()
            return user
        } catch {
            print("ERROR al obtener sesión de usuario: \(error.localizedDescription)")
            return nil
        }
    }
}
