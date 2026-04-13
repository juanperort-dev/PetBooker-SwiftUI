//
//  CompanyDTO.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 13/4/26.
//

import Foundation

struct CompanyDTO: Codable {
    let companyId: Int
    let companyName: String
    let address: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case companyId = "company_id"
        case companyName = "company_name"
        case address
        case imageUrl = "image_url"
    }
}
