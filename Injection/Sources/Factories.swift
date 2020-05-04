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

final class WeakFactory: AnyFactory {

    private(set) weak var built: AnyObject?
    let _build: (_ module: Module) -> AnyObject

    init<T>(_ factory: @escaping Factory<T>) where T: AnyObject {
        self._build = { factory($0) }
    }

    func build(_ module: Module) -> Any {
        let built = self.built ?? _build(module)
        self.built = built
        return built
    }

}
