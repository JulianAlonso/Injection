import Foundation

public extension Logger {
    enum Level {
        case debug
        case error
    }
}

extension Logger.Level {
    static var `default`: Logger.Level {
        #if DEBUG
            return .debug
        #else
            return .error
        #endif
    }
}

extension Logger.Level {
    private var value: Int {
        switch self {
        case .debug: return 0
        case .error: return 1
        }
    }
}

extension Logger.Level: Comparable {
    public static func < (lhs: Logger.Level, rhs: Logger.Level) -> Bool {
        return lhs.value < rhs.value
    }
}
