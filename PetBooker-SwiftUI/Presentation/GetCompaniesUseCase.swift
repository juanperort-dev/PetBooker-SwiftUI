//
//  GetCompaniesUseCase.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 13/4/26.
//

import Foundation

protocol GetCompaniesUseCaseProtocol {
    func execute() async throws -> [Company]
}

class GetCompaniesUseCase: GetCompaniesUseCaseProtocol {
    private let companyRepository: CompanyRepositoryProtocol
    
    init(companyRepository: CompanyRepositoryProtocol) {
        self.companyRepository = companyRepository
    }
    
    func execute() async throws -> [Company] {
        return try await companyRepository.getCompanies()
    }
}
