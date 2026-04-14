//
//  ShimmerEffect.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 14/4/26.
//

import SwiftUI

/// ViewModifier que aplica un efecto shimmer (brillo deslizante) a cualquier View
struct ShimmerEffect: ViewModifier {
    @State private var phase: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { geometry in
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color(.systemGray5), location: 0.0),
                            .init(color: Color.white.opacity(0.6), location: 0.5),
                            .init(color: Color(.systemGray5), location: 1.0)
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: geometry.size.width * 2)
                    .offset(x: -geometry.size.width + (geometry.size.width * 2 * phase))
                    .blendMode(.screen)
                }
            }
            .onAppear {
                withAnimation(
                    .linear(duration: 1.2)
                    .repeatForever(autoreverses: false)
                ) {
                    phase = 1
                }
            }
    }
}

/// Extensión para aplicar el shimmer de forma sencilla
extension View {
    func shimmering() -> some View {
        self.modifier(ShimmerEffect())
    }
}

#Preview("Shimmer Effect") {
    VStack(spacing: 20) {
        // Ejemplo 1: Rectángulo con shimmer
        Rectangle()
            .fill(Color(.systemGray5))
            .frame(height: 60)
            .cornerRadius(8)
            .shimmering()
        
        // Ejemplo 2: Texto placeholder
        Text("Loading...")
            .frame(width: 150, height: 20)
            .background(Color(.systemGray5))
            .cornerRadius(4)
            .shimmering()
        
        // Ejemplo 3: Círculo
        Circle()
            .fill(Color(.systemGray5))
            .frame(width: 80, height: 80)
            .shimmering()
    }
    .padding()
    .background(Color(.systemBackground))
}
