//
//  LoginViewModelTests.swift
//  PetBooker-SwiftUITests
//
//  Created by Juan José Perálvarez Ortiz on 8/11/25.
//

import Testing
import Foundation
@testable import PetBooker_SwiftUI

struct LoginViewModelTests {
    
    // MARK: - Test de Navegación Simple
    @Test func registerButtonTapped_callsGoToRegisterCallback() {
        // ARRANGE
        var registerCalled = false
        
        let viewModel = LoginViewModel(
            loginUseCase: MockLoginUseCase(),
            onLoginSuccess: { },
            onGoToRegister: {
                registerCalled = true
            }
        )
        
        // ACT
        viewModel.registerButtonTapped()
        
        // ASSERT
        #expect(registerCalled == true, "El callback onGoToRegister debe ser llamado.")
    }
    
    // MARK: - Tests de Flujo de Éxito
    
    @Test func loginButtonTapped_onSuccess_updatesStateAndNavigates() async throws {
        // ARRANGE
        let mockLoginUseCase = MockLoginUseCase()
        var successCalled = false
        
        let viewModel = LoginViewModel(
            loginUseCase: mockLoginUseCase,
            onLoginSuccess: {
                successCalled = true
            },
            onGoToRegister: { }
        )
        
        // Initial state MainActor
        await MainActor.run {
            viewModel.email = "test@example.com"
            viewModel.password = "TestPassword123"
        }
        
        // ACT: Llamamos directamente al método asíncrono
        viewModel.loginButtonTapped()
        
        // Pausa 1: Esperamos a que el Task dentro del ViewModel se inicie
        await Task.yield()
        
        // ASSERT 1: Verificar el estado de carga inicial
        await MainActor.run {
            #expect(viewModel.isLoading == true, "isLoading debe ser true inmediatamente.")
        }
        
        // ⚠️ CORRECCIÓN CLAVE: Pausa para darle al MainActor tiempo de completar
        // la llamada al UseCase (Mock) y ejecutar el bloque de éxito/catch.
        try await Task.sleep(for: .milliseconds(50))
        
        // ASSERT 2: Verificar la llamada al Use Case y los parámetros
        #expect(mockLoginUseCase.executeCalled == true, "El Use Case debe ser llamado.")
        #expect(mockLoginUseCase.passedEmail == "test@example.com")
        #expect(mockLoginUseCase.passedPassword == "TestPassword123")
        
        // ASSERT 3: Verificar el estado final y la navegación en el MainActor
        await MainActor.run {
            #expect(viewModel.isLoading == false, "isLoading debe volver a ser false.")
            #expect(successCalled == true, "El callback onLoginSuccess debe ser llamado.")
            #expect(viewModel.errorMessage == nil, "El errorMessage debe ser nil.")
        }
    }
    
    // MARK: - Tests de Flujo de Fallo
    
    @Test func loginButtonTapped_onFailure_updatesStateAndSetsErrorMessage() async throws {
        // ARRANGE
        let mockLoginUseCase = MockLoginUseCase()
        mockLoginUseCase.result = .failure(MockAuthError.invalidCredentials)
        var successCalled = false
        let viewModel = LoginViewModel(
            loginUseCase: mockLoginUseCase,
            onLoginSuccess: {
                successCalled = true
            },
            onGoToRegister: { }
        )
        
        // Initial state MainActor
        await MainActor.run {
            viewModel.email = "test@example.com"
            viewModel.password = "SecurePassword123"
        }
        
        // ACT: Llamamos directamente al método asíncrono
        viewModel.loginButtonTapped()
        
        // Pausa 1: Esperamos a que el Task dentro del ViewModel se inicie
        await Task.yield()
        
        // ASSERT 1: Verificar el estado de carga inicial
        await MainActor.run {
            #expect(viewModel.isLoading == true)
        }
        
        // ⚠️ CORRECCIÓN CLAVE: Pausa para darle al MainActor tiempo de completar
        // la llamada al UseCase (Mock) y ejecutar el bloque de éxito/catch.
        try await Task.sleep(for: .milliseconds(50))
        
        // ASSERT 2: El estado final y la navegación
        await MainActor.run {
            #expect(viewModel.isLoading == false, "isLoading debe ser false tras el fallo.")
            #expect(successCalled == false, "onLoginSuccess NO debe ser llamado.")
            
            // ASSERT 3: El mensaje de error debe ser visible (el ViewModel maneja el error genérico)
            #expect(viewModel.errorMessage != nil, "Debe haber un mensaje de error.")
            #expect(viewModel.errorMessage == "Error de inicio de sesión. Revisa tus credenciales.")
        }
    }
}
