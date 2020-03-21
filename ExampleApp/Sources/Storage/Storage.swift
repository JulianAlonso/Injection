import Foundation

protocol Storage {
    func set<K, T>(key: K, value: T?) where K: RawRepresentable, K.RawValue == String
    func get<K, T>(key: K) -> T? where K: RawRepresentable, K.RawValue == String
}
