import Foundation

public struct Day04 {
    public static func readInput(fileName: String) -> String {
        do {
            let fileContents = try String(
                contentsOf: URL(fileURLWithPath: "./Data/\(fileName)"), encoding: .utf8)
            return fileContents.trimmingCharacters(in: .whitespacesAndNewlines)
        } catch {
            print("Error reading file \(fileName): \(error)")
            return ""
        }
    }

    public static func canAccessRoll(grid: [[Bool]], y: Int, x: Int) -> Bool {
        guard grid[y][x] else { return false }

        var counter = 0

        if y > 0 && grid[y - 1][x] { counter += 1 }  // N
        if y < grid.count - 1 && grid[y + 1][x] { counter += 1 }  // S
        if x > 0 && grid[y][x - 1] { counter += 1 }  // W
        if x < grid[0].count - 1 && grid[y][x + 1] { counter += 1 }  // E

        if y > 0 && x > 0 && grid[y - 1][x - 1] { counter += 1 }  // NW
        if y > 0 && x < grid[0].count - 1 && grid[y - 1][x + 1] { counter += 1 }  // NE
        if y < grid.count - 1 && x > 0 && grid[y + 1][x - 1] { counter += 1 }  // SW
        if y < grid.count - 1 && x < grid[0].count - 1 && grid[y + 1][x + 1] { counter += 1 }  // SE

        return counter < 4
    }

    public static func partOne(data: String) -> Int {
        var grid: [[Bool]] = []
        let lines = data.split(separator: "\n")

        for line in lines {
            var row: [Bool] = []
            for char in Array(line) {
                row.append(char == "@")
            }
            grid.append(row)
        }

        var count = 0

        for y in 0..<grid.count {
            for x in 0..<grid[0].count {
                if canAccessRoll(grid: grid, y: y, x: x) {
                    count += 1
                }
            }
        }

        return count
    }

    public static func partTwo(data: String) -> Int {
        var grid: [[Bool]] = []
        let lines = data.split(separator: "\n")

        for line in lines {
            var row: [Bool] = []
            for char in Array(line) {
                row.append(char == "@")
            }
            grid.append(row)
        }

        var count = 0
        var changes = true

        while changes {
            changes = false
            for y in 0..<grid.count {
                for x in 0..<grid[0].count {
                    if canAccessRoll(grid: grid, y: y, x: x) {
                        count += 1
                        grid[y][x] = false
                        changes = true
                    }
                }
            }
        }

        return count
    }

    public static func run() -> String {
        let testData = readInput(fileName: "day04test.txt")
        let data = readInput(fileName: "day04.txt")

        let partOneExpected = 13
        let partOneResults = partOne(data: testData)
        if partOneExpected != partOneResults {
            print("Part 1 failed ☝️: \n\tExpected: \(partOneExpected), Results: \(partOneResults)")
            return ("Failed! ❌")
        }

        print("Part 1 ☝️: \(partOne(data: data))")

        let partTwoExpected = 43
        let partTwoResults = partTwo(data: testData)
        if partTwoExpected != partTwoResults {
            print("Part 2 failed ✌️: \n\tExpected: \(partTwoExpected), Results: \(partTwoResults)")
            return ("Failed! ❌")
        }

        print("Part 2 ✌️: \(partTwo(data: data))")

        return ("Completed! 🎉")
    }
}
