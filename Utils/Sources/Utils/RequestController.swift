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

protocol RequestControlling {
    func fetch<RequestURL: NetworkURL, Response: Codable>(request: RequestURL) async throws -> [Response]
}

public final class RequestController: RequestControlling {
    
    public func fetch<RequestURL: NetworkURL, Response: Codable>(request: RequestURL) async throws -> [Response] {
        let urlSessionShared = URLSession.shared
        let (data, _) = try await urlSessionShared.data(from: request.constructURL())
        dump(String(bytes: data, encoding: .utf8))
        let decode = try JSONDecoder().decode([Response].self, from: data)
        return decode
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
