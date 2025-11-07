//
//  LoginViewModel.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 28/7/25.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    // MARK: Callbacks
    private let onLoginSuccess: () -> Void
    private let onGoToRegister: () -> Void
    
    init(onLoginSuccess: @escaping () -> Void, onGoToRegister: @escaping () -> Void) {
        self.onLoginSuccess = onLoginSuccess
        self.onGoToRegister = onGoToRegister
    }
    
    func registerButtonTapped() {
        self.onGoToRegister()
    }
    
    func loginWithEmailAndPassword() {

    }
}
