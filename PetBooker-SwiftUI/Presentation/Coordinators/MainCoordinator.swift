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
    // navigation TabView
}

@MainActor
class MainCoordinator: ObservableObject {
    
    // MARK: State
    @Published var selectedTab: MainTab = .dashboard
    
    // 1. Coordinadores anidados (uno para cada tab)
    //@Published var dashboardCoordinator: DashboardCoordinator
    //@Published var profileCoordinator: ProfileCoordinator
    
    // MARK: Callbacks
    // 4. Callback para notificar al AppCoordinator sobre el logout
    private var onLogout: () -> Void
    
    init(onLogout: @escaping () -> Void) {
        self.onLogout = onLogout
        
        // 5. Crear los coordinadores anidados
        // Inyectamos las dependencias que necesiten
        //self.dashboardCoordinator = DashboardCoordinator()
        
        // Inyectamos la acción de logout al ProfileCoordinator
        // para que pueda propagarla hacia arriba.
        //self.profileCoordinator = ProfileCoordinator(onLogout: onLogout)
    }
}
