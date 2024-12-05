import Foundation


// part 1
let lines = input.components(separatedBy: .newlines)

var rules = [(Int, Int)]()
var sequences = [[Int]]()
var isRuleSection = true

for line in lines {
    if line.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
        isRuleSection = false
        continue
    }

    if isRuleSection {
        let parts = line.split(separator: "|")
        if parts.count == 2, let a = Int(parts[0]), let b = Int(parts[1]) {
            rules.append((a, b))
        }
    } else {
        let numbers = line.split(separator: ",").compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }
        sequences.append(numbers)
    }
}

func isValid(sequence: [Int], rules: [(Int, Int)]) -> Bool {
    var indexMap = [Int: Int]()
    for (index, number) in sequence.enumerated() {
        indexMap[number] = index
    }

    for (a, b) in rules {
        if let indexA = indexMap[a], let indexB = indexMap[b] {
            if indexA >= indexB {
                return false
            }
        }
    }
    return true
}

var totalSum = 0

for sequence in sequences {
    if isValid(sequence: sequence, rules: rules) {
        let middleIndex = sequence.count / 2
        let middleValue = sequence[middleIndex]
        totalSum += middleValue
    }
}

// part 2
func sortSequence(sequence: [Int], rules: [(Int, Int)]) -> [Int]? {
    let sequenceSet = Set(sequence)
    var graph = [Int: [Int]]()
    var inDegree = [Int: Int]()

    for num in sequence {
        inDegree[num] = 0
        graph[num] = []
    }

    for (a, b) in rules {
        if sequenceSet.contains(a) && sequenceSet.contains(b) {
            graph[a]?.append(b)
            inDegree[b, default: 0] += 1
        }
    }

    var queue = [Int]()
    for (num, degree) in inDegree {
        if degree == 0 {
            queue.append(num)
        }
    }

    var sortedSequence = [Int]()
    while !queue.isEmpty {
        let current = queue.removeFirst()
        sortedSequence.append(current)

        if let neighbors = graph[current] {
            for neighbor in neighbors {
                inDegree[neighbor, default: 0] -= 1
                if inDegree[neighbor] == 0 {
                    queue.append(neighbor)
                }
            }
        }
    }

    if sortedSequence.count == sequence.count {
        return sortedSequence
    } else {
        return nil
    }
}

var totalSum2 = 0

for sequence in sequences {
    if !isValid(sequence: sequence, rules: rules) {
        if let sortedSequence = sortSequence(sequence: sequence, rules: rules) {
            let middleIndex = sortedSequence.count / 2
            let middleValue = sortedSequence[middleIndex]
            totalSum2 += middleValue
        } else {
            print("Cannot sort sequence due to cycle: \(sequence)")
        }
    }
}

