//
//  RequestController.swift
//  AstroPicDay
//
//  Created by Mayank Gandhi on 01/06/24.
//

import Foundation

enum RequestControllerError: Error {
    case APIRequestFailed
}

final class RequestController {
    
    func fetch<RequestURL: NetworkURL, Response: Codable>(request: RequestURL) async throws -> [Response] {
        let urlSessionShared = URLSession.shared
        let (data, _) = try await urlSessionShared.data(from: request.constructURL())
        let decode = try JSONDecoder().decode([Response].self, from: data)
        return decode
    }
    
}
