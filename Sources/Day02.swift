import Foundation

public struct Day02 {
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

    public static func findNextInvalidDouble(current: Int) -> Int {
        let len = String(current).count
        let start = len % 2 != 0 ? Int(10).pow(len) : current
        let startString = String(start)

        let midIndex = startString.index(startString.startIndex, offsetBy: startString.count / 2)
        var firstHalf = Int(startString[..<midIndex]) ?? 0
        let secondHalf = Int(startString[midIndex...]) ?? 0

        if firstHalf < secondHalf {
            firstHalf += 1
        }

        return firstHalf * (1 + Int(10).pow(String(firstHalf).count))
    }

    public static func calcNextMatch(val: Int, numParts: Int, len: Int) -> Int {

        let valString = String(val)

        var parts: [Substring] = []
        var indexMem = valString.startIndex

        for _ in 0..<numParts {
            let nextIndex = valString.index(indexMem, offsetBy: len)
            parts.append(valString[indexMem..<nextIndex])
            indexMem = nextIndex
        }

        if (parts.allSatisfy { $0 == parts.first }) {
            return val
        }

        if (parts.allSatisfy { Int(String($0)) ?? 0 <= Int(String(parts.first!)) ?? 0 }) {
            let first = parts[0]
            for i in 0..<parts.count {
                parts[i] = first
            }
            return Int(parts.joined()) ?? Int.max
        }

        var val = Int(parts[0])!
        for part in parts {
            let nextVal = Int(part)!
            if nextVal > val {
                val += 1
                break
            }
            if nextVal < val {
                break
            }
        }

        let substring = Substring(String(val))
        for i in 0..<parts.count {
            parts[i] = substring
        }
        return Int(parts.joined()) ?? Int.max

    }

    public static func findNextInvalidMultiple(current: Int) -> Int {
        guard current >= 11 else { return 11 }

        let len = String(current).count

        var candidates: [Int] = []
        for i in 2...len {
            guard len % i == 0 else { continue }

            let partLen = len / i
            let next = calcNextMatch(val: current, numParts: i, len: partLen)
            candidates.append(next)
        }
        return candidates.min() ?? Int.max
    }

    public static func partOne(data: String) -> Int {
        var sum = 0

        let ranges = data.components(separatedBy: ",")
        for r in ranges {
            let parts = r.components(separatedBy: "-")
            let start = Int(parts[0]) ?? 0
            let finish = Int(parts[1]) ?? 0

            var next = findNextInvalidDouble(current: start)
            while next <= finish {
                sum += next
                next = findNextInvalidDouble(current: next + 1)
            }
        }
        return sum
    }

    public static func partTwo(data: String) -> Int {
        var sum = 0

        let ranges = data.components(separatedBy: ",")
        for r in ranges {
            let parts = r.components(separatedBy: "-")
            let start = Int(parts[0]) ?? 0
            let finish = Int(parts[1]) ?? 0

            var next = findNextInvalidMultiple(current: start)
            while next <= finish {
                sum += next
                next = findNextInvalidMultiple(current: next + 1)
            }
        }
        return sum
    }

    public static func run() -> String {
        let testData = readInput(fileName: "day02test.txt")
        let data = readInput(fileName: "day02.txt")

        let partOneExpected = 1_227_775_554
        let partOneResults = partOne(data: testData)
        if partOneExpected != partOneResults {
            print("Part 1 failed ☝️: \n\tExpected: \(partOneExpected), Results: \(partOneResults)")
            return ("Failed! ❌")
        }

        print("Part 1 ☝️: \(partOne(data: data))")

        let partTwoExpected = 4_174_379_265
        let partTwoResults = partTwo(data: testData)
        if partTwoExpected != partTwoResults {
            print("Part 2 failed ✌️: \n\tExpected: \(partTwoExpected), Results: \(partTwoResults)")
            return ("Failed! ❌")
        }

        print("Part 2 ✌️: \(partTwo(data: data))")

        return ("Completed! 🎉")
    }
}
