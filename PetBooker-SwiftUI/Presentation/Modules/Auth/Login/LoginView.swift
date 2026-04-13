//
//  LoginView.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 22/5/25.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView()
            WaveView()
            
            VStack(spacing: 16) {
                CredentialsView(
                    email: $viewModel.email,
                    password: $viewModel.password
                )
                
                Button(action: viewModel.loginButtonTapped) {
                    Text("Login")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color("AccentColor"))
                        .cornerRadius(25)
                }
                
                SeparatorButtonsView()
                
                Button(action: viewModel.loginButtonTapped) {
                    HStack {
                        Image("icon_google")
                            .resizable()
                            .frame(width: 18, height: 18)
                        Text("Sign in with Google")
                    }
                    .foregroundColor(.black)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.gray.opacity(0.6), lineWidth: 1)
                    )
                }
                
                Spacer()
                FooterView(onRegisterTap: viewModel.registerButtonTapped)
            }
            .padding(.horizontal)
            .padding(.top, 24)
        }
    }
}

// MARK: – Sub‑views

struct HeaderView: View {
    private let headerHeight: CGFloat = 200
    private let logoTopPadding: CGFloat = 60
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color("AccentColor")
                .ignoresSafeArea(edges: .top)
        }
        .frame(height: headerHeight)
        .overlay(
            VStack(spacing: 16) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                
                Text("PetBooker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
                .padding(.top, logoTopPadding)
        )
    }
    
}

struct WaveView: View {
    var body: some View {
        Image("wave_login")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 115)
            .frame(maxWidth: .infinity)
            .clipped()
    }
}

private struct CredentialsView: View {
    @Binding var email: String
    @Binding var password: String
    @State var isPasswordVisible: Bool = false
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Email", text: $email)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray)
                )
            
            ZStack(alignment: .trailing) {
                Group {
                    if isPasswordVisible {
                        TextField("Password", text: $password)
                    } else {
                        SecureField("Password", text: $password)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray)
                )
                
                Button {
                    isPasswordVisible.toggle()
                } label: {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                        .padding()
                }
            }
        }
        .padding(.horizontal)
    }
}

private struct SeparatorButtonsView: View {
    var body: some View {
        HStack(alignment: .center) {
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 140, height: 1)
            
            Text("OR")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.horizontal, 8)
            
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 140, height: 1)
        }
        .padding(.vertical, 8)
    }
}

private struct FooterView: View {
    var onRegisterTap: () -> Void = { }
    
    var body: some View {
        HStack(spacing: 4) {
            Text("¿No tienes cuenta?")
                .foregroundColor(.gray)
            Button {
                onRegisterTap()
            } label: {
                Text("Regístrate")
                    .fontWeight(.bold)
            }
        }
        .padding(.bottom)
    }
}

// MARK: – Previews

import SwiftUI

struct LoginView_Previews: PreviewProvider {
    final class QuickMockLoginUseCase: LoginUseCaseProtocol {
        func execute(email: String, password: String) async throws -> User {
            return User(id: UUID(), email: email, name: "Test", surnames: "User", phoneNumber: nil, dateOfBirth: nil)
        }
    }
    
    static var previews: some View {
        let mockUseCase = QuickMockLoginUseCase()
        let vm = LoginViewModel(
            loginUseCase: mockUseCase,
            onLoginSuccess: { user in
                print("Preview: Simulación de login exitoso.")
            },
            
            onGoToRegister: {
                print("Preview: Simulación de ir a registro.")
            }
        )
        return NavigationStack {
            LoginView(viewModel: vm)
        }
    }
}
