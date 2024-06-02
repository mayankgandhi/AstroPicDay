//
//  NetworkingError.swift
//  
//
//  Created by Mayank Gandhi on 01/06/24.
//

import Foundation

enum AstroPicDayError: Error {
    case unableToCreateURL
    case requestFailed
    case unableToParseDate
}
