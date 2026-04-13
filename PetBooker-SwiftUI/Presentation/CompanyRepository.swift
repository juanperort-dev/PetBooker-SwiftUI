//
//  CompanyRepository.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 13/4/26.
//

import Foundation

class CompanyRepository: CompanyRepositoryProtocol {
    private let remoteDataSource: CompanyDataSourceProtocol
    
    init(remoteDataSource: CompanyDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getCompanies() async throws -> [Company] {
        let companyDTOs = try await remoteDataSource.fetchCompanies()
        return companyDTOs.map { CompanyMapper.toDomain($0) }
    }
}
