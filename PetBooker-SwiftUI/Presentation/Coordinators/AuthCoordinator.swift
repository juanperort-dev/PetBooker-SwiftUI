//
//  AuthCoordinator.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 4/11/25.
//

import Foundation
import SwiftUI

enum AuthScreen: Hashable {
    case login
    case register
}

@MainActor
class AuthCoordinator: ObservableObject {
    
    @Published var path: [AuthScreen] = []
    
    // MARK: Dependencies (CORRECCIÓN 2: Ahora depende del Caso de Uso, no del Repositorio)
    private let loginUseCase: LoginUseCaseProtocol
    
    // MARK: Callbacks (CORRECCIÓN 1: Ahora acepta el objeto User)
    private var onAuthSuccess: (User) -> Void
    
    init(loginUseCase: LoginUseCaseProtocol, onAuthSuccess: @escaping (User) -> Void) {
        self.loginUseCase = loginUseCase
        self.onAuthSuccess = onAuthSuccess
    }
    
    func goToRegister() {
        path.append(AuthScreen.register)
    }
    
    func goBack() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func loginSucceeded(user: User) {
        popToRoot()
        onAuthSuccess(user)
    }
    
    // MARK: View Factory
    @ViewBuilder
    func makeView(for screen: AuthScreen) -> some View {
        switch screen {
        case .login:
            makeLoginView()
        case .register:
            makeRegisterView()
        }
    }
    
    private func makeLoginView() -> some View {
        let viewModel = LoginViewModel(
            loginUseCase: self.loginUseCase,
            onLoginSuccess: { [weak self] user in
                self?.loginSucceeded(user: user)
            },
            onGoToRegister: { [weak self] in
                self?.goToRegister()
            }
        )
        return LoginView(viewModel: viewModel)
    }
    
    private func makeRegisterView() -> some View {
        let viewModel = RegisterViewModel(
            onRegisterSuccess: { [weak self] in
                self?.popToRoot()
            }
        )
        return RegisterView(viewModel: viewModel, onLoginTap: { [weak self] in
            self?.goBack()
        })
    }
}
