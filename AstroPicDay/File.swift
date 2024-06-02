//
//  NasaURLAPI.swift
//  AstroPicDay
//
//  Created by Mayank Gandhi on 01/06/24.
//

import Foundation

struct NasaURLAPI: NetworkURL {
    
    var baseURL: URL
    var apiKey: String
    var pathComponents: [String]
    var queryParams: [String : String]
    
    init(baseURL: URL = URL(string: "https://api.nasa.gov")!,
         apiKey: String = "DEMO_KEY",
         pathComponents: [String] = ["planetary", "apod"],
         queryParams: [String : String] = ["start_date":"2024-04-01",
                                           "end_date":"2024-04-02"]) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.pathComponents = pathComponents
        self.queryParams = queryParams
    }
    
}

