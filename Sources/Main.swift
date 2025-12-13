import CoreFoundation

extension Int {
    func pow(_ exponent: Int) -> Int {
        guard exponent >= 0 else { return 0 }
        guard exponent > 0 else { return 1 }

        var result = 1
        var base = self
        var exp = exponent

        while exp > 0 {
            if exp % 2 == 1 {
                result *= base
            }
            base *= base
            exp /= 2
        }

        return result
    }
}

@main
struct AdventOfCode {

    static func main() {
        var startTime = CFAbsoluteTimeGetCurrent()
        var dayRes = Day01.run()
        var endTime = CFAbsoluteTimeGetCurrent()
        print("Day 1 (\(endTime - startTime) seconds):", dayRes)

        startTime = CFAbsoluteTimeGetCurrent()
        dayRes = Day02.run()
        endTime = CFAbsoluteTimeGetCurrent()
        print("Day 2 (\(endTime - startTime) seconds):", dayRes)

        startTime = CFAbsoluteTimeGetCurrent()
        dayRes = Day03.run()
        endTime = CFAbsoluteTimeGetCurrent()
        print("Day 3 (\(endTime - startTime) seconds):", dayRes)

        startTime = CFAbsoluteTimeGetCurrent()
        dayRes = Day04.run()
        endTime = CFAbsoluteTimeGetCurrent()
        print("Day 4 (\(endTime - startTime) seconds):", dayRes)

        startTime = CFAbsoluteTimeGetCurrent()
        dayRes = Day05.run()
        endTime = CFAbsoluteTimeGetCurrent()
        print("Day 5 (\(endTime - startTime) seconds):", dayRes)

        startTime = CFAbsoluteTimeGetCurrent()
        dayRes = Day06.run()
        endTime = CFAbsoluteTimeGetCurrent()
        print("Day 6 (\(endTime - startTime) seconds):", dayRes)

        startTime = CFAbsoluteTimeGetCurrent()
        dayRes = Day07.run()
        endTime = CFAbsoluteTimeGetCurrent()
        print("Day 7 (\(endTime - startTime) seconds):", dayRes)

        startTime = CFAbsoluteTimeGetCurrent()
        dayRes = Day08.run()
        endTime = CFAbsoluteTimeGetCurrent()
        print("Day 8 (\(endTime - startTime) seconds):", dayRes)
    }
}
