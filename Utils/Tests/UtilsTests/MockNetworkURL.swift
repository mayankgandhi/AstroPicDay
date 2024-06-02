//
//  MockNetworkURL.swift
//  
//
//  Created by Mayank Gandhi on 02/06/24.
//

import Foundation
import Utils

struct MockNetworkURL: NetworkURL {
    
    var baseURL: URL
    var apiKey: String
    var pathComponents: [String]
    var queryParams: [String : String]
    
    init(baseURL: URL, apiKey: String, pathComponents: [String], queryParams: [String : String]) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.pathComponents = pathComponents
        self.queryParams = queryParams
    }
}

