//
//  StringCalculatorTests.swift
//  StringCalculator-Katas-TDDTests
//
//  Created by Roberto Abreu on 9/10/20.
//  Copyright © 2020 Roberto Abreu. All rights reserved.
//

import XCTest

struct StringCalculator {
        
    enum Error: Swift.Error, Equatable {
        case negativesNotAllowed(message: String)
        
        static func ==(lhs: Error, rhs: Error) -> Bool {
            switch (lhs, rhs) {
            case let (.negativesNotAllowed(lhsMessage), .negativesNotAllowed(rhsMessage)):
                return lhsMessage == rhsMessage
            }
        }
    }

    static func add(_ input: String) throws -> Int {
        let operands = input.split(whereSeparator: separatorRule)
            .compactMap({ Int($0) })
        
        let negativeNumbers = operands.filter({ $0 < 0 })
        if !negativeNumbers.isEmpty {
            let negativeNumbersCommandSeparated = negativeNumbers.map({ "\($0)," })
                .joined()
                .dropLast(1)
            throw Error.negativesNotAllowed(message: "negatives not allowed: \(negativeNumbersCommandSeparated)")
        }
        
        return operands.reduce(into: 0, { acc, e in acc += e })
    }
    
    private static func separatorRule(_ character: Character) -> Bool {
        character == "," || character == "\n"
    }
    
}

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
    
}
