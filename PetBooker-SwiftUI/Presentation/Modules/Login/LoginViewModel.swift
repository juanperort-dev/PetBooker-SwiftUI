//
//  LoginViewModel.swift
//  PetBooker-SwiftUI
//

import Foundation

@MainActor
class LoginViewModel: ObservableObject {

    // MARK: Dependencies
    private let loginUseCase: LoginUseCaseProtocol

    // MARK: Navigation Callbacks
    private let onLoginSuccess: (User) -> Void
    private let onGoToRegister: () -> Void

    // MARK: UI State
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    init(loginUseCase: LoginUseCaseProtocol,
         onLoginSuccess: @escaping (User) -> Void,
         onGoToRegister: @escaping () -> Void) {
        self.loginUseCase = loginUseCase
        self.onLoginSuccess = onLoginSuccess
        self.onGoToRegister = onGoToRegister
    }

    // MARK: UI Actions

    func registerButtonTapped() {
        onGoToRegister()
    }

    func loginButtonTapped() {
        isLoading = true
        errorMessage = nil

        Task { @MainActor in
            do {
                let user = try await loginUseCase.execute(email: self.email, password: self.password)
                self.isLoading = false
                self.onLoginSuccess(user)
            } catch let error as AuthDomainError {
                self.isLoading = false
                self.errorMessage = error.localizedDescription
            } catch {
                self.isLoading = false
                self.errorMessage = "Error de inicio de sesión. Revisa tus credenciales."
            }
        }
    }
}
