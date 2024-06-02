//
//  Response.swift
//  AstroPicDay
//
//  Created by Mayank Gandhi on 01/06/24.
//

import Foundation

struct Response: Codable, Sendable {
    let date, explanation: String
    let hdurl: String
    let mediaType, serviceVersion, title: String
    let url: String
    let copyright: String?

    enum CodingKeys: String, CodingKey {
        case date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url, copyright
    }
}
