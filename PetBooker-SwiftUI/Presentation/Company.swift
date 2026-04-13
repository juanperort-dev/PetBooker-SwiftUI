//
//  Company.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 13/4/26.
//

import Foundation

public struct Company {
    public let id: Int
    public let name: String
    public let address: String
    public let imageURL: String
    public let rating: Double
    
    public init(id: Int, name: String, address: String, imageURL: String, rating: Double = 4.9) {
        self.id = id
        self.name = name
        self.address = address
        self.imageURL = imageURL
        self.rating = rating
    }
}
