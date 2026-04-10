//
//  MainCoordinator.swift
//  PetBooker-SwiftUI
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
    private let onLogout: () -> Void

    init(logoutUseCase: LogoutUseCaseProtocol, onLogout: @escaping () -> Void) {
        self.logoutUseCase = logoutUseCase
        self.onLogout = onLogout
    }

    // MARK: View Factory

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
        let viewModel = DashboardViewModel()
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
}
