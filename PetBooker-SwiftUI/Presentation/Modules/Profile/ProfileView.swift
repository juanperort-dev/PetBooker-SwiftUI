//
//  ProfileView.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 9/11/25.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Button(action: viewModel.logoutButtonTapped) {
                Text("Cerrar Sesión")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .navigationTitle("Ajustes")
    }
}

class MockLogoutUseCase: LogoutUseCaseProtocol {
    func execute() async throws {
    }
}

#Preview {
    let mockLogoutUseCase = MockLogoutUseCase()
    let mockViewModel = ProfileViewModel(
        logoutUseCase: mockLogoutUseCase,
        onLogoutSuccess: {
            print("DEBUG: Acción de Logout simulada en Preview")
        }
    )
    ProfileView(viewModel: mockViewModel)
}
