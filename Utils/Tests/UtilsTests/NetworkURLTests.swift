//
//  NetworkURLTests.swift
//
//
//  Created by Mayank Gandhi on 02/06/24.
//

import Foundation
import XCTest
@testable import Utils

class NetworkURLTests: XCTestCase {

    func testConstructURL_success() {
        // Given
        let baseURL = URL(string: "https://example.com")!
        let pathComponents = ["api", "v1", "photo"]
        let queryParams = ["date": "2024-01-01", "hd": "true"]
        let apiKey = "testApiKey"
        let networkURL = MockNetworkURL(baseURL: baseURL, apiKey: apiKey, pathComponents: pathComponents, queryParams: queryParams)

        // When
        var constructedURL: URL?
        XCTAssertNoThrow(constructedURL = try networkURL.constructURL())

        // Then
        let expectedURL = URL(string: "https://example.com/api/v1/photo?api_key=testApiKey&date=2024-01-01&hd=true")
        XCTAssertEqual(constructedURL, expectedURL)
    }

    func testConstructURL_emptyPathComponents() {
        // Given
        let baseURL = URL(string: "https://example.com")!
        let pathComponents: [String] = []
        let queryParams: [String: String] = [:]
        let apiKey = "testApiKey"
        let networkURL = MockNetworkURL(baseURL: baseURL, apiKey: apiKey, pathComponents: pathComponents, queryParams: queryParams)

        // When
        var constructedURL: URL?
        XCTAssertNoThrow(constructedURL = try networkURL.constructURL())

        // Then
        let expectedURL = URL(string: "https://example.com/?api_key=testApiKey")

        XCTAssertEqual(constructedURL, expectedURL)
    }

    func testConstructURL_noQueryParams() {
        // Given
        let baseURL = URL(string: "https://example.com")!
        let pathComponents = ["api", "v1", "photo"]
        let queryParams: [String: String] = [:]
        let apiKey = "testApiKey"
        let networkURL = MockNetworkURL(baseURL: baseURL, apiKey: apiKey, pathComponents: pathComponents, queryParams: queryParams)

        // When
        var constructedURL: URL?
        XCTAssertNoThrow(constructedURL = try networkURL.constructURL())

        // Then
        let expectedURL = URL(string: "https://example.com/api/v1/photo?api_key=testApiKey")
        XCTAssertEqual(constructedURL, expectedURL)
    }
}
