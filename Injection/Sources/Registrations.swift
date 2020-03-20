import Foundation

public protocol Registration {
    func entries() -> [Entry]
}

public func factory<T>(tag: String? = nil, _ builder: @escaping (Module) -> T) -> Registration { Entry(type: T.self, tag: tag, factory: InstanceFactory(builder)) }
public func factory<T>(tag: String? = nil, _ builder: @escaping () -> T) -> Registration { Entry(type: T.self, tag: tag, factory: InstanceFactory { _ in builder() }) }

public func single<T>(tag: String? = nil, _ builder: @escaping (Module) -> T) -> Registration { Entry(type: T.self, tag: tag, factory: SingletonFactory(builder)) }
public func single<T>(tag: String? = nil, _ builder: @escaping () -> T) -> Registration { Entry(type: T.self, tag: tag, factory: SingletonFactory { _ in builder() }) }

public func component(_ builder: @escaping () -> Component) -> Registration { builder() }
