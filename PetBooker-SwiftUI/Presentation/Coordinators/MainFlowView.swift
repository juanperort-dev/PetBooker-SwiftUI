//
//  MainFlowView.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 4/11/25.
//

import Foundation
import SwiftUI

struct MainFlowView: View {
    @EnvironmentObject var mainCoordinator: MainCoordinator
    
    var body: some View {
        TabView(selection: $mainCoordinator.selectedTab) {
            /*
            // --- Pestaña Dashboard ---
            DashboardFlowView()
                .tabItem {
                    Label("Dashboard", systemImage: "square.grid.2x2")
                }
                .tag(MainTab.dashboard)
            // 3. Inyectar el coordinator ANIDADO en el entorno
            //    para esta pestaña específica.
                .environmentObject(mainCoordinator.dashboardCoordinator)
            
            // --- Pestaña Perfil ---
            ProfileFlowView() // Crearemos esta vista
                .tabItem {
                    Label("Perfil", systemImage: "person.crop.circle")
                }
                .tag(MainTab.profile)
            // 3. Inyectar el coordinator de perfil
                .environmentObject(mainCoordinator.profileCoordinator)
             */
        }
    }
}
