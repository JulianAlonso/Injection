import Foundation

/// Container with the provided dependencies
public final class Module {
    let parent: Module?
    let factories: [Hash: AnyFactory]

    private convenience init(parent: Module?, entries: [Entry]) {
        self.init(parent: parent, factories: entries.factories)
    }

    private init(parent: Module?, factories: [Hash: AnyFactory]) {
        self.parent = parent
        self.factories = factories
    }

    public func callAsFunction<T>(tag: String? = nil) -> T { resolve(tag: tag) }

    /// Return an instance created with the previously provided factory attached to that Type and Tag
    public func resolve<T>(tag: String? = nil) -> T {
        let hash = Hash(type: T.self, tag: tag)
        Logger.log(message: "Solving type \(hash): \(T.self)")
        return factories[hash]?.build(self) as? T
            ?? parent!.resolve(hash, child: self)
    }

    /// Resolves the dependency using the child to resolve factory dependencies
    private func resolve<T>(_ hash: Hash, child: Module) -> T {
        Logger.log(message: "Parent solving \(hash): \(T.self)")
        return factories[hash]?.build(child) as? T
            ?? parent?.resolve(hash, child: child)
            ?? fail(hash)
    }

    private func fail<T>(_ hash: Hash) -> T {
        Logger.log(level: .error, message: "Factory not found: \(hash): \(T.self)")
        fatalError("Factory not found: \(hash): \(T.self)")
    }
}

public extension Module {
    convenience init(parent: Module? = nil, @ModuleBuilder builder: () -> [Entry]) {
        self.init(parent: parent, entries: builder())
    }

    @_functionBuilder
    enum ModuleBuilder {
        public static func buildBlock(_ registrations: Registration...) -> [Entry] { registrations.flatMap { $0.entries() } }
    }
}

public extension Module {
    convenience init(parent: Module? = nil, @SingleModuleBuilder builder: () -> Registration) {
        self.init(parent: parent, entries: builder().entries())
    }

    @_functionBuilder
    enum SingleModuleBuilder {
        public static func buildBlock(_ registration: Registration) -> Registration { registration }
    }
}

extension Module {
    /// Creates a new module with the given component
    /// The create module will have previous factories among the new ones. If a conflict
    /// it's found current factories will be overriden by the component
    func expand(with component: Component?) -> Module {
        guard let _component = component else { return self }
        return Module(parent: nil, factories: factories.merging(_component.entries().factories, uniquingKeysWith: { _, b in b }))
    }
}

private extension Array where Element == Entry {
    var factories: [Hash: AnyFactory] { reduce(into: [Hash: AnyFactory]()) { $0[$1.hash] = $1.factory() } }
}
