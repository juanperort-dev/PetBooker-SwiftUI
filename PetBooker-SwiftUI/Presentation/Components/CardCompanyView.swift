//
//  CardCompanyView.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 13/4/26.
//

import SwiftUI

struct CardCompanyView: View {
    let companyName: String
    let address: String
    let imageURL: String
    let rating: Double
    let onViewTapped: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Company Image
            AsyncImage(url: URL(string: imageURL)) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .overlay {
                            ProgressView()
                        }
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .overlay {
                            Image(systemName: "photo")
                                .font(.largeTitle)
                                .foregroundStyle(.gray)
                        }
                @unknown default:
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                }
            }
            .frame(height: 200)
            .clipped()
            
            // Company Info
            VStack(alignment: .leading, spacing: 4) {
                Text(companyName)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                
                Text(address)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                HStack {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                            .font(.footnote)
                        Text(String(format: "%.1f", rating))
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(.primary)
                    }
                    
                    Spacer()
                    
                    Button {
                        onViewTapped()
                    } label: {
                        Text("View")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color("AccentColor"))
                            .clipShape(Capsule())
                    }
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

#Preview {
    CardCompanyView(
        companyName: "Pawsitive Vibes Grooming",
        address: "1.2 miles away",
        imageURL: "https://images.unsplash.com/photo-1548199973-03cce0bbc87b?w=800&h=400&fit=crop",
        rating: 4.9,
        onViewTapped: {
            print("View tapped")
        }
    )
    .padding()
}
