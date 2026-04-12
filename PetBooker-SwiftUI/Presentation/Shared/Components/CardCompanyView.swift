//
//  CardCompanyView.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 12/4/26.
//

import SwiftUI

// MARK: - Preview Model (temporal hasta crear la Entity)
struct CompanyPreviewModel {
    let id: Int
    let name: String
    let address: String
    let imageURL: String
    let rating: Double
}

// MARK: - CardCompanyView
struct CardCompanyView: View {
    
    let companyName: String
    let address: String
    let imageURL: String
    let rating: Double
    let onViewTapped: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Imagen superior
            AsyncImage(url: URL(string: imageURL)) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 200)
                        .overlay {
                            ProgressView()
                        }
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                case .failure:
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 200)
                        .overlay {
                            Image(systemName: "photo")
                                .foregroundStyle(.gray)
                                .font(.largeTitle)
                        }
                @unknown default:
                    EmptyView()
                }
            }
            .clipShape(
                .rect(
                    topLeadingRadius: 16,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 16
                )
            )
            
            // Contenido inferior
            VStack(alignment: .leading, spacing: 8) {
                // Título
                Text(companyName)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                
                // Subtítulo (dirección)
                Text(address)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                // Rating y botón
                HStack {
                    // Rating
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(Color(red: 1.0, green: 0.84, blue: 0.0)) // Gold
                            .font(.subheadline)
                        
                        Text(String(format: "%.1f", rating))
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(.primary)
                    }
                    
                    Spacer()
                    
                    // Botón "View"
                    Button(action: onViewTapped) {
                        Text("View")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 10)
                            .background(Color(red: 0.91, green: 0.27, blue: 0.35)) // #E8445A
                            .clipShape(Capsule())
                    }
                }
                .padding(.top, 4)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.gray.opacity(0.1)
            .ignoresSafeArea()
        
        VStack {
            CardCompanyView(
                companyName: "Pawsitive Vibes Grooming",
                address: "1.2 miles away",
                imageURL: "https://images.unsplash.com/photo-1548199973-03cce0bbc87b?w=800&h=400&fit=crop",
                rating: 4.9,
                onViewTapped: {
                    print("View button tapped")
                }
            )
            .padding()
            
            Spacer()
        }
    }
}
