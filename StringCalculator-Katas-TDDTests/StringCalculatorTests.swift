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
        let (parsedInput, customDelimiter) = parseInput(input)
        
        let operands = parsedInput.split(whereSeparator: { separatorRule($0, customDelimiter: customDelimiter) })
            .compactMap({ Int($0) })
        
        try validateNotNegativeNumbers(operands)
        
        return operands.reduce(into: 0, { acc, e in
            guard e <= 1000 else { return }
            acc += e
        })
    }

    private static func parseInput(_ input: String) -> (input: String, customDelimiter: String?) {
        guard hasCustomDelimiter(input), let newLineIndex = input.firstIndex(where: { $0 == "\n" }) else {
            return (input, nil)
        }
        
        let customDelimiterStartIndex = input.index(input.startIndex, offsetBy: 2)
        let customDelimiterIndexRange = customDelimiterStartIndex..<newLineIndex
        let customDelimiter = String(input[customDelimiterIndexRange])
        
        var inputCleaned = input
        let customDelimiterDefinitionRange = input.startIndex...newLineIndex
        inputCleaned.removeSubrange(customDelimiterDefinitionRange)
        
        return (inputCleaned, customDelimiter)
    }
    
    private static func hasCustomDelimiter(_ input: String) -> Bool {
        input.hasPrefix("//")
    }
    
    private static func separatorRule(_ character: Character, customDelimiter: String?) -> Bool {
        if let customDelimiter = customDelimiter {
            return String(character) == customDelimiter
        }
        return character == "," || character == "\n"
    }
    
    private static func validateNotNegativeNumbers(_ operands: [Int]) throws {
        let negativeNumbers = operands.filter({ $0 < 0 })
        if !negativeNumbers.isEmpty {
            let negativeNumbersCommandSeparated = negativeNumbers.map({ "\($0)," })
                .joined()
                .dropLast(1)
            throw Error.negativesNotAllowed(message: "negatives not allowed: \(negativeNumbersCommandSeparated)")
        }
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
    
    func test_add_numbersGreatherThanThousandAreIgnored() throws {
        let receivedSum = try StringCalculator.add("1000\n2000,3000\n4000")
        XCTAssertEqual(receivedSum, 1000)
    }
    
    func test_add_singleCharDelimiterCanBeDefined() throws {
        let receivedSum = try StringCalculator.add("//#\n1#2")
        XCTAssertEqual(receivedSum, 3)
    }
    
}
