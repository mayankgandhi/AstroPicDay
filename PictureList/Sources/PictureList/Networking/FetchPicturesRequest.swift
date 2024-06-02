//
//  FetchPicturesRequest.swift
//  AstroPicDay
//
//  Created by Mayank Gandhi on 01/06/24.
//

import Foundation
import Utils

struct FetchPicturesRequest: NetworkURL {
    
    var baseURL: URL
    var apiKey: String
    var pathComponents: [String]
    var queryParams: [String : String]
    
    init(baseURL: URL = URL(string: "https://api.nasa.gov")!,
         apiKey: String = "DEMO_KEY",
         pathComponents: [String] = ["planetary", "apod"],
         startDate: String,
         endDate: String) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.pathComponents = pathComponents
        self.queryParams = ["start_date": startDate,
                            "end_date": endDate]
    }
    
}

