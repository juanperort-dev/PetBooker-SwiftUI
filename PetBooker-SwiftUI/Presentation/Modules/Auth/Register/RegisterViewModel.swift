//
//  RegisterViewModel.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 14/10/25.
//

import Foundation

@MainActor
final class RegisterViewModel: ObservableObject {
    
    // MARK: – Form fields
    @Published var firstName: String = ""
    @Published var lastName: String  = ""
    @Published var email: String     = ""
    @Published var password: String  = ""
    @Published var confirmPassword: String = ""
    
    // MARK: – UI State
    @Published var showPassword: Bool = false
    @Published var showConfirm: Bool  = false
    @Published var isLoading: Bool    = false
    @Published var errorMessage: String = ""
    
    // MARK: Callbacks
    private let onRegisterSuccess: () -> Void
    
    init(onRegisterSuccess: @escaping () -> Void) {
        self.onRegisterSuccess = onRegisterSuccess
    }
    
    var isFormValid: Bool {
        // ToDo
        return true
    }
    
    func register() async {
        // ToDo
    }
}
