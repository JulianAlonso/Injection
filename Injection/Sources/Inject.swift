import Foundation

protocol InjectedProperty {
    func inject(by module: Module)
}

@propertyWrapper
public final class Inject<T>: InjectedProperty {

    public private(set) var wrappedValue: T {
        get { _value! }
        set { _value = newValue }
    }

    var _value: T?
    private let tag: String?

    public init() {
        self.tag = nil
    }

    public init(tag: String?) {
        self.tag = tag
    }

    func inject(by module: Module) {
        wrappedValue = module.resolve(tag: tag)
    }
}

@discardableResult
func fill<T>(_ object: T, by module: Module) -> T {
    let mirror = Mirror(reflecting: object)

    var superClassMirror = mirror.superclassMirror
    while superClassMirror != nil {
        superClassMirror?.children.forEach { fill($0, module) }
        superClassMirror = superClassMirror?.superclassMirror
    }
    mirror.children.forEach { fill($0, module) }
    return object
}

private func fill(_ child: Mirror.Child, _ module: Module) {
    guard let injectable = child.value as? InjectedProperty else { return }
    return injectable.inject(by: module)
}
