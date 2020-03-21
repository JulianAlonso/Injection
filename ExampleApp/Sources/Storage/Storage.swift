import Foundation

protocol Storage {
    func set<K, T>(key: K, value: T?) where K: RawRepresentable, K.RawValue == String
    func get<K, T>(key: K) -> T? where K: RawRepresentable, K.RawValue == String
    func get<K, T>(key: K, default: T) -> T where K: RawRepresentable, K.RawValue == String
}

extension Storage {
    func set<K, T>(key: K, value: T?) where K: Identifiable, K.ID == String {
        set(key: Box(key), value: value)
    }

    func get<K, T>(key: K, default value: T) -> T where K: Identifiable, K.ID == String {
        return get(key: Box(key), default: value)
    }
}

private struct Box: RawRepresentable {

    let rawValue: String

    init<T>(_ identifiable: T) where T: Identifiable, T.ID == String {
        self.rawValue = identifiable.id
    }

    init?(rawValue: String) { nil }

}
