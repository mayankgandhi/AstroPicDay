//
//  CustomDateFormatterTests.swift
//
//
//  Created by Mayank Gandhi on 02/06/24.
//

import Foundation
import XCTest
@testable import Utils

class CustomDateFormatterTests: XCTestCase {

    var dateFormatter: CustomDateFormatter!

    override func setUp() {
        super.setUp()
        dateFormatter = CustomDateFormatter()
    }

    override func tearDown() {
        dateFormatter = nil
        super.tearDown()
    }

    func testFormatWithDateInput() {
        let inputDate = Date(timeIntervalSince1970: 0) // January 1, 1970
        let outputFormat = "yyyy-MM-dd"
        
        do {
            let formattedDate = try dateFormatter.format(inputDate: inputDate, to: outputFormat)
            XCTAssertEqual(formattedDate, "1970-01-01", "Date should be formatted correctly")
        } catch {
            XCTFail("Formatting failed with error: \(error)")
        }
    }

    func testFormatWithStringInput() {
        let inputDate = "2024-06-02"
        let inputFormat = "yyyy-MM-dd"
        let outputFormat = "MMMM dd, yyyy"
        
        do {
            let formattedDate = try dateFormatter.format(date: inputDate, from: inputFormat, to: outputFormat)
            XCTAssertEqual(formattedDate, "June 02, 2024", "Date should be formatted correctly")
        } catch {
            XCTFail("Formatting failed with error: \(error)")
        }
    }

    func testFormatWithInvalidStringInput() {
        let inputDate = "invalid date"
        let inputFormat = "yyyy-MM-dd"
        let outputFormat = "MMMM dd, yyyy"
        
        XCTAssertThrowsError(try dateFormatter.format(date: inputDate, from: inputFormat, to: outputFormat)) { error in
            XCTAssertEqual(error as? AstroPicDayError, AstroPicDayError.unableToParseDate, "Should throw unableToParseDate error")
        }
    }

}
