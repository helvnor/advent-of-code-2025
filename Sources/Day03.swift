import Foundation

public struct Day03 {
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

        var sum = 0
        for line in lines {
            var first = 0
            var firstIndex = 0
            for (index, letter) in Array(line.dropLast()).enumerated() {
                let num = letter.wholeNumberValue ?? 0

                if num > first {
                    first = num
                    firstIndex = index
                }
            }

            var second = 0
            for letter in Array(line.dropFirst(firstIndex + 1)) {
                let num = letter.wholeNumberValue ?? 0

                if num > second {
                    second = num
                }
            }
            sum += 10 * first + second
        }
        return sum

    }

    public static func partTwo(data: String) -> Int {
        let lines = data.split(separator: "\n")
        let len = 11

        var sum = 0
        for line in lines {

            var index = 0
            var biggest = 0
            var lineString = line

            for i in 0...len {
                for (lineIndex, letter) in Array(lineString.dropLast(len - i)).enumerated() {
                    let num = letter.wholeNumberValue!

                    if num > biggest {
                        biggest = num
                        index = lineIndex
                    }

                }
                lineString = lineString.dropFirst(index + 1)
                sum += biggest * Int(10).pow(len - i)
                biggest = 0
            }

        }
        return sum
    }

    public static func run() -> String {
        let testData = readInput(fileName: "day03test.txt")
        let data = readInput(fileName: "day03.txt")

        let partOneExpected = 357
        let partOneResults = partOne(data: testData)
        if partOneExpected != partOneResults {
            print("Part 1 failed ☝️: \n\tExpected: \(partOneExpected), Results: \(partOneResults)")
            return ("Failed! ❌")
        }

        print("Part 1 ☝️: \(partOne(data: data))")

        let partTwoExpected = 3_121_910_778_619
        let partTwoResults = partTwo(data: testData)
        if partTwoExpected != partTwoResults {
            print("Part 2 failed ✌️: \n\tExpected: \(partTwoExpected), Results: \(partTwoResults)")
            return ("Failed! ❌")
        }

        print("Part 2 ✌️: \(partTwo(data: data))")

        return ("Completed! 🎉")
    }
}
