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
    // forgotPassword
}

@MainActor
class AuthCoordinator: ObservableObject {
    
    @Published var path: [AuthScreen] = []
    
    // MARK: Callbacks
    private var onAuthSuccess: () -> Void
    
    init(onAuthSuccess: @escaping () -> Void) {
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
    
    func loginSucceeded() {
        onAuthSuccess()
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
            onLoginSuccess: { [weak self] in
                self?.loginSucceeded()
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
        return RegisterView(viewModel: viewModel)
    }
}
