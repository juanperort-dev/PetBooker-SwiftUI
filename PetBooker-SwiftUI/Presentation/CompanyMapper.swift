//
//  CompanyMapper.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 13/4/26.
//

import Foundation

struct CompanyMapper {
    static func toDomain(_ dto: CompanyDTO) -> Company {
        return Company(
            id: dto.companyId,
            name: dto.companyName,
            address: dto.address,
            imageURL: dto.imageUrl,
            rating: 4.9 // Valor por defecto hasta que la API lo devuelva
        )
    }
}
