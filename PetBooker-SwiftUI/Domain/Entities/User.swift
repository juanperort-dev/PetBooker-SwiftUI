//
//  User.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 7/11/25.
//

import Foundation

public struct User {
    public let id: UUID
    public let email: String
    public let name: String
    public let surnames: String
    public let phoneNumber: String?
    public let dateOfBirth: Date?
}
