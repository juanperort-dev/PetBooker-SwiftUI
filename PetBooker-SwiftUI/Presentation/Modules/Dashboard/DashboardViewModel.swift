//
//  DashboardViewModel.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 6/8/25.
//

import Foundation

@MainActor
class DashboardViewModel: ObservableObject {
    
    // MARK: - Dependencies
    private let getCompaniesUseCase: GetCompaniesUseCaseProtocol
    
    // MARK: - State
    @Published var companies: [Company] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    // MARK: - Initialization
    init(getCompaniesUseCase: GetCompaniesUseCaseProtocol) {
        self.getCompaniesUseCase = getCompaniesUseCase
    }
    
    // MARK: - Public Methods
    func loadCompanies() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedCompanies = try await getCompaniesUseCase.execute()
            self.companies = fetchedCompanies
            self.isLoading = false
        } catch {
            self.isLoading = false
            self.errorMessage = "Failed to load companies: \(error.localizedDescription)"
            print("Error loading companies: \(error)")
        }
    }
}

