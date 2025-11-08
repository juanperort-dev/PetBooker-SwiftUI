//
//  AppCoordinator.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 4/11/25.
//

import Foundation
import SwiftUI
import Combine

enum AppState {
    case splash
    case unauthenticated
    case authenticated
}

@MainActor
class AppCoordinator: ObservableObject {
    
    @Published var appState: AppState = .splash
    
    // MARK: Coordinators
    @Published var authCoordinator: AuthCoordinator!
    @Published var mainCoordinator: MainCoordinator!
    
    init() {
        // Check Token
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.checkAuthentication()
        }
    }
    
    func checkAuthentication() {
        let hasSession = false
        
        hasSession ? showMainFlow() : showAuthFlow()
    }
    
    func showAuthFlow() {
        self.authCoordinator = AuthCoordinator(
            onAuthSuccess: { [weak self] in
                self?.showMainFlow()
            }
        )
        self.appState = .unauthenticated
    }
    
    func showMainFlow() {
        self.mainCoordinator = MainCoordinator(
            onLogout: { [weak self] in
                self?.showAuthFlow()
            }
        )
        self.appState = .authenticated
    }
}
