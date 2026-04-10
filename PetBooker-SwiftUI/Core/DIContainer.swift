//
//  DIContainer.swift
//  PetBooker-SwiftUI
//

import Foundation
import Supabase

@MainActor
class DIContainer: ObservableObject {

    // MARK: - Shared Singletons

    private static let sharedSessionService = UserSessionService()

    private lazy var supabaseClient: SupabaseClient = {
        let urlString = Config.string(forKey: .supabaseURL)
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "\"", with: "")
        let key = Config.string(forKey: .supabaseKey)
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "\"", with: "")

        guard let url = URL(string: urlString) else {
            fatalError("La URL de Supabase obtenida es inválida: \(urlString)")
        }

        return SupabaseClient(
            supabaseURL: url,
            supabaseKey: key,
            options: SupabaseClientOptions(
                auth: .init(emitLocalSessionAsInitialSession: true)
            )
        )
    }()

    /// Shared repository instance — avoids creating multiple instances per use case.
    private lazy var authRepository: AuthRepositoryProtocol = {
        AuthRepositoryImpl(remoteDataSource: SupabaseAuthDataSource(client: supabaseClient))
    }()

    private lazy var sharedAppCoordinator: AppCoordinator = {
        AppCoordinator(container: self, sessionService: makeUserSessionService())
    }()

    // MARK: - Domain Factories

    func makeLoginUseCase() -> LoginUseCaseProtocol {
        LoginUseCase(authRepository: authRepository)
    }

    func makeLogoutUseCase() -> LogoutUseCaseProtocol {
        LogoutUseCase(authRepository: authRepository, sessionService: makeUserSessionService())
    }

    func makeCheckUserSessionUseCase() -> CheckUserSessionUseCaseProtocol {
        CheckUserSessionUseCase(authRepository: authRepository)
    }

    func makeUserSessionService() -> any UserSessionServiceProtocol {
        DIContainer.sharedSessionService
    }

    // MARK: - Coordinator Factories

    func makeAppCoordinator() -> AppCoordinator {
        sharedAppCoordinator
    }

    func makeAuthCoordinator(onAuthSuccess: @escaping (User) -> Void) -> AuthCoordinator {
        AuthCoordinator(loginUseCase: makeLoginUseCase(), onAuthSuccess: onAuthSuccess)
    }

    func makeMainCoordinator(onLogout: @escaping () -> Void) -> MainCoordinator {
        MainCoordinator(logoutUseCase: makeLogoutUseCase(), onLogout: onLogout)
    }
}
