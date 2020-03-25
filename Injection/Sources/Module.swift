import Foundation

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

    public func resolve<T>(tag: String? = nil) -> T {
        Logger.log(message: "Solving type\(tag.log): \(T.self)")
        return fill(
            factories[Hash(type: T.self, tag: tag)]?.build(self) as? T
            ?? parent!.resolve(tag: tag, child: self),
             by: self)
    }
    
    private func resolve<T>(tag: String?, child: Module) -> T {
        Logger.log(message: "Parent solving type\(tag.log): \(T.self)")
        return factories[Hash(type: T.self, tag: tag)]?.build(child) as? T
            ?? parent?.resolve(tag: tag, child: child)
            ?? fail(tag)
    }

    private func fail<T>(_ tag: String?) -> T {
        Logger.log(level: .error, message: "Factory not found for type\(tag.log): \(T.self)")
        fatalError("Factory not found for type\(tag.log): \(T.self)")
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
    func expand(with component: Component?) -> Module {
        guard let _component = component else { return self }
        return Module(parent: nil, factories: factories.merging(_component.entries().factories, uniquingKeysWith: { _, b in b }))
    }
}

private extension Array where Element == Entry {
    var factories: [Hash: AnyFactory] { reduce(into: [Hash: AnyFactory]()) { $0[$1.hash] = $1.factory() } }
}

private extension Optional where Wrapped == String {
    var log: String {
        map { " \($0)" } ?? ""
    }
}
