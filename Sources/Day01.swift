//
//  Day01.swift
//  AdventOfCode
//
//  Created by Maris Lagzdins on 02/12/2024.
//

import Algorithms

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: (left: [Int], right: [Int]) {
    var column1: [Int] = []
    var column2: [Int] = []

    data
      .split(separator: "\n") // split by line
      .map { string in
        string
          .split(separator: "   ") // split the line by delimiter
          .compactMap { Int($0) }
      }
      .forEach {
        // Separate data into 2 datasets
        column1.append($0[0])
        column2.append($0[1])
      }

    return (column1, column2)
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var totalDistanceScore = 0

    // Sort each dataset
    let column1 = entities.left.sorted()
    let column2 = entities.right.sorted()

    // Calculate each dataset element distance
    guard column1.count == column2.count else {
      return 0
    }

    for index in column1.indices {
      let minValue = min(column1[index], column2[index])
      let maxValue = max(column1[index], column2[index])
      let distance = minValue.distance(to: maxValue)
      totalDistanceScore += distance
    }

    return totalDistanceScore
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var totalSimilarityScore = 0

    let column1 = entities.left
    let column2 = entities.right

    for value in column1 {
      let countInColumn2 = column2
        .filter { $0 == value }
        .count

      totalSimilarityScore += value * countInColumn2
    }

    return totalSimilarityScore
  }
}

