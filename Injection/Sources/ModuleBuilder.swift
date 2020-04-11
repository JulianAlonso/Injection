import Foundation

/**
 Component to build your Root objects usually UIViewControllers.

 Override `build()` function to build your Component. You can fill it with the dependnecies available at `module`.

 You can expand the `injectMe` given module with a `Component` overriding the `component() -> Component?` function.

 - `T` is the type of the instance to build

 - note: Yu can access `injectMe` provided module expanded with your component easily calling `module`

 **Example**

 ```swift
 final class ScreenModuleBuilder: ModuleBuilder<UIViewController> {

 private let parameter: String

 init(parameter: String) {
     self.parameter = parameter
 }

 override func component() -> Component? {
     Component {
         factory { YourAwesomeObject(parameter: self.parameter, dependency: $0()) }
     }
 }

 override func build() -> UIViewController {
     ScreenViewController(awesomeObject: module.resolve())
 }

 }
 ```

 */
open class ModuleBuilder<T> {
    public lazy var module: Module = { Injection.module.expand(with: component()) }()

    public init() {}

    open func component() -> Component? { nil }

    open func build() -> T { fatalError("Calling not implemented function build() on \(Self.self)") }
}
