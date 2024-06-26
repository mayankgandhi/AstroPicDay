//
//  RequestController.swift
//  AstroPicDay
//
//  Created by Mayank Gandhi on 01/06/24.
//

import Foundation
import Dependencies

enum RequestControllerError: Error {
    case APIRequestFailed
}

public protocol RequestControlling {
    func fetch<RequestURL: NetworkURL, Response: Codable>(request: RequestURL) async throws -> [Response]
}

public class RequestController: RequestControlling {
    
    public func fetch<RequestURL: NetworkURL, Response: Codable>(request: RequestURL) async throws -> [Response] {
        let urlSessionShared = URLSession.shared
        let urlRequest = URLRequest(url: try request.constructURL(), cachePolicy: .reloadRevalidatingCacheData)
        let (data, _) = try await urlSessionShared.data(for: urlRequest)
        do {
            let decode = try JSONDecoder().decode([Response].self, from: data)
            return decode
        } catch {
            if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                throw errorResponse
            } else {
                throw error
            }
        }
    }
    
}

extension RequestController: DependencyKey {
    public static var liveValue: RequestController {
        RequestController()
    }
}

public extension DependencyValues {
    var requestController: RequestController {
        get { self[RequestController.self] }
        set { self[RequestController.self] = newValue }
    }
}
