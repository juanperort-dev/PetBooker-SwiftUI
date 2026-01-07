//
//  DIContainer.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 21/5/25.
//


import Foundation
import Supabase

@MainActor
class DIContainer: ObservableObject {
    
    // MARK: - Instancias Únicas Compartidas (Singletons)
    
    private static let sharedSessionService = UserSessionService()
    
    private lazy var supabaseClient: SupabaseClient = {
        let supabaseURLString = Config.string(forKey: .supabaseURL).trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\"", with: "")
        let supabaseKey = Config.string(forKey: .supabaseKey).trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\"", with: "")
            
        guard let supabaseURL = URL(string: supabaseURLString) else {
            fatalError("La URL de Supabase obtenida es inválida: \(supabaseURLString)")
        }
            
        return SupabaseClient(
            supabaseURL: supabaseURL,
            supabaseKey: supabaseKey,
            options: SupabaseClientOptions(
                auth: .init(
                    emitLocalSessionAsInitialSession: true
                )
            )
        )
    }()
    
    private lazy var sharedAppCoordinator: AppCoordinator = {
        return AppCoordinator(
            container: self,
            sessionService: makeUserSessionService()
        )
    }()
    
    // MARK: Fábricas de Data (Data Layer)
    func makeSupabaseAuthDataSource() -> AuthDataSourceProtocol {
        return SupabaseAuthDataSource(client: supabaseClient)
    }
    
    func makeAuthRepository() -> AuthRepositoryProtocol {
        return AuthRepository(remoteDataSource: makeSupabaseAuthDataSource())
    }
    
    // MARK: Fábricas de Dominio (Domain Layer)
    
    func makeLoginUseCase() -> LoginUseCaseProtocol {
        return LoginUseCase(
            authRepository: makeAuthRepository(),
            sessionService: makeUserSessionService()
        )
    }
    
    func makeLogoutUseCase() -> LogoutUseCaseProtocol {
        return LogoutUseCase(
            authRepository: makeAuthRepository(),
            sessionService: makeUserSessionService()
        )
    }
    
    func makeCheckUserSessionUseCase() -> CheckUserSessionUseCaseProtocol {
        return CheckUserSessionUseCase(authRepository: makeAuthRepository())
    }
    
    func makeUserSessionService() -> any UserSessionServiceProtocol {
        return DIContainer.sharedSessionService
    }
    
    // MARK: Fábricas de Core/Coordinación
    
    func makeAppCoordinator() -> AppCoordinator {
        return sharedAppCoordinator
    }
    
    func makeAuthCoordinator(onAuthSuccess: @escaping (User) -> Void) -> AuthCoordinator {
        return AuthCoordinator(
            loginUseCase: makeLoginUseCase(),
            onAuthSuccess: onAuthSuccess
        )
    }
    
    func makeMainCoordinator(onLogout: @escaping () -> Void) -> MainCoordinator {
        return MainCoordinator(
            logoutUseCase: makeLogoutUseCase(),
            sessionService: makeUserSessionService(),
            onLogout: onLogout
        )
    }
}
