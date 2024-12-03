//
//  Day02.swift
//  AdventOfCode
//
//  Created by Maris Lagzdins on 02/12/2024.
//

import Algorithms

enum State {
  case increasing
  case decreasing
  case same
}

enum Day02Error: Error {
  case unsafe
}

struct Day02: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [[Int]] {
    data
      .split(separator: "\n")
      .map { string in
        string
          .split(separator: " ") // split the line by delimiter
          .compactMap { Int($0) }
      }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var safeReportScore = 0

    // Sort each dataset
    for levels in entities {
      do {
        try isSafe(levels: levels)
        safeReportScore += 1
      } catch {
        continue
      }
    }

    return safeReportScore
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var safeReportScore = 0

    // Sort each dataset
    for levels in entities {

      do {
        try isSafe(levels: levels)
        safeReportScore += 1
        continue
      } catch {
        // do nothing
      }

      for index in levels.indices {
        var tempLevels = levels
        tempLevels.remove(at: index)

        do {
          try isSafe(levels: tempLevels)
          safeReportScore += 1
          break

        } catch {
          continue
        }
      }
    }

    return safeReportScore
  }

  func stateOf(leftLevel: Int, rightLevel: Int) -> State {
    if leftLevel < rightLevel {
      .increasing
    } else if leftLevel > rightLevel {
      .decreasing
    } else {
      .same
    }
  }

  func isSafe(leftLevel: Int, rightLevel: Int) -> Bool {
    let minValue = min(leftLevel, rightLevel)
    let maxValue = max(leftLevel, rightLevel)
    let distance = maxValue - minValue

    guard (1...3).contains(distance) else {
      return false
    }

    return true
  }

  func isSafe(levels: [Int]) throws(Day02Error) {
    var lastKnownState: State?

    for (currentIndex, currentLevel) in levels.enumerated() {
      let nextIndex = currentIndex + 1

      guard nextIndex < levels.count else {
        // Reached the end, all good.
        break
      }

      let nextLevel = levels[nextIndex]

      let currentState = stateOf(leftLevel: currentLevel, rightLevel: nextLevel)

      guard currentState != .same else {
        throw .unsafe
      }

      guard lastKnownState == nil || lastKnownState == currentState else {
        throw .unsafe
      }

      lastKnownState = currentState

      guard isSafe(leftLevel: currentLevel, rightLevel: nextLevel) else {
        throw .unsafe
      }
    }
  }
}
