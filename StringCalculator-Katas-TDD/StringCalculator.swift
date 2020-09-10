//
//  StringCalculator.swift
//  StringCalculator-Katas-TDD
//
//  Created by Roberto Abreu on 9/10/20.
//  Copyright © 2020 Roberto Abreu. All rights reserved.
//

import Foundation

public struct StringCalculator {
        
    public enum Error: Swift.Error, Equatable {
        case negativesNotAllowed(message: String)
        
        public static func ==(lhs: Error, rhs: Error) -> Bool {
            switch (lhs, rhs) {
            case let (.negativesNotAllowed(lhsMessage), .negativesNotAllowed(rhsMessage)):
                return lhsMessage == rhsMessage
            }
        }
    }

    public static func add(_ input: String) throws -> Int {
        let (parsedInput, customDelimiter) = parseInput(input)
        
        let operands = splitInput(parsedInput, customDelimiter: customDelimiter)
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
    
    private static func splitInput(_ input: String, customDelimiter: String?) -> [String] {
        if let customDelimiter = customDelimiter {
            return input.components(separatedBy: customDelimiter)
        } else {
            return input.components(separatedBy: CharacterSet(charactersIn: "\n,"))
        }
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
