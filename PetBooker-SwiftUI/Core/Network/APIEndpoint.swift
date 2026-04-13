//
//  APIEndpoint.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 13/4/26.
//

import Foundation

enum APIEndpoint {
    case companies
    
    var url: URL {
        let baseURL = "https://petbooker-backend.onrender.com/api"
        
        switch self {
        case .companies:
            return URL(string: "\(baseURL)/companies")!
        }
    }
}
