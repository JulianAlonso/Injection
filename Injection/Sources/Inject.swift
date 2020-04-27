import Foundation

/// Struct property wrapper to autowire instances by type.
/// - `T` is the type of the instance you want to intject
///
/// - note: This instances will be resolved by the `injectMe` module.
///
/// let service: @Inject<Service>
///
@propertyWrapper
public struct Inject<T> {

    public private(set) var wrappedValue: T

    private let tag: String?

    public init() {
        self.tag = nil
        self.wrappedValue = resolve(tag: tag)
    }

    /// Resolve the T instance using the given tag
    /// - parameter tag: String used to locate your instance
    public init(tag: String) {
        self.tag = tag
        self.wrappedValue = resolve(tag: tag)
    }

}

/// Struct property wrapper to lazy autowire instances by type.
/// - `T` is the type of the instance you want to intject
///
/// - note: This instances will be resolved by the `injectMe` module.
///
/// let service: @LazyInject<Service>
///
@propertyWrapper
public struct LazyInject<T> {

    private var _value: T?
    public var wrappedValue: T {
        mutating get { value() }
    }

    private let tag: String?

    public init() {
        self.tag = nil
    }

    /// Resolve the T instance using the given tag
    /// - parameter tag: String used to locate your instance
    public init(tag: String?) {
        self.tag = tag
    }

    private mutating func value() -> T {
        if _value == nil { _value = resolve(tag: tag) }
        return _value!
    }

}
