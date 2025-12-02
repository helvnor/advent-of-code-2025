import Foundation

public struct Day01 {
    public static func readInput(fileName: String) -> String {
        do {
            let fileContents = try String(
                contentsOf: URL(fileURLWithPath: "./Data/\(fileName)"), encoding: .utf8)
            return fileContents
        } catch {
            print("Error reading file \(fileName): \(error)")
            return ""
        }
    }

    public static func partOne(data: String) -> Int {
        let lines = data.components(separatedBy: .newlines)
        var dial = 50
        var counter = 0

        for line in lines {
            let val = Int(line.dropFirst()) ?? 0
            if line.first == "L" {
                dial = dial - val
            } else {
                dial = dial + val
            }

            dial = dial % 100
            if dial == 0 {
                counter += 1
            }
        }
        return counter
    }

    public static func partTwo(data: String) -> Int {
        let lines = data.components(separatedBy: .newlines)
        var dial = 50
        var counter = 0

        for line in lines {
            var val = Int(line.dropFirst()) ?? 0

            if val > 100 {
                counter += val / 100
                val = val % 100
            }

            let prevDial = dial

            if line.first == "L" {
                dial = dial - val
            } else {
                dial = dial + val
            }

            if prevDial != 0 && dial >= 100 {
                counter += 1
            }
            if prevDial != 0 && dial <= 0 {
                counter += 1
            }

            dial = ((dial % 100) + 100) % 100
        }

        return counter
    }

    public static func run() -> String {
        let testData = readInput(fileName: "day01test.txt")
        let data = readInput(fileName: "day01.txt")

        let partOneExpected = 3
        let partOneResults = partOne(data: testData)
        if partOneExpected != partOneResults {
            print("Part 1 failed ☝️: \n\tExpected: \(partOneExpected), Results: \(partOneResults)")
            return ("Failed! ❌")
        }

        print("Part 1 ☝️: \(partOne(data: data))")

        let partTwoExpected = 6
        let partTwoResults = partTwo(data: testData)
        if partTwoExpected != partTwoResults {
            print("Part 2 failed ✌️: \n\tExpected: \(partTwoExpected), Results: \(partTwoResults)")
            return ("Failed! ❌")
        }

        print("Part 2 ✌️: \(partTwo(data: data))")

        return ("Completed! 🎉")
    }
}
