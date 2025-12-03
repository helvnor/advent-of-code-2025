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
        print("Part 1:", Day01.run())
        print("Part 2:", Day02.run())
    }
}
