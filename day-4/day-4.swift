import Foundation

let fileName = "input.txt"
let currentDirectory = FileManager.default.currentDirectoryPath
let filePath = "\(currentDirectory)/\(fileName)"
let input = try! String(contentsOfFile: filePath, encoding: .utf8)

// part 1
let lines = input.components(separatedBy: .newlines).filter { !$0.isEmpty }
let grid = lines.map { Array($0) }
let directions = [
    (dx: -1, dy: -1),
    (dx: -1, dy: 0),
    (dx: -1, dy: 1),
    (dx: 0, dy: -1),
    (dx: 0, dy: 1),
    (dx: 1, dy: -1),
    (dx: 1, dy: 0),
    (dx: 1, dy: 1)
]

let numRows = grid.count
let numCols = grid[0].count

func countOccurrences(of word: String, in grid: [[Character]]) -> Int {
    let numRows = grid.count
    let numCols = grid[0].count
    let wordLength = word.count
    var totalCount = 0

    for row in 0..<numRows {
        for col in 0..<numCols {
            for direction in directions {
                let dx = direction.dx
                let dy = direction.dy
                var collectedWord = ""
                var x = row
                var y = col

                for _ in 0..<wordLength {
                    if x < 0 || x >= numRows || y < 0 || y >= numCols {
                        break
                    }
                    collectedWord.append(grid[x][y])
                    x += dx
                    y += dy
                }

                if collectedWord == word {
                    totalCount += 1
                }
            }
        }
    }
    return totalCount
}

let totalOccurrences = countOccurrences(of: "XMAS", in: grid)

// part 2
func isValidXMASPattern(at row: Int, col: Int, in grid: [[Character]]) -> Bool {
    if row <= 0 || row >= numRows - 1 || col <= 0 || col >= numCols - 1 {
        return false
    }

    var nwSeValid = false
    var neSwValid = false

    let nwRow = row - 1
    let nwCol = col - 1
    let seRow = row + 1
    let seCol = col + 1

    if grid[nwRow][nwCol] == "M" && grid[seRow][seCol] == "S" ||
       grid[nwRow][nwCol] == "S" && grid[seRow][seCol] == "M" {
        nwSeValid = true
    }

    let neRow = row - 1
    let neCol = col + 1
    let swRow = row + 1
    let swCol = col - 1

    if grid[neRow][neCol] == "M" && grid[swRow][swCol] == "S" ||
       grid[neRow][neCol] == "S" && grid[swRow][swCol] == "M" {
        neSwValid = true
    }

    return nwSeValid && neSwValid
}

var totalCount = 0

for row in 1..<(numRows - 1) {
    for col in 1..<(numCols - 1) {
        if grid[row][col] == "A" {
            if isValidXMASPattern(at: row, col: col, in: grid) {
                totalCount += 1
            }
        }
    }
}


