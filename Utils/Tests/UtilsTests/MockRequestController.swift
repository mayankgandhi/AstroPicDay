//
//  MockRequestController.swift
//
//
//  Created by Mayank Gandhi on 02/06/24.
//

import Foundation
@testable import Utils

final class MockRequestController: RequestControlling {
    
    var mockResponses: [String: Data] = [:]
    var shouldThrowError: Bool = false

    func fetch<RequestURL: NetworkURL, Response: Codable>(request: RequestURL) async throws -> [Response] {
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }
        let url = try request.constructURL().absoluteString
       
        guard let mockData = mockResponses[url] else {
            throw URLError(.fileDoesNotExist)
        }
        
        let decode = try JSONDecoder().decode([Response].self, from: mockData)
        return decode
    }
}
