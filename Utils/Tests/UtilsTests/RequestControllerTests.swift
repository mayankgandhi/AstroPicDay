//
//  RequestControllerTests.swift
//
//
//  Created by Mayank Gandhi on 02/06/24.
//

import Foundation
import XCTest
@testable import Utils

// Define a sample Codable struct for response
struct MockResponse: Codable, Equatable {
    let id: Int
    let name: String
}

class RequestControllerTests: XCTestCase {

    var mockRequestController: MockRequestController!

    override func setUp() {
        super.setUp()
        mockRequestController = MockRequestController(mockResponses: [:])
    }

    override func tearDown() {
        mockRequestController = nil
        super.tearDown()
    }

    func testFetchSuccess() async throws {
        let mockURL = MockNetworkURL(baseURL: URL(string: "www.example.com")!, apiKey: "", pathComponents: [], queryParams: [:])
        let mockData = """
        [
            {"id": 1, "name": "Test1"},
            {"id": 2, "name": "Test2"}
        ]
        """.data(using: .utf8)!

        mockRequestController.mockResponses[try mockURL.constructURL().absoluteString] = mockData
        
        do {
            let responses: [MockResponse] = try await mockRequestController.fetch(request: mockURL)
            XCTAssertEqual(responses, [MockResponse(id: 1, name: "Test1"), MockResponse(id: 2, name: "Test2")])
        } catch {
            XCTFail("Fetching should succeed, but it failed with error: \(error)")
        }
    }

    func testFetchFailure() async throws {
        let mockURL = MockNetworkURL(baseURL: URL(string: "https://example.com/failure")!, apiKey: "", pathComponents: [], queryParams: [:])
        mockRequestController.shouldThrowError = true
        
        do {
            let _: [MockResponse] = try await mockRequestController.fetch(request: mockURL)
            XCTFail("Fetching should fail, but it succeeded")
        } catch {
            XCTAssertEqual(error as? URLError, URLError(.badServerResponse))
        }
    }

    func testFetchNoData() async throws {
        let mockURL = MockNetworkURL(baseURL: URL(string: "https://example.com/nodata")!, apiKey: "", pathComponents: [], queryParams: [:])
        
        do {
            let _: [MockResponse] = try await mockRequestController.fetch(request: mockURL)
            XCTFail("Fetching should fail due to no data, but it succeeded")
        } catch {
            XCTAssertEqual(error as? URLError, URLError(.fileDoesNotExist))
        }
    }
}
