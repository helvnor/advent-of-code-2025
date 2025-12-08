import Foundation

public struct Day07 {
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

    public static func partOne(data: String) -> Int {
        let lines = data.split(separator: "\n")
        let len = lines[0].count

        var splits: [Bool] = []
        for i in 0..<len {
            splits.append(Array(lines[0])[i] == "S")
        }

        var splitCount = 0
        for line in lines.dropFirst() {
            for i in 0..<len {
                let char = Array(line)[i]
                if char == "^" && splits[i] {
                    splitCount += 1
                    splits[i] = false
                    if i > 0 {
                        splits[i - 1] = true
                    }
                    if i < (len - 1) {
                        splits[i + 1] = true
                    }

                }
            }
        }
        return splitCount
    }

    public static func partTwo(data: String) -> Int {
        let lines = data.split(separator: "\n")
        let chars: [[Character]] = lines.map { Array($0) }
        var paths: [[Int]] = Array(
            repeating: Array(repeating: 1, count: chars[0].count), count: lines.count + 1)

        let outerLen = chars.count - 1

        for outerIndex in 0..<outerLen {
            for innerIndex in 0..<chars[0].count {
                let char = chars[outerLen - outerIndex][innerIndex]
                if char == "." {
                    paths[outerLen - outerIndex][innerIndex] =
                        paths[outerLen - outerIndex + 1][innerIndex]
                    continue
                }
                if char == "^" {
                    paths[outerLen - outerIndex][innerIndex] =
                        paths[outerLen - outerIndex + 1][innerIndex + 1]
                        + paths[outerLen - outerIndex + 1][innerIndex - 1]
                    continue
                }
            }
        }
        return paths[1][chars[0].firstIndex(of: "S") ?? 0]
    }

    public static func run() -> String {
        let testData = readInput(fileName: "day07test.txt")
        let data = readInput(fileName: "day07.txt")

        let partOneExpected = 21
        let partOneResults = partOne(data: testData)
        if partOneExpected != partOneResults {
            print("Part 1 failed ☝️: \n\tExpected: \(partOneExpected), Results: \(partOneResults)")
            return ("Failed! ❌")
        }

        print("Part 1 ☝️: \(partOne(data: data))")

        let partTwoExpected = 40
        let partTwoResults = partTwo(data: testData)
        if partTwoExpected != partTwoResults {
            print("Part 2 failed ✌️: \n\tExpected: \(partTwoExpected), Results: \(partTwoResults)")
            return ("Failed! ❌")
        }

        print("Part 2 ✌️: \(partTwo(data: data))")

        return ("Completed! 🎉")
    }
}
