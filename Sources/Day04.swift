//
//  Day04.swift
//  AdventOfCode
//
//  Created by Maris Lagzdins on 02/12/2024.
//

import Algorithms

struct Day04: AdventDay {

  struct Point {
    var row: Int
    var col: Int
  }

  enum Direction: CaseIterable {
    case upLeft
    case up
    case upRight
    case right
    case downRight
    case down
    case downLeft
    case left
  }

  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  var lines: [[Character]] {
    data
      .split(separator: .newlineSequence)
      .map { line in
        line.map { $0 }
      }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    let word = "XMAS"
    var wordCount = 0
    let lines = lines

    for (rowIndex, line) in lines.enumerated() {
      for (colIndex, _) in line.enumerated() {
        Direction.allCases.forEach { direction in
          if contains(word: word, in: lines, startingFrom: .init(row: rowIndex, col: colIndex), at: direction) {
            wordCount += 1
          }
        }
      }
    }

    return wordCount
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var wordCount = 0
    let lines = lines

    for (rowIndex, line) in lines.enumerated() {
      for (colIndex, _) in line.enumerated() {
        if containsMAS(in: lines, center: .init(row: rowIndex, col: colIndex)) {
          wordCount += 1
        }
      }
    }

    return wordCount
  }

  func isCharacter(_ character: Character, in lines: [[Character]], at point: Point) -> Bool {
    guard point.row >= 0 && point.row < lines.count else {
      return false
    }

    guard point.col >= 0 && point.col < lines[point.row].count else {
      return false
    }

    return lines[point.row][point.col] == character
  }

  func contains(word: String, in lines: [[Character]], startingFrom startPoint: Point, at direction: Direction) -> Bool {
    var point = startPoint
    return word.allSatisfy { character in
      if isCharacter(character, in: lines, at: point) {
        point = move(from: point, to: direction)
        return true
      } else {
        return false
      }
    }
  }

  func containsMAS(in lines: [[Character]], center centerPoint: Point) -> Bool {
    let word = "MAS"

    // first word
    let startingPoint1 = move(from: centerPoint, to: .upLeft)
    let startingPoint2 = move(from: centerPoint, to: .downRight)

    let startingPoint3 = move(from: centerPoint, to: .upRight)
    let startingPoint4 = move(from: centerPoint, to: .downLeft)

    let contains1 = contains(word: word, in: lines, startingFrom: startingPoint1, at: .downRight)
    let contains2 = contains(word: word, in: lines, startingFrom: startingPoint2, at: .upLeft)
    let contains3 = contains(word: word, in: lines, startingFrom: startingPoint3, at: .downLeft)
    let contains4 = contains(word: word, in: lines, startingFrom: startingPoint4, at: .upRight)

    return (contains1 || contains2) && (contains3 || contains4)
  }

  func move(from point: Point, to direction: Direction) -> Point {
    switch direction {
    case .upLeft:
        .init(row: point.row - 1, col: point.col - 1)

    case .up:
        .init(row: point.row - 1, col: point.col)

    case .upRight:
        .init(row: point.row - 1, col: point.col + 1)

    case .right:
        .init(row: point.row, col: point.col + 1)

    case .downRight:
        .init(row: point.row + 1, col: point.col + 1)

    case .down:
        .init(row: point.row + 1, col: point.col)

    case .downLeft:
        .init(row: point.row + 1, col: point.col - 1)

    case .left:
        .init(row: point.row, col: point.col - 1)
    }
  }
}
