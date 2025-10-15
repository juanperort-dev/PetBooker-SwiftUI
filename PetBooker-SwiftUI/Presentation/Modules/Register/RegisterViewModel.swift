//
//  RegisterViewModel.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 14/10/25.
//

import Foundation

@MainActor
final class RegisterViewModel: ObservableObject {
    // MARK: – Campos del formulario
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
    
    var isFormValid: Bool {
        // ToDo
        return true
    }
    
    func register() async {
        // ToDo
    }
}
