//
//  CardCompanySkeletonView.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 14/4/26.
//

import SwiftUI

/// Vista skeleton que replica el layout de CardCompanyView con placeholders animados
struct CardCompanySkeletonView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Placeholder para imagen de compañía
            Rectangle()
                .fill(Color(.systemGray5))
                .frame(height: 200)
                .shimmering()
            
            // Placeholder para información de la compañía
            VStack(alignment: .leading, spacing: 4) {
                // Placeholder nombre de compañía (~60% ancho)
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(.systemGray5))
                    .frame(height: 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.trailing, 80) // Simula ~60% del ancho
                    .shimmering()
                
                // Placeholder dirección (~40% ancho)
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(.systemGray5))
                    .frame(height: 14)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.trailing, 160) // Simula ~40% del ancho
                    .shimmering()
                
                HStack {
                    // Placeholder rating
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(.systemGray5))
                        .frame(width: 60, height: 14)
                        .shimmering()
                    
                    Spacer()
                    
                    // Placeholder botón "View"
                    Capsule()
                        .fill(Color(.systemGray5))
                        .frame(width: 80, height: 36)
                        .shimmering()
                }
                .padding(.top, 4)
            }
            .padding()
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

#Preview("Card Skeleton - Light Mode") {
    VStack(spacing: 20) {
        CardCompanySkeletonView()
            .padding()
        
        Text("Skeleton Loading")
            .font(.caption)
            .foregroundStyle(.secondary)
    }
    .background(Color(.systemGroupedBackground))
}

#Preview("Card Skeleton - Dark Mode") {
    VStack(spacing: 20) {
        CardCompanySkeletonView()
            .padding()
        
        Text("Skeleton Loading")
            .font(.caption)
            .foregroundStyle(.secondary)
    }
    .background(Color(.systemGroupedBackground))
    .preferredColorScheme(.dark)
}

#Preview("Comparison - Skeleton vs Real") {
    ScrollView {
        VStack(spacing: 30) {
            // Skeleton
            VStack(alignment: .leading, spacing: 8) {
                Text("Skeleton View")
                    .font(.headline)
                CardCompanySkeletonView()
            }
            
            Divider()
            
            // Real (simulado con placeholder data)
            VStack(alignment: .leading, spacing: 8) {
                Text("Real View (for comparison)")
                    .font(.headline)
                
                // Aquí iría CardCompanyView cuando se resuelva el error de redeclaración
                Text("CardCompanyView - Coming after duplicate fix")
                    .frame(height: 300)
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(16)
            }
        }
        .padding()
    }
    .background(Color(.systemGroupedBackground))
}
