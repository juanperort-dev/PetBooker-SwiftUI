//
//  LoginViewModel.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 28/7/25.
//

import Foundation
import Combine
import SwiftUI
import Auth

class LoginViewModel: ObservableObject {
    
    // MARK: Dependencies
    private let loginUseCase: LoginUseCaseProtocol
    
    // MARK: Navigation Callbacks
    private let onLoginSuccess: (User) -> Void
    private let onGoToRegister: () -> Void
    
    // MARK: Estado de la UI
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(loginUseCase: LoginUseCaseProtocol,
         onLoginSuccess: @escaping (User) -> Void,
         onGoToRegister: @escaping () -> Void) {
        
        self.loginUseCase = loginUseCase
        self.onLoginSuccess = onLoginSuccess
        self.onGoToRegister = onGoToRegister
    }
    
    // MARK: UI Actions
    func registerButtonTapped() {
        self.onGoToRegister()
    }
    
    func loginButtonTapped() {
        isLoading = true
        errorMessage = nil
        
        Task { @MainActor in
            do {
                let user = try await loginUseCase.execute(
                    email: self.email,
                    password: self.password
                )
                self.isLoading = false
                self.onLoginSuccess(user)
                
            } catch {
                self.isLoading = false
                
                if let authError = error as? AuthError {
                    print("ERROR DE AUTENTICACIÓN DE SUPABASE: \(authError.message)")
                    self.errorMessage = authError.message
                } else {
                    self.errorMessage = "Error de inicio de sesión. Revisa tus credenciales."
                }
            }
        }
    }
}
