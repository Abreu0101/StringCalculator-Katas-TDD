//
//  StringCalculatorTests.swift
//  StringCalculator-Katas-TDDTests
//
//  Created by Roberto Abreu on 9/10/20.
//  Copyright © 2020 Roberto Abreu. All rights reserved.
//

import XCTest

struct StringCalculator {
    
    func add(_ input: String) -> Int {
        return 0
    }
    
}

class StringCalculatorTests: XCTestCase {

    func test_add_returnsZeroForEmptyInput() {
        let sut = StringCalculator()
        
        let receivedSum = sut.add("")
        
        XCTAssertEqual(receivedSum, 0)
    }

}
