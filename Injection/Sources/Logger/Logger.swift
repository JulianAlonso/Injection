import Foundation

struct Logger {

    private static let shared = Logger()

    private let queue = DispatchQueue(label: "com.injection.logger-queue")
    private let level: Level

    init(_ level: Level = .default) {
        self.level = level
    }

    private func log(level: Level, message: String) {
        queue.async {
            guard level >= self.level else { return }
            print(message)
        }
    }
}

extension Logger {
    static func log(level: Level = .debug, message: String) {
        shared.log(level: level, message: message)
    }
}
