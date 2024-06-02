//
//  NetworkFetcherTests.swift
//
//
//  Created by Mayank Gandhi on 02/06/24.
//

import Foundation
@testable import Utils
import XCTest

class NetworkFetcherTests: XCTestCase {
    
    var networkFetcher: NetworkFetcher!

     override func setUp() {
         super.setUp()
         networkFetcher = NetworkFetcher()
     }

     override func tearDown() {
         networkFetcher = nil
         super.tearDown()
     }

     func testFetchDataFromValidURL() async {
         let url = URL(string: "https://www.example.com")!
         do {
             let data = try await networkFetcher.fetchData(from: url)
             XCTAssertNotNil(data)
         } catch {
             XCTFail("Failed to fetch data with error: \(error)")
         }
     }

     func testCancelFetch() async throws {
         let url = URL(string: "https://www.example.com")!
         XCTAssertEqual(networkFetcher.runningTasks.count, 0)
         let _ = try await networkFetcher.fetchData(from: url)
         XCTAssertEqual(networkFetcher.runningTasks.count, 1)
         networkFetcher.cancelFetch(for: url)
         XCTAssertEqual(networkFetcher.runningTasks.count, 0)
         // Add assertion to check if fetch was cancelled
     }
}
