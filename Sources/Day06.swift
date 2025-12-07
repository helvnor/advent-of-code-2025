import Foundation

public struct Day06 {
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

        var allVals: [[Substring]] = []

        for line in lines {
            let vals = line.split(separator: " ")
            allVals.append(vals)
        }

        var sum = 0
        for colIndex in 0..<allVals[0].count {

            let type = allVals[allVals.count - 1][colIndex]
            var section = Int(allVals[0][colIndex])!

            for rowIndex in 1..<(allVals.count - 1) {
                if type == "*" {
                    section *= Int(allVals[rowIndex][colIndex])!
                }
                if type == "+" {
                    section += Int(allVals[rowIndex][colIndex])!
                }
            }

            sum += section
        }

        return sum
    }

    public static func partTwo(data: String) -> Int {
        let lines = data.split(separator: "\n")

        var chars: [[Character]] = []
        let types = lines[lines.count - 1].split(separator: " ")
        for line in lines.dropLast() {
            chars.append(Array(line))
        }

        var vals: [String] = []
        for colIndex in 0..<chars[0].count {
            var valParts: [Character] = []
            for rowIndex in 0..<chars.count {
                valParts.append(chars[rowIndex][colIndex])
            }
            vals.append(String(valParts))
        }

        var typeIndex = 0
        var sum = 0
        var section = 0
        for val in vals {
            let trimmedVal = val.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmedVal.isEmpty {
                sum += section
                typeIndex += 1
                section = 0
                continue
            }

            if types[typeIndex] == "*" {
                if section == 0 {
                    section = 1
                }
                section *= Int(trimmedVal)!
            }
            if types[typeIndex] == "+" {
                section += Int(trimmedVal)!
            }
        }
        sum += section

        return sum
    }

    public static func run() -> String {
        let testData = readInput(fileName: "day06test.txt")
        let data = readInput(fileName: "day06.txt")

        let partOneExpected = 4_277_556
        let partOneResults = partOne(data: testData)
        if partOneExpected != partOneResults {
            print("Part 1 failed ☝️: \n\tExpected: \(partOneExpected), Results: \(partOneResults)")
            return ("Failed! ❌")
        }

        print("Part 1 ☝️: \(partOne(data: data))")

        let partTwoExpected = 3_263_827
        let partTwoResults = partTwo(data: testData)
        if partTwoExpected != partTwoResults {
            print("Part 2 failed ✌️: \n\tExpected: \(partTwoExpected), Results: \(partTwoResults)")
            return ("Failed! ❌")
        }

        print("Part 2 ✌️: \(partTwo(data: data))")

        return ("Completed! 🎉")
    }
}
