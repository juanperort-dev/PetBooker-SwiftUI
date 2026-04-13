//
//  CompanyDataSourceProtocol.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 13/4/26.
//

import Foundation

protocol CompanyDataSourceProtocol {
    func fetchCompanies() async throws -> [CompanyDTO]
}
