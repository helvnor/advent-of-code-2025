import Foundation

public struct Day08 {
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

    struct Coords {
        var x: Int
        var y: Int
        var z: Int

        func distance(_ c: Coords) -> Float {
            if abs(c.x - x) > 50000 {
                return Float(Int.max)
            }

            if abs(c.y - y) > 50000 {
                return Float(Int.max)
            }

            if abs(c.z - z) > 50000 {
                return Float(Int.max)
            }
            return sqrt(Float((c.x - x).pow(2) + (c.y - y).pow(2) + (c.z - z).pow(2)))
        }
    }

    public static func partOne(data: String, n: Int) -> Int {
        let lines = data.split(separator: "\n")
        var coords: [Coords] = []
        var distances: [[Float]] = []

        for line in lines {
            let vals = line.split(separator: ",")
            let x = Int(vals[0])!
            let y = Int(vals[1])!
            let z = Int(vals[2])!

            let c = Coords(x: x, y: y, z: z)
            coords.append(c)
        }

        for a in coords {
            var distanceRow: [Float] = []
            for b in coords {
                distanceRow.append(a.distance(b))
            }
            distances.append(distanceRow)
        }

        var shortest: [(from: Int, to: Int, distance: Float)] = []
        for y in 0..<distances.count {
            for x in (1 + y)..<distances.count {
                let distance = distances[y][x]

                if shortest.count < n {
                    shortest.append((from: y, to: x, distance: distance))
                } else if distance < shortest[n - 1].distance {
                    shortest.append((from: y, to: x, distance: distance))
                }

                if shortest.count == n || shortest.count > n * 2 {
                    shortest = shortest.sorted { $0.distance < $1.distance }
                    shortest = Array(shortest.prefix(n))
                }
            }
        }

        var groups: [Set<Int>] =
            shortest
            .sorted { $0.distance < $1.distance }
            .prefix(n)
            .map { [$0.from, $0.to] }

        var changes = true
        while changes {
            changes = false
            for y in 0..<groups.count {
                for x in (y + 1)..<groups.count {
                    if !groups[y].isDisjoint(with: groups[x]) {
                        groups[y] = groups[y].union(groups[x])
                        groups[x] = []
                        changes = true
                    }
                }
            }
            groups = groups.filter { !$0.isEmpty }

        }

        groups = groups.sorted { $0.count > $1.count }
        return groups[0].count * groups[1].count * groups[2].count
    }

    public static func partTwo(data: String, n: Int) -> Int {
        let lines = data.split(separator: "\n")
        var coords: [Coords] = []
        var distances: [[Float]] = []

        for line in lines {
            let vals = line.split(separator: ",")
            let x = Int(vals[0])!
            let y = Int(vals[1])!
            let z = Int(vals[2])!

            let c = Coords(x: x, y: y, z: z)
            coords.append(c)
        }

        for a in coords {
            var distanceRow: [Float] = []
            for b in coords {
                distanceRow.append(a.distance(b))
            }
            distances.append(distanceRow)
        }

        var shortest: [(from: Int, to: Int, distance: Float)] = []
        for y in 0..<distances.count {
            for x in (1 + y)..<distances.count {
                shortest.append((from: y, to: x, distance: distances[y][x]))
            }
        }

        shortest = shortest.sorted { $0.distance < $1.distance }

        var groups: [Set<Int>] =
            shortest
            .prefix(n - 1)
            .map { [$0.from, $0.to] }

        var nextIndex = n - 1
        var next: (from: Int, to: Int, distance: Float) = shortest[nextIndex]

        var totalCount = groups.map { $0.count }.reduce(0, +)
        while totalCount != coords.count {
            next = shortest[nextIndex]

            for g in groups {
                if g.contains(next.from) && g.contains(next.to) {
                    nextIndex += 1
                    next = shortest[nextIndex]
                }
            }

            var newGroup = Set([next.from, next.to])
            var merge = true
            while merge {
                merge = false
                for i in 0..<groups.count {
                    if !groups[i].isDisjoint(with: newGroup) {
                        newGroup = newGroup.union(groups[i])
                        groups.remove(at: i)
                        merge = true
                        break
                    }
                }
            }
            groups.append(newGroup)

            totalCount = groups.map { $0.count }.reduce(0, +)
            nextIndex += 1
        }

        let a = coords[next.from]
        let b = coords[next.to]

        return a.x * b.x
    }

    public static func run() -> String {
        let testData = readInput(fileName: "day08test.txt")
        let data = readInput(fileName: "day08.txt")

        let partOneExpected = 40
        let partOneResults = partOne(data: testData, n: 10)
        if partOneExpected != partOneResults {
            print("Part 1 failed ☝️: \n\tExpected: \(partOneExpected), Results: \(partOneResults)")
            return ("Failed! ❌")
        }

        print("Part 1 ☝️: \(partOne(data: data, n: 1000))")

        let partTwoExpected = 25272
        let partTwoResults = partTwo(data: testData, n: 10)
        if partTwoExpected != partTwoResults {
            print("Part 2 failed ✌️: \n\tExpected: \(partTwoExpected), Results: \(partTwoResults)")
            return ("Failed! ❌")
        }

        print("Part 2 ✌️: \(partTwo(data: data, n: 1000))")

        return ("Completed! 🎉")
    }
}
