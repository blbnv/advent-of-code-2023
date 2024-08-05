//
//  main.swift
//  advent-of-code-2023
//
//  Created by Oleksandr Balabanov on 04/08/2024.
//

import Foundation

let inputElements = readLinesFromFile()!

// Day 1
// print(day1part1().solution(inputElements))
// print(day1part2().solution(inputElements))

// Day 2
// print(day2part1().solution(inputElements))
// print(day2part2().solution(inputElements))

// Day 3
print(day3part1().solution(inputElements))

// MARK: - Reading input

func readLinesFromFile() -> [String]? {
    do {
        let path = ""
        let content = try String(contentsOfFile: path, encoding: .utf8)
        let lines = content.components(separatedBy: .newlines)
        return lines
    } catch {
        print("Error reading file: \(error.localizedDescription)")
        return nil
    }
}
