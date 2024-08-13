//
//  day4part2.swift
//  advent-of-code-2023
//
//  Created by Oleksandr Balabanov on 08/08/2024.
//

import Foundation

final class day4part2 {
    // Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
    func solution(_ elements: [String]) -> Int {
        let cards = elements.filter { !$0.isEmpty }.compactMap(Card.init)
        var cache = [Int: Int]()
        cards.forEach { cache[$0.number] = 0 }
        
        for card in cards {
            if card.matchingNumbers > 0 {
                let winningCardCopies = cache[card.number] ?? 0
                let matchingNumbers = card.matchingNumbers
                let currentCardCopiesOwned = winningCardCopies + 1
                let rangeStart = card.number + 1
                let rangeEnd = rangeStart + matchingNumbers
                
                for i in rangeStart..<rangeEnd {
                    cache[i, default: 0] += currentCardCopiesOwned
                }
            }
        }
        
        return cache.keys.count + cache.values.reduce(0, +)
    }
}

struct Card {
    let number: Int
    let matchingNumbers: Int
    
    init(_ string: String) {
        let numbersOnly = string.components(separatedBy: ":")
        let valid = Set(numbersOnly[1].components(separatedBy: "|")[0].components(separatedBy: " ").compactMap { Int($0) })
        let fact = Set(numbersOnly[1].components(separatedBy: "|")[1].components(separatedBy: " ").compactMap { Int($0) })
        
        number = Int(numbersOnly[0].components(separatedBy: " ").last!)!
        matchingNumbers = valid.intersection(fact).count
    }
}
