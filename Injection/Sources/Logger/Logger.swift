import Foundation

public class Logger {

    private static let shared = Logger()

    private let queue = DispatchQueue(label: "com.injection.logger-queue")
    private var level: Level

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
    static var level: Level {
        get { shared.level }
        set { shared.level = newValue }
    }

    static func log(level: Level = .debug, message: String) {
        shared.log(level: level, message: message)
    }
}
