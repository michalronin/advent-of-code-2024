import Foundation

let fileName = "input.txt"
let currentDirectory = FileManager.default.currentDirectoryPath
let filePath = "\(currentDirectory)/\(fileName)"
let inputString = try! String(contentsOfFile: filePath, encoding: .utf8)

// part 1
let pattern = #"mul\((\d{1,3}),(\d{1,3})\)"#

do {
    let regex = try NSRegularExpression(pattern: pattern)

    let matches = regex.matches(in: inputString, range: NSRange(inputString.startIndex..., in: inputString))

    var multiplicationResults: [Int] = []

    for match in matches {
        if match.numberOfRanges == 3 {
            let range1 = Range(match.range(at: 1), in: inputString)!
            let range2 = Range(match.range(at: 2), in: inputString)!

            if let num1 = Int(inputString[range1]), let num2 = Int(inputString[range2]) {
                multiplicationResults.append(num1 * num2)
            }
        }
    }

    let totalSum = multiplicationResults.reduce(0, +)
} catch {
    print("Error in regex: \(error)")
}

// part 2
let directivePattern = #"do\(\)|don't\(\)"#
let mulPattern = #"mul\((\d+),(\d+)\)"#

let combinedPattern = "\(directivePattern)|\(mulPattern)"

do {
    let regex = try NSRegularExpression(pattern: combinedPattern)
    let matches = regex.matches(in: inputString, range: NSRange(inputString.startIndex..., in: inputString))
    var isMulEnabled = true
    var multiplicationResults: [Int] = []

    for match in matches {
        let matchRange = match.range
        if let range = Range(matchRange, in: inputString) {
            let matchedString = String(inputString[range])

            if matchedString == "do()" {
                isMulEnabled = true
            } else if matchedString == "don't()" {
                isMulEnabled = false
            }
            else if match.numberOfRanges == 3, isMulEnabled {
                if let num1Range = Range(match.range(at: 1), in: inputString),
                   let num2Range = Range(match.range(at: 2), in: inputString),
                   let num1 = Int(inputString[num1Range]),
                   let num2 = Int(inputString[num2Range]) {
                    multiplicationResults.append(num1 * num2)
                }
            }
        }
    }
    let totalSum = multiplicationResults.reduce(0, +)

    print("Multiplication Results: \(multiplicationResults)")
    print("Total Sum of Results: \(totalSum)")
} catch {
    print("Error in regex: \(error)")
}
