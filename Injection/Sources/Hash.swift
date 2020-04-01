import Foundation

struct Hash: Hashable {
    private let type: String
    private let tag: String?

    init<T>(type: T.Type, tag: String?) {
        self.type = "\(type)".unwrappedOptionalType
        self.tag = tag
    }

    func hash(into hasher: inout Hasher) {
        tag.map { hasher.combine($0) }
        hasher.combine(type)
    }
}

private extension String {
    var unwrappedOptionalType: String {
        guard starts(with: "Optional<") else { return self }
        return "\(replacingOccurrences(of: "Optional<", with: "").dropLast())"
    }
}

extension Hash: CustomStringConvertible {
    var description: String { "Hash for \(type) with tag: \(tag ?? "empty")" }
}

extension Hash: CustomDebugStringConvertible {
    var debugDescription: String { description }
}
