//
//  day1_part2.swift
//  advent-of-code-2023
//
//  Created by Oleksandr Balabanov on 04/08/2024.
//

import Foundation

final class day1part2 {
    func solution(_ elements: [String]) -> Int {
        var sum = 0
        for line in elements where !line.isEmpty {
            let lineNumbers = parseLine(line)
            let integer = lineNumbers.0 * 10 + lineNumbers.1
            sum += integer
        }
        return sum
    }

    private func parseLine(_ line: String) -> (Int, Int) {
        let characters = Array(line)
        var left = 0
        var right = line.count - 1
        
        var leftElement: Int?
        var rightElement: Int?
        
        while leftElement == nil {
            if let l = parseChar(characters[left], inLine: line, atIndex: left, inverse: false) {
                leftElement = l
            }
            
            left += 1
        }
        
        while rightElement == nil {
            if let r = parseChar(characters[right], inLine: line, atIndex: right, inverse: true) {
                rightElement = r
            }
            
            right -= 1
        }
        
        return (leftElement!, rightElement!)
    }

    private func parseChar(_ char: Character, inLine line: String, atIndex index: Int, inverse: Bool) -> Int? {
        if let wholeNumber = char.wholeNumberValue {
            return wholeNumber
        }
        
        for number in EligibleNumber.allCases {
            let numberLength = number.rawValue.count
            let start = inverse ? index - numberLength + 1 : index
            let end = inverse ? index + 1 : index + numberLength
            if start < 0 { continue }
            if line[start..<end] == number.rawValue {
                return number.integerValue
            }
        }
        
        return nil
    }

    enum EligibleNumber: String, CaseIterable {
        case one
        case two
        case three
        case four
        case five
        case six
        case seven
        case eight
        case nine
        
        var integerValue: Int {
            switch self {
            case .one: return 1
            case .two: return 2
            case .three: return 3
            case .four: return 4
            case .five: return 5
            case .six: return 6
            case .seven: return 7
            case .eight: return 8
            case .nine: return 9
            }
        }
    }
}

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }

    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
         return String(self[start...])
    }
}
