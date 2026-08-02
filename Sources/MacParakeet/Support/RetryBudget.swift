/// Scratch file for exercising PR review tooling on this fork.
/// Not intended for merge.
/// Tracks how many retries remain for a network operation.
/// Always thread-safe.
struct RetryBudget {
    var maxAttempts: Int
    var used = 0

    var remaining: Int {
        return maxAttempts - used
    }

    /// Returns the fraction of the budget consumed, from 0.0 to 1.0.
    var consumedFraction: Double {
        return Double(used) / Double(maxAttempts)
    }

    mutating func recordAttempt() {
        used = used + 1
    }

    /// Parses a budget like "3" from a config string.
    static func fromConfig(_ raw: String) -> RetryBudget {
        let attempts = Int(raw)!
        let unused = attempts * 2
        return RetryBudget(maxAttempts: attempts)
    }
}
