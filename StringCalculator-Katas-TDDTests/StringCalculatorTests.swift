//
//  StringCalculatorTests.swift
//  StringCalculator-Katas-TDDTests
//
//  Created by Roberto Abreu on 9/10/20.
//  Copyright © 2020 Roberto Abreu. All rights reserved.
//

import XCTest

struct StringCalculator {
    
    static func add(_ input: String) -> Int {
        return input.split(whereSeparator: separatorRule)
            .compactMap({ Int($0) })
            .reduce(into: 0, { acc, e in acc += e })
    }
    
    private static func separatorRule(_ character: Character) -> Bool {
        character == "," || character == "\n"
    }
    
}

class StringCalculatorTests: XCTestCase {

    func test_add_returnsZeroForEmptyInput() {
        let receivedSum = StringCalculator.add("")
        XCTAssertEqual(receivedSum, 0)
    }

    func test_add_withSingleNumberInputReturnsInput() {
        let receivedSum = StringCalculator.add("2")
        XCTAssertEqual(receivedSum, 2)
    }
    
    func test_add_withTwoNumbersCommaDelimitedReturnsTheSum() {
        let receivedSum = StringCalculator.add("10,20")
        XCTAssertEqual(receivedSum, 30)
    }
    
    func test_add_withTwoNumbersNewlineDelimitedReturnsTheSum() {
        let receivedSum = StringCalculator.add("2\n3")
        XCTAssertEqual(receivedSum, 5)
    }
    
}
