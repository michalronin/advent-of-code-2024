import Foundation

let input: String = try! String(contentsOfFile: "./input.txt"

// parsing
var left: [Int] = []
var right: [Int] = []

let lines = input.split(separator: "\n")

for line in lines {
    let components = line.split(separator: " ")
    if let leftValue = Int(components[0]), let rightValue = Int(components[1]) {
        left.append(leftValue)
        right.append(rightValue)
    }
}

let sortedLeft = left.sorted()
let sortedRight = right.sorted()

// part 1
let distances = zip(sortedLeft, sortedRight).map { abs($0 - $1)}

let totalDistance = distances.reduce(0, +)

let valueCounts = right.reduce(into: [Int: Int]()) { counts, value in
    counts[value, default: 0] += 1
}

// part 2
let similarityScores = left.map { value in
    let count = valueCounts[value, default: 0]
    return count * value
}

let totalSimilarity = similarityScores.reduce(0, +)
