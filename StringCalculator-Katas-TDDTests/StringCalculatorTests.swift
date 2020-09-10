//
//  StringCalculatorTests.swift
//  StringCalculator-Katas-TDDTests
//
//  Created by Roberto Abreu on 9/10/20.
//  Copyright © 2020 Roberto Abreu. All rights reserved.
//

import XCTest

class StringCalculatorTests: XCTestCase {

    func test_add_returnsZeroForEmptyInput() throws {
        let receivedSum = try StringCalculator.add("")
        XCTAssertEqual(receivedSum, 0)
    }

    func test_add_withSingleNumberInputReturnsInput() throws {
        let receivedSum = try StringCalculator.add("2")
        XCTAssertEqual(receivedSum, 2)
    }
    
    func test_add_withTwoNumbersCommaDelimitedReturnsTheSum() throws {
        let receivedSum = try StringCalculator.add("10,20")
        XCTAssertEqual(receivedSum, 30)
    }
    
    func test_add_withTwoNumbersNewlineDelimitedReturnsTheSum() throws {
        let receivedSum = try StringCalculator.add("2\n3")
        XCTAssertEqual(receivedSum, 5)
    }
    
    func test_add_withMultiplesNumbersMixedDelimitedReturnsTheSum() throws {
        let receivedSum = try StringCalculator.add("1\n2,3\n4")
        XCTAssertEqual(receivedSum, 10)
    }
    
    func test_add_inputWithNegativeNumbersThrowAnException() {
        XCTAssertThrowsError(try StringCalculator.add("-1,2,-3")) { receivedError in
            switch receivedError {
            case let error as StringCalculator.Error:
                XCTAssertEqual(error, .negativesNotAllowed(message: "negatives not allowed: -1,-3"))
            default:
                XCTFail("Expected to received negativesNotAllowed, but got \(receivedError) instead")
            }
        }
    }
    
    func test_add_numbersGreatherThanThousandAreIgnored() throws {
        let receivedSum = try StringCalculator.add("1000\n2000,3000\n4000")
        XCTAssertEqual(receivedSum, 1000)
    }
    
    func test_add_singleCharDelimiterCanBeDefined() throws {
        let receivedSum = try StringCalculator.add("//#\n1#2")
        XCTAssertEqual(receivedSum, 3)
    }
    
    func test_add_multiCharDelimiterCanBeDefined() throws {
        let receivedSum = try StringCalculator.add("//###\n1###2")
        XCTAssertEqual(receivedSum, 3)
    }
    
}
