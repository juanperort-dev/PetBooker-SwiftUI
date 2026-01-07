//
//  AuthFlowView.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 4/11/25.
//

import SwiftUI

struct AuthFlowView: View {
    @EnvironmentObject var coordinator: AuthCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.makeView(for: .login)
                .navigationDestination(for: AuthScreen.self) { screen in
                    coordinator.makeView(for: screen)
                }
        }
    }
}

#Preview {
    AuthFlowView()
}
