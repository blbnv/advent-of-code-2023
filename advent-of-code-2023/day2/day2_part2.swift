//
//  day2_part2.swift
//  advent-of-code-2023
//
//  Created by Oleksandr Balabanov on 04/08/2024.
//

import Foundation

final class day2part2 {
    func solution(_ elements: [String]) -> Int {
        var result = 0
        for element in elements where !element.isEmpty {
            let number = getResultForSingleGame(element)
            result += number
        }
        return result
    }
    
    private func getResultForSingleGame(_ record: String) -> Int {
        let components = record.components(separatedBy: ":")
        let gameRecordComponent = components[1]
        let subsets = gameRecordComponent.components(separatedBy: ";")
        
        var maxRed = 0
        var maxGreen = 0
        var maxBlue = 0
        
        for subset in subsets {
            let processed = processSubset(subset.components(separatedBy: ","))
            maxRed = max(maxRed, processed.0)
            maxGreen = max(maxGreen, processed.1)
            maxBlue = max(maxBlue, processed.2)
        }
        
        return maxRed * maxBlue * maxGreen
    }
    
    // R/B/G
    private func processSubset(_ subset: [String]) -> (Int, Int, Int) {
        var r = 0
        var b = 0
        var g = 0

        for element in subset {
            let trimmedComponents = element.trimmingCharacters(in: .whitespaces).components(separatedBy: " ")
            let amount = Int(trimmedComponents[0])!
            let color = trimmedComponents[1]

            switch color {
            case "red": r = amount
            case "green": g = amount
            case "blue": b = amount
            default: fatalError()
            }
        }

        return (r, b, g)
    }
}
