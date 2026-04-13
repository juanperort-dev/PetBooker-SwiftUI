//
//  APIClient.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 13/4/26.
//

import Foundation

protocol APIClientProtocol {
    func request<T: Decodable>(endpoint: APIEndpoint) async throws -> T
}

class APIClient: APIClientProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(endpoint: APIEndpoint) async throws -> T {
        let url = endpoint.url
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            print("Decoding error: \(error)")
            throw NetworkError.decodingError
        }
    }
}
