//
//  CustomDateFormatter.swift
//
//
//  Created by Mayank Gandhi on 01/06/24.
//

import Foundation
import Dependencies

public struct CustomDateFormatter {
    
    private let inputFormatter: DateFormatter
    private let outputFormatter: DateFormatter
    
    init() {
        let inputFormatter = DateFormatter()
        inputFormatter.timeZone = TimeZone.current
        self.inputFormatter = inputFormatter
        let outputFormatter = DateFormatter()
        outputFormatter.timeZone = TimeZone.current
        self.outputFormatter = outputFormatter
    }
    
    public func format(inputDate: Date, to outputFormat: String) throws -> String {
        outputFormatter.dateFormat = outputFormat
        return outputFormatter.string(from: inputDate)
    }
    
    public func format(date: String, from inputFormat: String, to outputFormat: String) throws -> String {
        inputFormatter.dateFormat = inputFormat
        guard let inputDate = inputFormatter.date(from: date) else { throw AstroPicDayError.unableToParseDate}
        
        outputFormatter.dateFormat = outputFormat
        return outputFormatter.string(from: inputDate)
    }
    
}

extension CustomDateFormatter: DependencyKey {
    public static var liveValue: CustomDateFormatter {
        CustomDateFormatter()
    }
}

public extension DependencyValues {
    var customDateFormatter: CustomDateFormatter {
        get { self[CustomDateFormatter.self] }
        set { self[CustomDateFormatter.self] = newValue }
    }
}
