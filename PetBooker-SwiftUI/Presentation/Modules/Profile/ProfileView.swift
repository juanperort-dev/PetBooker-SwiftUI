//
//  ProfileView.swift
//  PetBooker-SwiftUI
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel

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

#Preview {
    NavigationStack {
        ProfileView(viewModel: ProfileViewModel(
            logoutUseCase: PreviewLogoutUseCase(),
            onLogoutSuccess: {}
        ))
    }
}

private final class PreviewLogoutUseCase: LogoutUseCaseProtocol {
    func execute() async throws {}
}
