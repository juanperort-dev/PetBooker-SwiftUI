//
//  ProfileViewModel.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 9/11/25.
//

import Foundation

@MainActor
class ProfileViewModel: ObservableObject {
    
    // MARK: Dependencies
    private let logoutUseCase: LogoutUseCaseProtocol
    
    // MARK: Callbacks
    private let onLogoutSuccess: () -> Void
    
    // MARK: Initialization
    init(logoutUseCase: LogoutUseCaseProtocol,
         onLogoutSuccess: @escaping () -> Void
    ) {
        self.logoutUseCase = logoutUseCase
        self.onLogoutSuccess = onLogoutSuccess
    }
    
    // MARK: Action
    
    func logoutButtonTapped() {
        Task { @MainActor in
            do {
                try await logoutUseCase.execute()
                self.onLogoutSuccess()
            } catch {
                print("Error en el logout: \(error.localizedDescription)")
            }
        }
    }
}
