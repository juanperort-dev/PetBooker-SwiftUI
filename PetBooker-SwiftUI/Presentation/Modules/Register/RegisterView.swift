//
//  RegisterView.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 11/10/25.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject private var vm: RegisterViewModel
    var onLoginTap: () -> Void = {}
    
    init(viewModel: RegisterViewModel,
         onLoginTap: @escaping () -> Void = {}) {
        _vm = StateObject(wrappedValue: viewModel)
        self.onLoginTap = onLoginTap
    }
    
    @MainActor
    init(onLoginTap: @escaping () -> Void = {}) {
        self.init(viewModel: RegisterViewModel(), onLoginTap: onLoginTap)
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            // MARK: Card
            VStack {
                VStack(spacing: 20) {
                    AppIconView()
                    
                    FormFieldsView(
                        firstName: $vm.firstName,
                        lastName: $vm.lastName,
                        email: $vm.email,
                        password: $vm.password,
                        confirmPassword: $vm.confirmPassword,
                        showPassword: $vm.showPassword,
                        showConfirm: $vm.showConfirm
                    )
                    
                    ShowErrorMessageView(errorMessage: $vm.errorMessage)
                    
                    CreateAccountButtonView(
                        isLoading: vm.isLoading,
                        isFormValid: vm.isFormValid,
                        action: vm.register)
                    
                    FooterCardView(action: onLoginTap)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 18)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
                .shadow(color: .black.opacity(0.12), radius: 18, x: 0, y: 10)
                .padding(.horizontal, 16)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding(.vertical, 24)
        }
    }
}

// MARK: - Reusables (tu UI)
private struct BackgroundView: View {
    var body: some View {
        Color.accentColor
            .ignoresSafeArea()
    }
}

private struct AppIconView: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "pawprint.fill")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.accentColor)
            Text("PetBooker")
                .font(.title3.weight(.semibold))
                .foregroundColor(.accentColor)
        }
    }
}

private struct FormFieldsView: View {
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var email: String
    @Binding var password: String
    @Binding var confirmPassword: String
    @Binding var showPassword: Bool
    @Binding var showConfirm: Bool
    
    var body: some View {
        VStack(spacing: 14) {
            PBTextField("Nombre", text: $firstName, icon: "person")
                .textContentType(.givenName)
            
            PBTextField("Apellidos", text: $lastName, icon: "person.2")
                .textContentType(.familyName)
            
            PBTextField("Correo electrónico", text: $email, icon: "envelope")
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .autocapitalization(.none)
            
            PBPasswordField(placeholder: "Contraseña",
                            text: $password,
                            show: $showPassword)
            .textContentType(.newPassword)
            
            PBPasswordField(placeholder: "Repite la contraseña",
                            text: $confirmPassword,
                            show: $showConfirm)
            .textContentType(.newPassword)
        }
    }
}

private struct ShowErrorMessageView: View {
    @Binding var errorMessage: String
    
    var body: some View {
        if !errorMessage.isEmpty {
            Text(errorMessage)
                .foregroundColor(.red)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

private struct CreateAccountButtonView: View {
    let isLoading: Bool
    let isFormValid: Bool
    let action: () async -> Void
    
    var body: some View {
        Button {
            Task { await action() }
        } label: {
            HStack {
                if isLoading { ProgressView() }
                Text("Crear cuenta").fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(isFormValid && !isLoading ? Color.accentColor
                          : Color.gray.opacity(0.15))
            )
            .foregroundColor(isFormValid && !isLoading ? .white : .gray)
        }
        .disabled(!isFormValid || isLoading)
    }
}

private struct FooterCardView: View {
    let action: () -> Void
    
    var body: some View {
        HStack {
            Text("¿Ya tienes cuenta?")
                .foregroundColor(.secondary)
            Button(action: action) {
                Text("Inicia sesión")
                    .fontWeight(.semibold)
            }
            .foregroundColor(.accentColor)
        }
        .padding(.bottom, 4)
    }
}

private struct PBTextField: View {
    let placeholder: String
    @Binding var text: String
    let icon: String
    
    init(_ placeholder: String, text: Binding<String>, icon: String) {
        self.placeholder = placeholder
        self._text = text
        self.icon = icon
    }
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .foregroundColor(.secondary)
            TextField(placeholder, text: $text)
                .padding(.vertical, 12)
        }
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(Color.gray.opacity(0.25), lineWidth: 1)
        )
    }
}

private struct PBPasswordField: View {
    let placeholder: String
    @Binding var text: String
    @Binding var show: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "lock.fill")
                .foregroundColor(.secondary)
            Group {
                if show {
                    TextField(placeholder, text: $text)
                } else {
                    SecureField(placeholder, text: $text)
                }
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            Button { show.toggle() } label: {
                Image(systemName: show ? "eye.slash" : "eye")
                    .foregroundColor(.secondary)
            }
            .accessibilityLabel(show ? "Ocultar contraseña" : "Mostrar contraseña")
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(Color.gray.opacity(0.25), lineWidth: 1)
        )
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        RegisterView()
            .preferredColorScheme(.light)
    }
}
