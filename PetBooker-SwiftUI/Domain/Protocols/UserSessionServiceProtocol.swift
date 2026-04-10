//
//  UserSessionServiceProtocol.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 9/11/25.
//

import Foundation

@MainActor
public protocol UserSessionServiceProtocol {
    var currentUser: User? { get }
    func login(user: User)
    func logout()
    func loadSession()
}
