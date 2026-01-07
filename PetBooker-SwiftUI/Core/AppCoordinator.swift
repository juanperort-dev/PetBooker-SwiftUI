//
//  AppCoordinator.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 4/11/25.
//

import Foundation
import SwiftUI
import Combine

public enum AppScreen {
    case splash
    case unauthenticated
    case authenticated
}

@MainActor
class AppCoordinator: ObservableObject {
    
    // MARK: - Dependencias y Servicios
    private let container: DIContainer
    private let checkUserSessionUseCase: CheckUserSessionUseCaseProtocol
    private let sessionService: any UserSessionServiceProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var currentUser: User? = nil
    @Published var isAuthenticated: Bool = false
    
    // MARK: - Navegación
    @Published var appScreen: AppScreen = .splash
    @Published var authCoordinator: AuthCoordinator!
    @Published var mainCoordinator: MainCoordinator!
    
    // MARK: - Inicialización (Inyección de Dependencias)
    init(container: DIContainer, sessionService: any UserSessionServiceProtocol) {
        self.container = container
        self.checkUserSessionUseCase = container.makeCheckUserSessionUseCase()
        self.sessionService = sessionService
        
        if let sessionObservable = sessionService as? UserSessionService {
            sessionObservable.objectWillChange
                .sink { [weak self] _ in
                    guard let self = self else { return }
                    self.currentUser = self.sessionService.currentUser
                    self.isAuthenticated = self.currentUser != nil
                    self.objectWillChange.send()
                }
                .store(in: &self.cancellables)
        }
        sessionService.loadSession()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            Task {
                await self.checkAuthentication()
            }
        }
    }
    
    // MARK: - Orquestación
    func checkAuthentication() async {
        if sessionService.currentUser != nil {
            self.showMainFlow(user: sessionService.currentUser!)
            return
        }
        
        let user = await checkUserSessionUseCase.execute()
        
        if let user = user {
            sessionService.login(user: user)
            self.showMainFlow(user: user)
        } else {
            self.showAuthFlow()
        }
    }
    
    func showAuthFlow() {
        self.mainCoordinator = nil
        self.authCoordinator = container.makeAuthCoordinator(
            onAuthSuccess: { [weak self] user in
                self?.showMainFlow(user: user)
            }
        )
        self.appScreen = .unauthenticated
    }
    
    func showMainFlow(user: User) {
        self.authCoordinator = nil
        self.mainCoordinator = container.makeMainCoordinator(
            onLogout: { [weak self] in
                self?.showAuthFlow()
            }
        )
        self.appScreen = .authenticated
    }
}
