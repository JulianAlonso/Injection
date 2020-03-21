import Foundation

extension UserDefaults: Storage {
    func set<K, T>(key: K, value: T?) where K: RawRepresentable, K.RawValue == String {
        set(value, forKey: key.rawValue)
    }

    func get<K, T>(key: K) -> T? where K: RawRepresentable, K.RawValue == String {
        value(forKey: key.rawValue) as? T
    }

    func get<K, T>(key: K, default value: T) -> T where K: RawRepresentable, K.RawValue == String {
        get(key: key) ?? value
    }
}
