//
//  MainFlowView.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 4/11/25.
//

import Foundation
import SwiftUI

struct MainFlowView: View {
    
    @EnvironmentObject var coordinator: MainCoordinator
    
    var body: some View {
        
        TabView(selection: $coordinator.selectedTab) {
            coordinator.makeTabView(for: .dashboard)
                .tabItem {
                    Label("Dashboard", systemImage: "house")
                }
                .tag(MainTab.dashboard)
            
            coordinator.makeTabView(for: .profile)
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
                .tag(MainTab.profile)
        }
    }
}
