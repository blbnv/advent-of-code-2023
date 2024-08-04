//
//  day2_part1.swift
//  advent-of-code-2023
//
//  Created by Oleksandr Balabanov on 04/08/2024.
//

import Foundation

final class day2part1 {
    
    private let maxRed = 12
    private let maxGreen = 13
    private let maxBlue = 14
    
    func solution(_ elements: [String]) -> Int {
        var result = 0
        for element in elements where !element.isEmpty {
            let number = getGameNumberIfNeeded(element)
            result += number
        }
        return result
    }
    
    private func getGameNumberIfNeeded(_ record: String) -> Int {
        let components = record.components(separatedBy: ":")
        let gameIDComponent = components[0]
        let gameRecordComponent = components[1]
        
        if bagSatisfiesCriteria(gameRecordComponent) {
            return getGameID(gameIDComponent)
        }

        return 0
    }
    
    private func bagSatisfiesCriteria(_ record: String) -> Bool {
        let subsets = record.components(separatedBy: ";")
        for subset in subsets {
            let subsetArray = subset.components(separatedBy: ",")
            if !subsetSatisfiesCriteria(subsetArray) { return false }
        }
        return true
    }
    
    private func subsetSatisfiesCriteria(_ subset: [String]) -> Bool {
        for element in subset {
            let trimmedComponents = element.trimmingCharacters(in: .whitespaces).components(separatedBy: " ")
            let amount = Int(trimmedComponents[0])!
            let color = trimmedComponents[1]
            
            switch color {
            case "red": if amount > maxRed { return false }
            case "green": if amount > maxGreen { return false }
            case "blue": if amount > maxBlue { return false }
            default: fatalError()
            }
        }
        return true
    }
    
    private func getGameID(_ gameComponent: String) -> Int {
        return Int(gameComponent.components(separatedBy: " ")[1])!
    }
}
