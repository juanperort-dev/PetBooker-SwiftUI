//
//  AppCoordinator.swift
//  PetBooker-SwiftUI
//

import Foundation
import SwiftUI

public enum AppScreen {
    case splash
    case unauthenticated
    case authenticated
}

@MainActor
class AppCoordinator: ObservableObject {

    // MARK: - Dependencies
    private let container: DIContainer
    private let checkUserSessionUseCase: CheckUserSessionUseCaseProtocol
    private let sessionService: any UserSessionServiceProtocol

    // MARK: - Navigation State
    @Published var appScreen: AppScreen = .splash
    @Published var authCoordinator: AuthCoordinator?
    @Published var mainCoordinator: MainCoordinator?

    // MARK: - Init
    init(container: DIContainer, sessionService: any UserSessionServiceProtocol) {
        self.container = container
        self.checkUserSessionUseCase = container.makeCheckUserSessionUseCase()
        self.sessionService = sessionService

        sessionService.loadSession()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            Task { await self.checkAuthentication() }
        }
    }

    // MARK: - Orchestration

    func checkAuthentication() async {
        if sessionService.currentUser != nil {
            showMainFlow()
            return
        }

        if let user = await checkUserSessionUseCase.execute() {
            sessionService.login(user: user)
            showMainFlow()
        } else {
            showAuthFlow()
        }
    }

    func showAuthFlow() {
        mainCoordinator = nil
        authCoordinator = container.makeAuthCoordinator(
            onAuthSuccess: { [weak self] user in
                self?.sessionService.login(user: user)
                self?.showMainFlow()
            }
        )
        appScreen = .unauthenticated
    }

    func showMainFlow() {
        authCoordinator = nil
        mainCoordinator = container.makeMainCoordinator(
            onLogout: { [weak self] in
                self?.showAuthFlow()
            }
        )
        appScreen = .authenticated
    }
}
