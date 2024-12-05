//
//  Day05.swift
//  AdventOfCode
//
//  Created by Maris Lagzdins on 02/12/2024.
//

import Algorithms

struct Day05: AdventDay {

  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  var rules: [Int: [Int]] {
    data
      .split(separator: "\n\n")
      .first?
      .split(separator: .newlineSequence)
      .map { line -> (Int, Int) in
        let result = line
          .split(separator: "|")
          .map { Int($0) ?? -1 }

        return (result[0], result[1])
      }
      .reduce([Int: [Int]]()) { partialResult, rule in
        var result = partialResult
        result[rule.0, default: []].append(rule.1)
        result[rule.0]?.sort()
        return result
      } ?? [:]
  }

  var queue: [[Int]] {
    data
      .split(separator: "\n\n")
      .last?
      .split(separator: .newlineSequence)
      .map { line in
        line
          .split(separator: ",")
          .map { Int($0) ?? -1 }
      } ?? []
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    let rules = rules
    let queues = queue
    var validQueues: [[Int]] = []

    queues.forEach { numbers in
      var isValid = true

      q1: for (index, number) in numbers.enumerated() {
        for beforeIndex in 0..<index {
          if let ruleNumbers = rules[number] {
            if ruleNumbers.contains(numbers[beforeIndex]) {
              isValid = false
              break q1
            }
          }
        }
      }

      if isValid {
        validQueues.append(numbers)
      }
    }

    return validQueues.reduce(0) { partialResult, numbers in
      partialResult + numbers[numbers.count / 2]
    }
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    let rules = rules
    let queues = queue
    var invalidQueues: [[Int]] = []
    var validQueues: [[Int]] = []

    queues.forEach { numbers in
      var isValid = true

      q1: for (index, number) in numbers.enumerated() {
        for beforeIndex in 0..<index {
          if let ruleNumbers = rules[number] {
            if ruleNumbers.contains(numbers[beforeIndex]) {
              isValid = false
              break q1
            }
          }
        }
      }

      if isValid == false {
        invalidQueues.append(numbers)
      }
    }

    invalidQueues.forEach { numbers in
      var updatedNumbers = numbers
      var isValid = false

      repeat {
        isValid = true
        q1: for (index, number) in updatedNumbers.enumerated() {
          for beforeIndex in 0..<index {
            if let ruleNumbers = rules[number] {
              if ruleNumbers.contains(updatedNumbers[beforeIndex]) {
                updatedNumbers.remove(at: index)
                updatedNumbers.insert(number, at: beforeIndex)
                isValid = false
                break q1
              }
            }
          }
        }
      } while (isValid == false)

      validQueues.append(updatedNumbers)
    }

    return validQueues.reduce(0) { partialResult, numbers in
      partialResult + numbers[numbers.count / 2]
    }
  }
}
