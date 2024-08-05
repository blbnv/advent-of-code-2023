//
//  day3_part2.swift
//  advent-of-code-2023
//
//  Created by Oleksandr Balabanov on 05/08/2024.
//

import Foundation

final class day3part2 {
    func solution(_ elements: [String]) -> Int {
        let dict = memoizeElements(elements)
        return saveNumbers(elements, dictionary: dict)
    }
    
    // Returns tuple 0: gear index, 1: number
    func sumIfNeeded(_ n: Int, database: [Int: Int], number: Int, indexes: [Int]) -> (Int, Int)? {
        let leftIndex = indexes.first!
        let numLength = indexes.count
    
        let row = Int(leftIndex / n)
        let topRow = max(0, row - 1)
        let bottomRow = min(n, row + 1)
        let rows = [row, topRow, bottomRow]
        
        let col = leftIndex % n
        let leftCol = max(0, col - 1)
        let rightCol = min(n, col + numLength)
        let cols: [Int] = Array(leftCol...rightCol)
        
        for row in rows {
            for col in cols {
                let indexToCheck = row * n + col
                if database[indexToCheck] == 2 {
                    return (indexToCheck, number)
                }
            }
        }

        return nil
    }
    
    // Save numbers with their digits positions
    private func saveNumbers(_ elements: [String], dictionary: [Int: Int]) -> Int {
        let length = elements.first!.count
        var gearsCache = [Int: [Int]]()
        
        for (i, row) in elements.enumerated() {
            var currentNumber = 0
            var currentIndexes = [Int]()
            
            for (k, char) in row.enumerated() {
                // Flush
                if !char.isNumber, currentNumber != 0 {
                    if let gearResult = sumIfNeeded(length, database: dictionary, number: currentNumber, indexes: currentIndexes) {
                        let previous = gearsCache[gearResult.0] ?? [Int]()
                        gearsCache[gearResult.0] = previous + [gearResult.1]
                    }
                    
                    currentNumber = 0
                    currentIndexes = []
                    continue
                }
                
                if char.isNumber {
                    currentNumber *= 10
                    currentNumber += char.wholeNumberValue!
                    currentIndexes.append(i * length + k)
                    continue
                }
            }
            
            if currentNumber != 0 {
                if let gearResult = sumIfNeeded(length, database: dictionary, number: currentNumber, indexes: currentIndexes) {
                    let previous = gearsCache[gearResult.0] ?? [Int]()
                    gearsCache[gearResult.0] = previous + [gearResult.1]
                }
                currentNumber = 0
                currentIndexes = []
            }
        }
        
        var result = 0
        
        for value in gearsCache.values where value.count == 2 {
            result += value.first! * value.last!
        }
        
        return result
    }
    
    /// Returns [Int: Int], where key is an index in the collection, and value is 0, 1, 2, 3
    /// Where: 0 - void, 1 - number, 2 - gear, 3 - anything else
    private func memoizeElements(_ elements: [String]) -> [Int: Int] {
        var dict = [Int: Int]()
        let length = elements.first!.count
        
        for (i, row) in elements.enumerated() {
            for (k, char) in row.enumerated() {
                let index = i * length + k
                dict[index] = transformCharToSpecialCode(char)
            }
        }
        
        return dict
    }

    func transformCharToSpecialCode(_ char: Character) -> Int {
        if char == "." { return 0 }
        if char.isNumber { return 1}
        if char == "*" { return 2 }
        return 3
    }

    private func calculateMatrixSize(_ matrix: [String]) -> (Int, Int) {
        // minus one to drop the last empty line
        return (matrix.first?.count ?? 0, matrix.count - 1)
    }
}
