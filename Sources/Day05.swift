import Foundation

public struct Day05 {
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
        var ranges: [ClosedRange<Int>] = []

        var index = 0
        for (i, line) in lines.enumerated() {
            if line.contains("-") {
                let r = line.split(separator: "-")
                let start = Int(String(r[0])) ?? 0
                let finish = Int(String(r[1])) ?? 0
                ranges.append(start...finish)

                index = i
            }
        }
        var counter = 0

        let values = lines.dropFirst(index + 1)
        for val in values {
            var found = false
            for range in ranges {
                if range.contains(Int(val) ?? -1) {
                    counter += 1
                    found = true
                    break
                }
            }
            if found {
                continue
            }
        }

        return counter
    }

    public static func partTwo(data: String) -> Int {
        let lines = data.split(separator: "\n")
        var ranges: [ClosedRange<Int>] = []

        for line in lines {
            if line.contains("-") {
                let r = line.split(separator: "-")
                let start = Int(String(r[0])) ?? 0
                let finish = Int(String(r[1])) ?? 0
                ranges.append(start...finish)
            }
        }

        var mergedRanges: [ClosedRange<Int>] = []
        let sortedRanges = ranges.sorted { $0.lowerBound < $1.lowerBound }

        var prev = sortedRanges[0]
        for i in 1..<sortedRanges.count {
            let next = sortedRanges[i]
            if next.lowerBound <= prev.upperBound + 1 {
                prev = prev.lowerBound...max(prev.upperBound, next.upperBound)
            } else {
                mergedRanges.append(prev)
                prev = next
            }
        }
        mergedRanges.append(prev)

        var counter = 0
        for range in mergedRanges {
            counter += range.count
        }
        return counter
    }

    public static func run() -> String {
        let testData = readInput(fileName: "day05test.txt")
        let data = readInput(fileName: "day05.txt")

        let partOneExpected = 3
        let partOneResults = partOne(data: testData)
        if partOneExpected != partOneResults {
            print("Part 1 failed ☝️: \n\tExpected: \(partOneExpected), Results: \(partOneResults)")
            return ("Failed! ❌")
        }

        print("Part 1 ☝️: \(partOne(data: data))")

        let partTwoExpected = 14
        let partTwoResults = partTwo(data: testData)
        if partTwoExpected != partTwoResults {
            print("Part 2 failed ✌️: \n\tExpected: \(partTwoExpected), Results: \(partTwoResults)")
            return ("Failed! ❌")
        }

        print("Part 2 ✌️: \(partTwo(data: data))")

        return ("Completed! 🎉")
    }
}
