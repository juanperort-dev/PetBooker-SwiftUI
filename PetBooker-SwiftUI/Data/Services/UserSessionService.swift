//
//  UserSessionService.swift
//  PetBooker-SwiftUI
//

import Foundation
import Combine

@MainActor
class UserSessionService: ObservableObject, UserSessionServiceProtocol {

    @Published public private(set) var currentUser: User? = nil

    public func login(user: User) {
        self.currentUser = user
    }

    public func logout() {
        self.currentUser = nil
    }

    public func loadSession() {
        // Session is loaded via Supabase SDK on CheckUserSessionUseCase
    }
}
