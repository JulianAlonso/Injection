import Foundation

extension UserDefaults: Storage {
    func set<K, T>(key: K, value: T?) where K: RawRepresentable, K.RawValue == String {
        set(value, forKey: key.rawValue)
    }

    func get<K, T>(key: K) -> T? where K: RawRepresentable, K.RawValue == String {
        return value(forKey: key.rawValue) as? T
    }
}
