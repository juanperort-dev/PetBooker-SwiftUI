//
//  RegisterView.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 11/10/25.
//

import SwiftUI

extension Color {
    static let brandPrimary = Color(red: 0.95, green: 0.36, blue: 0.46) // coral del login
    static let brandPrimaryDark = Color(red: 0.90, green: 0.28, blue: 0.38)
}

struct RegisterView: View {
    // MARK: - Form state
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showPassword = false
    @State private var showConfirm = false
    @FocusState private var focusedField: Field?
    
    enum Field { case first, last, email, pass, confirm }
    
    // MARK: - Validation
    private var isEmailValid: Bool {
        let pattern =
        #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return email.range(of: pattern, options: .regularExpression) != nil
    }
    
    private var passwordIssues: [String] {
        var issues: [String] = []
        if password.count < 8 { issues.append("Mín. 8 caracteres") }
        if password.range(of: #".*[A-Z].*"#, options: .regularExpression) == nil { issues.append("1 mayúscula") }
        if password.range(of: #".*[a-z].*"#, options: .regularExpression) == nil { issues.append("1 minúscula") }
        if password.range(of: #".*\d.*"#, options: .regularExpression) == nil { issues.append("1 número") }
        return issues
    }
    
    private var passwordsMatch: Bool { !password.isEmpty && password == confirmPassword }
    
    private var formValid: Bool {
        !firstName.trimmingCharacters(in: .whitespaces).isEmpty &&
        !lastName.trimmingCharacters(in: .whitespaces).isEmpty &&
        isEmailValid &&
        passwordIssues.isEmpty &&
        passwordsMatch
    }
    
    var body: some View {
        ZStack {
            // 1) FONDO CORAL EN TODA LA PANTALLA
            Color.accentColor
                .ignoresSafeArea()
            
            // 2) CARD CENTRADA
            VStack {
                // --- Card ---
                VStack(spacing: 20) {
                    
                    // Logo + título (opcional)
                    VStack(spacing: 10) {
                        Image(systemName: "pawprint.fill")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.brandPrimary)
                        Text("PetBooker")
                            .font(.title3.weight(.semibold))
                            .foregroundColor(.brandPrimary)
                    }
                    
                    // --- Campos ---
                    VStack(spacing: 14) {
                        PBTextField("Nombre", text: $firstName, icon: "person")
                            .textContentType(.givenName)
                        
                        PBTextField("Apellidos", text: $lastName, icon: "person.2")
                            .textContentType(.familyName)
                        
                        PBTextField("Correo electrónico", text: $email, icon: "envelope")
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                            .autocapitalization(.none)
                        if !email.isEmpty && !isEmailValid {
                            InlineError("Formato de correo no válido")
                        }
                        
                        PBPasswordField(placeholder: "Contraseña", text: $password, show: $showPassword)
                            .textContentType(.newPassword)
                        if !password.isEmpty && !passwordIssues.isEmpty {
                            RequirementList(issues: passwordIssues)
                        }
                        
                        PBPasswordField(placeholder: "Repite la contraseña", text: $confirmPassword, show: $showConfirm)
                            .textContentType(.newPassword)
                        if !confirmPassword.isEmpty && !passwordsMatch {
                            InlineError("Las contraseñas no coinciden")
                        }
                    }
                    
                    Button {
                        // Acción crear cuenta
                    } label: {
                        Text("Crear cuenta")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                formValid
                                ? AnyShapeStyle(Color.accentColor)
                                : AnyShapeStyle(Color.gray.opacity(0.15))
                            )
                            .foregroundColor(formValid ? .white : .gray)
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    }
                    .disabled(!formValid)
                    
                    HStack {
                        Text("¿Ya tienes cuenta?")
                            .foregroundColor(.secondary)
                        Button("Inicia sesión") {
                            // navegación a login
                        }
                        .foregroundColor(.brandPrimary)
                        .fontWeight(.semibold)
                    }
                    .padding(.bottom, 4)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 18)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
                .shadow(color: .black.opacity(0.12), radius: 18, x: 0, y: 10)
                .padding(.horizontal, 16)
                // --- Fin Card ---
            }
            // Ocupa toda la altura y la centra
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding(.vertical, 24)
        }
    }
}
// MARK: - Header con ola para mantener coherencia visual
private struct Header: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color.accentColor
            Wave()
                .fill(Color(.systemBackground))
                .frame(height: 120)
                .offset(y: 220)
        }
    }
}

private struct Wave: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: 0, y: rect.minY))
        p.addLine(to: CGPoint(x: 0, y: rect.maxY - 40))
        p.addCurve(to: CGPoint(x: rect.maxX, y: rect.maxY - 40),
                   control1: CGPoint(x: rect.width * 0.35, y: rect.maxY + 20),
                   control2: CGPoint(x: rect.width * 0.65, y: rect.maxY - 100))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        p.closeSubpath()
        return p
    }
}

// MARK: - Reusable UI
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

private struct InlineError: View {
    let text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "exclamationmark.circle.fill")
            Text(text)
        }
        .font(.footnote)
        .foregroundColor(.red)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct RequirementList: View {
    let issues: [String]
    var body: some View {
        VStack(spacing: 6) {
            ForEach(issues, id: \.self) { i in
                HStack(spacing: 8) {
                    Image(systemName: "xmark.circle")
                    Text(i)
                    Spacer()
                }
                .font(.footnote)
                .foregroundColor(.red)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .combine)
    }
}

// MARK: - Preview
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .preferredColorScheme(.light)
    }
}

