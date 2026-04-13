//
//  CompanyRepositoryProtocol.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 13/4/26.
//

import Foundation

protocol CompanyRepositoryProtocol {
    func getCompanies() async throws -> [Company]
}
