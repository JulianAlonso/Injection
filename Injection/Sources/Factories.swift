import Foundation

typealias Factory<T> = (Module) -> T

protocol AnyFactory {
    func build(_ module: Module) -> Any
}

struct InstanceFactory: AnyFactory {
    let _build: (_ module: Module) -> Any

    init<T>(_ factory: @escaping Factory<T>) {
        self._build = { factory($0) }
    }

    func build(_ module: Module) -> Any { _build(module) }
}

final class SingletonFactory: AnyFactory {
    private(set) var built: Any?
    let _build: (_ module: Module) -> Any

    init<T>(_ factory: @escaping Factory<T>) {
        self._build = { factory($0) }
    }

    func build(_ module: Module) -> Any {
        if built == nil { built = _build(module) }
        return built!
    }
}
