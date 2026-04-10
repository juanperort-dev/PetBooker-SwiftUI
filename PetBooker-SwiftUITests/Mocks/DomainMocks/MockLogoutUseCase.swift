//
//  MockLogoutUseCase.swift
//  PetBooker-SwiftUITests
//

import Foundation
@testable import PetBooker_SwiftUI

class MockLogoutUseCase: LogoutUseCaseProtocol {
    var executeCalled = false
    var shouldThrow = false

    func execute() async throws {
        executeCalled = true
        if shouldThrow {
            throw AuthDomainError.unknown("Mock logout error")
        }
    }
}
