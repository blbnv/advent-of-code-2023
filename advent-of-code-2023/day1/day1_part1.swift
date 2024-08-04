//
//  day1_part1.swift
//  advent-of-code-2023
//
//  Created by Oleksandr Balabanov on 04/08/2024.
//

import Foundation

final class day1part1 {
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
        
        // left
        while leftElement == nil {
            if let l = characters[left].wholeNumberValue {
                leftElement = l
            }
            
            left += 1
        }
        
        // right
        while rightElement == nil {
            if let r = characters[right].wholeNumberValue {
                rightElement = r
            }
            
            right -= 1
        }
        
        return (leftElement!, rightElement!)
    }
}
