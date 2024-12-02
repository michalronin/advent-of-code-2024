let fileName = "input.txt"
let currentDirectory = FileManager.default.currentDirectoryPath
let filePath = "\(currentDirectory)/\(fileName)"
let input = try! String(contentsOfFile: filePath, encoding: .utf8)

let lines = input.split(separator: "\n")
let arraysOfInts = lines.map { line in
    line.split(separator: " ").compactMap { Int($0) }
}

// part 1
var safe: [Bool] = []

arraysOfInts.forEach { array in
    var isSafe: Bool = true
    for (index, number) in array.enumerated() {
        if index == 0 { continue }
        let previous = array[index - 1]
        let difference = abs(number - previous)
        if difference < 1 || difference > 3 {
            isSafe = false
            break
        }
    }
    let isAscending = array.sorted() == array
    let isDescending = array.sorted(by: >) == array

    if !(isAscending || isDescending) {
        isSafe = false
    }
    safe.append(isSafe)
}

let safeReports = safe.filter { $0 }.count

// part 2

var safe2: [Bool] = []

func isArraySafe(_ array: [Int]) -> Bool {
    let isAscending = array.sorted() == array
    let isDescending = array.sorted(by: >) == array

    if !(isAscending || isDescending) {
        return false
    }
    for i in 1..<array.count {
        let difference = abs(array[i] - array[i - 1])
        if difference < 1 || difference > 3 {
            return false
        }
    }
    return true
}

arraysOfInts.forEach { array in
    var isSafe = false
    if isArraySafe(array) {
        isSafe = true
    } else {
        for i in 0..<array.count {
            var modifiedArray = array
            modifiedArray.remove(at: i)

            if isArraySafe(modifiedArray) {
                isSafe = true
                break
            }
        }
    }
    safe2.append(isSafe)
}

let safeReports2 = safe2.filter { $0 }.count

