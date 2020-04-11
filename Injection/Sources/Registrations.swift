import Foundation

public protocol Registration {
    func entries() -> [Entry]
}

/**
 Creates a new factory to the returning Type of the builder and the given tag if provided.
 Resolves the type dependencies with the attached module

 - parameter tag: Used to name the factory for the given type

 - returns: Registration that will be attached to a Module or Component

 - note: If you use this inside a component it will be copied when attaching it to a Module.
 This means if you share the same component with Single dependencies inside two different modules,
 it will create two Singleton instances, one on each module

 **Example**

 ```swift
 factory(tag: "Handy") { YourClass(dependency: $0()) }
 ```

 */
public func factory<T>(tag: String? = nil, _ builder: @escaping (Module) -> T) -> Registration { Entry(type: T.self, tag: tag, factory: InstanceFactory(builder)) }

/**
 Creates a new factory to the returning Type of the builder and the given tag if provided.
 Factory provided does not have dependencies

 - parameter tag: Used to name the factory for the given type

 - returns: Registration that will be attached to a Module or Component

 - note: If you use this inside a component it will be copied when attaching it to a Module.
 This means if you share the same component with Single dependencies inside two different modules,
 it will create two Singleton instances, one on each module

 **Example**

 ```swift
 factory(tag: "Handy") { YourClass() }
 ```

 */
public func factory<T>(tag: String? = nil, _ builder: @escaping () -> T) -> Registration { Entry(type: T.self, tag: tag, factory: InstanceFactory { _ in builder() }) }

/**
 Creates a new factory to the returning Singleton Type of the builder and the given tag if provided.
 This singleton will be lazy instantiated.
 **The singleton are attached to a module, having different modules you will have different singletons.**
 Resolves the type dependencies with the attached module.

 - parameter tag: Used to name the factory for the given type

 - returns: Registration that will be attached to a Module or Component

 - note: If you use this inside a component it will be copied when attaching it to a Module.
 This means if you share the same component with Single dependencies inside two different modules,
 it will create two Singleton instances, one on each module

 **Example**

 ```swift
 single(tag: "Handy") { YourClass(dependency: $0()) }
 ```

 */
public func single<T>(tag: String? = nil, _ builder: @escaping (Module) -> T) -> Registration { Entry(type: T.self, tag: tag, factory: SingletonFactory(builder)) }

/**
 Creates a new factory to the returning Singleton Type of the builder and the given tag if provided.
 This singleton will be lazy instantiated.
 **The singleton are attached to a module, having different modules you will have different singletons.**

 - parameter tag: Used to name the factory for the given type

 - returns: Registration that will be attached to a Module or Component

 - note: If you use this inside a component it will be copied when attaching it to a Module.
 This means if you share the same component with Single dependencies inside two different modules,
 it will create two Singleton instances, one on each module

 **Example**

 ```swift
 single(tag: "Handy") { YourClass() }
 ```

 */
public func single<T>(tag: String? = nil, _ builder: @escaping () -> T) -> Registration { Entry(type: T.self, tag: tag, factory: SingletonFactory { _ in builder() }) }

/**
 Creates a new Registration with the provided module

 - returns: Registration that will be attached to a Module or Component

 - note: This will crate the factories provided only when attached to a Module.

 - note: You can share componentes between Modules, but the factories will be different factories.

 **Example**

 ```swift
 component { yourAwesomeComponent }
 ```

 */
public func component(_ builder: @escaping () -> Component) -> Registration { builder() }
