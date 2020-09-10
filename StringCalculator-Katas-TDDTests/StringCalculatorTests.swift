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
        guard let intInput = Int(input) else { return 0 }
        return intInput
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
    
}
