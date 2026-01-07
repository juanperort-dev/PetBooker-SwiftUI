//
//  MockLoginUseCase.swift
//  PetBooker-SwiftUITests
//
//  Created by Juan José Perálvarez Ortiz on 8/11/25.
//

import Foundation
@testable import PetBooker_SwiftUI

enum MockAuthError: Error {
    case generic
    case invalidCredentials
}

class MockLoginUseCase: LoginUseCaseProtocol {
    
    var result: Result<User, Error> = .success(User(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000123")!,
        email: "test@example.com",
        name: "Test User",
        surnames: "User Test",
        phoneNumber: nil,
        dateOfBirth: nil,
    ))
    
    var executeCalled = false
    var passedEmail: String?
    var passedPassword: String?
    
    func execute(email: String, password: String) async throws -> User {
        executeCalled = true
        passedEmail = email
        passedPassword = password
        
        try await Task.sleep(for: .milliseconds(10))
        
        switch result {
        case .success(let user):
            return user
        case .failure(let error):
            throw error
        }
    }
}
