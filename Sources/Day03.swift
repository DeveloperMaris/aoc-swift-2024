//
//  Day03.swift
//  AdventOfCode
//
//  Created by Maris Lagzdins on 02/12/2024.
//

import Algorithms
import RegexBuilder

struct Day03: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    let numberRef = Reference(Int.self)
    let multiplierRef = Reference(Int.self)

    let regex = Regex {
      "mul("
      TryCapture(as: numberRef) {
        OneOrMore(.digit)
      } transform: { match in
        Int(match)
      }
      ","
      TryCapture(as: multiplierRef) {
        OneOrMore(.digit)
      } transform: { match in
        Int(match)
      }
      ")"
    }

    return data
      .matches(of: regex)
      .map { match -> (number: Int, multiplier: Int) in
        (match[numberRef], match[multiplierRef])
      }
      .reduce(0) { partialResult, entity in
        partialResult + entity.number * entity.multiplier
      }
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    let numberRef = Reference(Int.self)
    let multiplierRef = Reference(Int.self)

    let regex = Regex {
      "mul("
      TryCapture(as: numberRef) {
        OneOrMore(.digit)
      } transform: { match in
        Int(match)
      }
      ","
      TryCapture(as: multiplierRef) {
        OneOrMore(.digit)
      } transform: { match in
        Int(match)
      }
      ")"
    }

    return data
      .split(separator: "do()")
      .map { string in
        let keyword = "don't()"
        let range = string.ranges(of: keyword).first

        if let range {
          return string[..<range.lowerBound]
        } else {
          return string
        }
      }
      .joined()
      .matches(of: regex)
      .map { match -> (number: Int, multiplier: Int) in
        (match[numberRef], match[multiplierRef])
      }
      .reduce(0) { partialResult, entity in
        partialResult + entity.number * entity.multiplier
      }
  }
}
