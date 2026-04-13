//
//  CompanyRemoteDataSource.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 13/4/26.
//

import Foundation

class CompanyRemoteDataSource: CompanyDataSourceProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchCompanies() async throws -> [CompanyDTO] {
        return try await apiClient.request(endpoint: .companies)
    }
}
