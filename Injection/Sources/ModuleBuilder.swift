import Foundation

open class ModuleBuilder<T> {
    public lazy var module: Module = { Injection.module.expand(with: component()) }()

    public init() {}

    open func component() -> Component? { nil }

    open func build() -> T { fatalError("Calling not implemented function build() on \(Self.self)") }
}
