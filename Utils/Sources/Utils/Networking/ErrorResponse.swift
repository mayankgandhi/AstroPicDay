//
//  ErrorResponse.swift
//  
//
//  Created by Mayank Gandhi on 02/06/24.
//

import Foundation

struct ErrorResponse: Codable, Sendable {
    let code: Int
    let msg, serviceVersion: String

    enum CodingKeys: String, CodingKey {
        case code, msg
        case serviceVersion = "service_version"
    }
}
