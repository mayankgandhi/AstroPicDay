//
//  NetworkURL.swift
//
//
//  Created by Mayank Gandhi on 01/06/24.
//

import Foundation

public protocol NetworkURL {
    var baseURL: URL { get }
    var apiKey: String { get }
    var pathComponents: [String] { get }
    var queryParams: [String: String] { get }
    
    func constructURL() throws -> URL
}

public extension NetworkURL {
    
    func constructURL() throws -> URL {
        let path = pathComponents.joined(separator: "/")
        var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)
        var queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
        ]
        for (key, value) in queryParams {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        components?.queryItems = queryItems
        if let url = components?.url {
            return url
        } else {
            throw AstroPicDayError.unableToCreateURL
        }
    }
}
