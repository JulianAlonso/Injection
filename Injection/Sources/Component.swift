import Foundation

/// Group a bunch of factories.
/// This Compoentn could be used to provide factories to another `Component` or to create a `Module`
///
/// **Example**
///
/// let yourComponent = Component {
///     factory { Service() }
///     single { OneSingleton() }
/// }
///
public struct Component {
    let _entries: [Entry]
}

public extension Component {
    init(@ComponentBuilder builder: () -> [Entry]) {
        self.init(_entries: builder())
    }

    @_functionBuilder
    enum ComponentBuilder {
        public static func buildBlock(_ registrations: Registration...) -> [Entry] { registrations.flatMap { $0.entries() } }
    }
}

public extension Component {
    init(@SingleComponentBuilder builder: () -> Registration) {
        self.init(_entries: builder().entries())
    }

    @_functionBuilder
    enum SingleComponentBuilder {
        public static func buildBlock(_ registration: Registration) -> Registration { registration }
    }
}

extension Component: Registration {
    public func entries() -> [Entry] { _entries }
}
