//
//  ErrorResponse.swift
//  
//
//  Created by Mayank Gandhi on 02/06/24.
//

import Foundation

public struct ErrorResponse: Codable, Sendable, Error {
    public let code: Int
    public let msg, serviceVersion: String

    enum CodingKeys: String, CodingKey {
        case code, msg
        case serviceVersion = "service_version"
    }
}
