//
//  UserSessionService.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 10/11/25.
//

import Foundation
import SwiftUI

@MainActor
class UserSessionService: ObservableObject, UserSessionServiceProtocol {
    
    @Published public private(set) var currentUser: User? = nil
    
    public func login(user: User) {
        self.currentUser = user
        print("DEBUG: Sesión iniciada para \(user.email)")
    }
    
    public func logout() {
        self.currentUser = nil
        print("DEBUG: Sesión cerrada")
    }
    
    public func loadSession() {
        
    }
}
