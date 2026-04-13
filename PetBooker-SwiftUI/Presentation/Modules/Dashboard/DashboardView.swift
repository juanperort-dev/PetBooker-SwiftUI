//
//  DashboardView.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 28/7/25.
//

import SwiftUI

struct DashboardView: View {
    @StateObject var viewModel: DashboardViewModel
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.05)
                .ignoresSafeArea()
            
            if viewModel.isLoading {
                ProgressView("Loading companies...")
                    .font(.headline)
            } else if let errorMessage = viewModel.errorMessage {
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 48))
                        .foregroundStyle(.red)
                    
                    Text(errorMessage)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Button("Retry") {
                        Task {
                            await viewModel.loadCompanies()
                        }
                    }
                    .buttonStyle(.bordered)
                }
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.companies, id: \.id) { company in
                            CardCompanyView(
                                companyName: company.name,
                                address: company.address,
                                imageURL: company.imageURL,
                                rating: company.rating,
                                onViewTapped: {
                                    // TODO: Navegar al detalle de la compañía
                                    print("View tapped for company: \(company.name)")
                                }
                            )
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
        .task {
            await viewModel.loadCompanies()
        }
    }
}

#Preview {
    // Preview con ViewModel mock (sin dependencias reales)
    let mockUseCase = MockGetCompaniesUseCase()
    let viewModel = DashboardViewModel(getCompaniesUseCase: mockUseCase)
    
    return DashboardView(viewModel: viewModel)
}
// MARK: - Mock para Preview
private class MockGetCompaniesUseCase: GetCompaniesUseCaseProtocol {
    func execute() async throws -> [Company] {
        return [
            Company(
                id: 1,
                name: "Pawsitive Vibes Grooming",
                address: "1.2 miles away",
                imageURL: "https://images.unsplash.com/photo-1548199973-03cce0bbc87b?w=800&h=400&fit=crop",
                rating: 4.9
            ),
            Company(
                id: 2,
                name: "Happy Tails Spa",
                address: "2.5 miles away",
                imageURL: "https://images.unsplash.com/photo-1548767797-d8c844163c4c?w=800&h=400&fit=crop",
                rating: 4.7
            ),
            Company(
                id: 3,
                name: "Pet Paradise Grooming",
                address: "3.1 miles away",
                imageURL: "https://images.unsplash.com/photo-1615751072497-5f5169febe17?w=800&h=400&fit=crop",
                rating: 4.8
            )
        ]
    }
}


