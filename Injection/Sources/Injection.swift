import Foundation

public func injectMe(@Module .ModuleBuilder _ builder: () -> [Entry]) {
    Injection.initialize(with: .init(builder: builder))
}

public func injectMe(@Module .ModuleBuilder _ builder: () -> Registration) {
    Injection.initialize(with: .init(builder: builder))
}

public func injectMe(_ module: Module) {
    Injection.initialize(with: module)
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

    static func reset() {
        shared._module = nil
    }
}
