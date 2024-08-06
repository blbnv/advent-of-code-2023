//
//  day4part1.swift
//  advent-of-code-2023
//
//  Created by Oleksandr Balabanov on 06/08/2024.
//

import Foundation

final class day4part1 {
    // Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
    func solution(_ elements: [String]) -> Int {
        var result = 0
        for card in elements where !card.isEmpty {
            let numbersOnly = card.components(separatedBy: ":")
            let valid = Set(numbersOnly[1].components(separatedBy: "|")[0].components(separatedBy: " ").compactMap { Int($0) })
            let fact = Set(numbersOnly[1].components(separatedBy: "|")[1].components(separatedBy: " ").compactMap { Int($0) })
            result += score(valid.intersection(fact).count)
        }
        return result
    }
    
    func score(_ number: Int) -> Int {
        var score = 0
        var temp = number
        while temp > 0 {
            if temp == number { score = 1 }
            else { score *= 2 }
            temp -= 1
        }
        return score
    }
}
