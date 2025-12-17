import Foundation

public struct Day09 {
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

        var coords: [(x: Int, y: Int)] = []

        for line in lines {
            let vals = line.split(separator: ",")

            let x = Int(vals[0])!
            let y = Int(vals[1])!

            coords.append((x: x, y: y))
        }

        var biggest = 0
        for a in coords {
            for b in coords {
                let h = abs(a.y - b.y) + 1
                let w = abs(a.x - b.x) + 1

                let sum = h * w
                if sum > biggest {
                    biggest = sum
                }

            }
        }

        return biggest
    }

    public static func partTwo(data: String) -> Int {
        let lines = data.split(separator: "\n")

        var coords: [(x: Int, y: Int)] = []
        var xComp: [Int] = []
        var yComp: [Int] = []

        for line in lines {
            let vals = line.split(separator: ",")

            let x = Int(vals[0])!
            let y = Int(vals[1])!

            coords.append((x: x, y: y))
        }

        var shift: Int = 0
        let xSortedCoords = coords.sorted { $0.x < $1.x }
        for c in xSortedCoords {
            if c.x - shift + 1 == 0 {
                continue
            }
            xComp.append(c.x - shift)
            xComp.append(1)
            shift = c.x + 1

            let newX = xComp.count - 1
            coords = coords.map { $0.x == c.x ? (x: newX, y: $0.y) : ($0) }
        }

        shift = 0
        let ySortedCoords = xSortedCoords.sorted { $0.y < $1.y }
        for c in ySortedCoords {
            if c.y - shift + 1 == 0 {
                continue
            }
            yComp.append(c.y - shift)
            yComp.append(1)
            shift = c.y + 1

            let newY = yComp.count - 1
            coords = coords.map { $0.y == c.y ? (x: $0.x, y: newY) : ($0) }
        }

        var grid = Array(
            repeating: Array(repeating: false, count: xComp.count), count: yComp.count)

        var prev: (x: Int, y: Int) = coords.last!
        for c in coords {
            for x in (min(prev.x, c.x)...max(prev.x, c.x)) {
                grid[c.y][x] = true
            }

            for y in (min(prev.y, c.y)...max(prev.y, c.y)) {
                grid[y][c.x] = true
            }
            prev = c
        }

        let gridCopy = grid
        for y in 1..<grid.count - 1 {
            var paint = false
            var x = 1
            var wallUp = false
            var wallDown = false

            while x < grid[0].count - 1 {
                if !gridCopy[y][x - 1] && gridCopy[y][x] && !gridCopy[y][x + 1] {
                    paint = !paint

                    x += 1

                } else if gridCopy[y][x] {
                    wallDown = gridCopy[y + 1][x]
                    wallUp = gridCopy[y - 1][x]

                    while gridCopy[y][x] {
                        if x >= grid[0].count - 1 {
                            break
                        }
                        x += 1

                    }

                    if wallUp && gridCopy[y - 1][x - 1] == false {
                        paint = !paint
                    } else if wallDown && gridCopy[y + 1][x - 1] == false {
                        paint = !paint
                    }
                } else {
                    if paint {
                        grid[y][x] = true
                    }
                    x += 1
                }
            }
        }

        var biggest = 0
        for a in coords {
            for b in coords {
                var rejected = false
                let minX = min(a.x, b.x)
                let minY = min(a.y, b.y)

                let maxX = max(a.x, b.x)
                let maxY = max(a.y, b.y)

                if !grid[minY][minX] || !grid[minY][maxX] || !grid[maxY][minX] || !grid[maxY][maxX]
                {
                    rejected = true
                    continue
                }

                for x in minX...maxX {
                    if !grid[minY][x] || !grid[maxY][x] {
                        rejected = true
                        break
                    }
                }
                if rejected { continue }
                for y in minY...maxY {
                    if !grid[y][minX] || !grid[y][maxX] {
                        rejected = true
                        break
                    }
                }
                if rejected { continue }

                let xDistance = xComp[minX...maxX].reduce(0, +)
                let yDistance = yComp[minY...maxY].reduce(0, +)
                let area = xDistance * yDistance

                if biggest < area {
                    biggest = area
                }
            }
        }
        return biggest
    }

    public static func run() -> String {
        let testData = readInput(fileName: "day09test.txt")
        let data = readInput(fileName: "day09.txt")

        let partOneExpected = 50
        let partOneResults = partOne(data: testData)
        if partOneExpected != partOneResults {
            print("Part 1 failed ☝️: \n\tExpected: \(partOneExpected), Results: \(partOneResults)")
            return ("Failed! ❌")
        }

        print("Part 1 ☝️: \(partOne(data: data))")

        let partTwoExpected = 24
        let partTwoResults = partTwo(data: testData)
        if partTwoExpected != partTwoResults {
            print("Part 2 failed ✌️: \n\tExpected: \(partTwoExpected), Results: \(partTwoResults)")
            return ("Failed! ❌")
        }

        print("Part 2 ✌️: \(partTwo(data: data))")

        return ("Completed! 🎉")
    }
}
