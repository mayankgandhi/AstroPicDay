//
//  MockRequestController.swift
//
//
//  Created by Mayank Gandhi on 02/06/24.
//

import Foundation

public class MockRequestController: RequestController {
    
    public var mockResponses: [String: Data] = [:]
    public var shouldThrowError: Bool
    
    public init(mockResponses: [String : Data], shouldThrowError: Bool = false) {
        self.mockResponses = mockResponses
        self.shouldThrowError = shouldThrowError
    }

    public override func fetch<RequestURL: NetworkURL, Response: Codable>(request: RequestURL) async throws -> [Response] {
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

public class MockRequestControllerWithSingularData: RequestController {
    
    public var mockResponse: Data?
    public var shouldThrowError: Bool
    
    public init(mockResponse: Data? = nil, shouldThrowError: Bool = false) {
        self.mockResponse = mockResponse
        self.shouldThrowError = shouldThrowError
    }

    public override func fetch<RequestURL: NetworkURL, Response: Codable>(request: RequestURL) async throws -> [Response] {
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }
        
        guard let mockData = mockResponse else {
            throw URLError(.fileDoesNotExist)
        }
        
        let decode = try JSONDecoder().decode([Response].self, from: mockData)
        return decode
    }
}
