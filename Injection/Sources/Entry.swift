import Foundation

public struct Entry {
    let hash: Hash
    let factory: AnyFactory

    init<T>(type: T.Type, tag: String?, factory: AnyFactory) {
        self.hash = Hash(type: type, tag: tag)
        self.factory = factory
    }
}

extension Entry: Equatable {
    public static func == (lhs: Entry, rhs: Entry) -> Bool {
        lhs.hash == rhs.hash
    }
}

extension Entry: Registration {
    public func entries() -> [Entry] { [self] }
}
