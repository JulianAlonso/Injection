import Foundation

/// Sets the logger level.
/// By default it will be `.debug` if DEBUG and `.error` if release.
public func inject(logger level: Logger.Level) {
    Logger.level = level
}

/// Creates the shared module the provided registrations.
public func injectMe(@Module.ModuleBuilder _ builder: () -> [Entry]) {
    Injection.initialize(with: .init(builder: builder))
}

/// Creates the shared module the provided registrations.
public func injectMe(@Module.ModuleBuilder _ builder: () -> Registration) {
    Injection.initialize(with: .init(builder: builder))
}

/// Set the provided module as the shared module
public func injectMe(_ module: Module) {
    Injection.initialize(with: module)
}

/// Resolves the instance by the factory provided on the `injectMe` module
public func resolve<T>(tag: String? = nil) -> T {
    Injection.module.resolve(tag: tag)
}

final class Injection {
    private static let shared: Injection = .init()
    static var module: Module { shared.module }

    private var _module: Module?
    var module: Module { _module ?? notInitialized() }

    static func initialize(with module: Module) {
        guard shared._module == nil else { fatalError("Injection already initialized") }
        shared._module = module
    }

    private func notInitialized() -> Module {
        fatalError("Injection not initialized. Must call initInjection before")
    }
    
    //only test purpose.
    static func reset() {
        shared._module = nil
    }
}
