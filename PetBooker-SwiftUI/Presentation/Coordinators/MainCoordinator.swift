//
//  MainCoordinator.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 4/11/25.
//

import Foundation
import SwiftUI

enum MainTab: Hashable {
    case dashboard
    case profile
}

@MainActor
class MainCoordinator: ObservableObject {
    
    // MARK: State
    @Published var selectedTab: MainTab = .dashboard
    
    private let logoutUseCase: LogoutUseCaseProtocol
    private let sessionService: any UserSessionServiceProtocol
    private let getCompaniesUseCase: GetCompaniesUseCaseProtocol
    
    // MARK: Callbacks
    private var onLogout: () -> Void
    
    init(logoutUseCase: LogoutUseCaseProtocol,
         sessionService: any UserSessionServiceProtocol,
         getCompaniesUseCase: GetCompaniesUseCaseProtocol,
         onLogout: @escaping () -> Void
    ) {
        self.logoutUseCase = logoutUseCase
        self.sessionService = sessionService
        self.getCompaniesUseCase = getCompaniesUseCase
        self.onLogout = onLogout
    }
    
    // MARK: View Factory (CORRECCIÓN PRINCIPAL)
    @ViewBuilder
    func makeTabView(for tab: MainTab) -> some View {
        switch tab {
        case .dashboard:
            makeDashboardView()
        case .profile:
            makeProfileView()
        }
    }
    
    private func makeDashboardView() -> some View {
        let viewModel = DashboardViewModel(getCompaniesUseCase: self.getCompaniesUseCase)
        return DashboardView(viewModel: viewModel)
    }
    
    private func makeProfileView() -> some View {
        let viewModel = ProfileViewModel(
            logoutUseCase: self.logoutUseCase,
            onLogoutSuccess: { [weak self] in
                self?.onLogout()
            }
        )
        return NavigationStack {
            ProfileView(viewModel: viewModel)
        }
    }
    
    func logout() {
        Task { @MainActor in
            do {
                try await logoutUseCase.execute()
                self.onLogout()
            } catch {
                print("Error al cerrar sesión: \(error)")
            }
        }
    }
}
