
![Injection Logo](injection_logo.png)

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Build Status](https://travis-ci.org/JulianAlonso/Injection.svg?branch=master)](https://travis-ci.org/JulianAlonso/Injection)
[![Tuist Badge](https://img.shields.io/badge/powered%20by-Tuist-green.svg?longCache=true)](https://github.com/tuist)

## What's Injection

Injection it's a simple Dependency Injection Library that allow you to define components, modules and resolves the dependencies for you.

All the project it's based in one rule. **Write less**

- [x] Modern Swifty code.
- [x] Allow you define dependencies grouped on `Components`.
- [x] Unique scope, creates a new instance each time you call `resolve` method.
- [x] Singleton scope, shares the same instance along the whole `Module`.
- [x] Weak scope, share the same instance while it's alive, if not, generates a new one.
- [x] Use tags to tag your dependencies if you need to do it.
- [x] Resolves optional types.
- [ ] Circular dependency.
- [ ] Check module dependencies won't crash on runtime.
- [ ] More things to be added...

These examples below will illustrates you a little bit with the most simples (and common) cases:
```swift 
//lets start defining a component for our storage things.
let storageComponent = Component {
    factory { Storage() }
}

//lets create other Component for use cases
let useCasesComponent = Component {
    factory { UseCaseWithStorage(storage: $0()) }
}

//lets create a Module to get our dependencies
let module = Module {
    component { storageComponent }
    component { useCasesComponent }
}

//now you can get your dependencies using:
let useCase: UseCaseWithStorage = module.resolve()
//or
let useCase = module.resolve() as UseCaseWithStorage

```

## Let's make it better.

When we start our app, we must provide to Injection the module we want share along our code, in order to make this, we need to call `injectMe(yourModuleHere)` function with the desired module. 
Also, to be more swiftier we can do this:

```swift
injectMe {
    component { yourComponent }
    factory { YourMagic() }
}
```

You can call `injectMe` and create your module there.

On modern iOS apps, modules starts with a `RootThing`, let's say it's a `ViewController` (or, `Coordinator`, whatever you use in your apps).

**Injection** provides a new component called `ModuleBuilder<T>` where `T` its the `RootThing` that you'll use.
This `ModuleBuilder` has access to the shared module that you have provided by calling `injectMe` previously, also we have the option of extend this module providing a new `Component`.
This component it's here to help you creating the `RootThing`.

Let's see the most simple case in action:
```swift
final class YourScreenModuleBuilder: ModuleBuilder<UIViewController> {
    override func build() -> UIViewController {
        YourScreenViewController(dependency: module.resolve())
    }
}
```

If you need to extend the shared module:
```swift
final class YourScreenModuleBuilder: ModuleBuilder<UIViewController> {
    override func component() -> Component? {
        Component {
            factory { YourCustomDependency() }
        }
    }

    override func build() -> UIViewController {
        YourScreenViewController(dependency: module.resolve(), custom: module.resolve())
    }
}
```

And then, when you need to create the screen:
```swift
//lets say you are pushing this screen:
navigationController.push(YourScreenModuleBuilder().build())
```

This is highly compatible with the [Navigator Pattern](https://jobandtalent.engineering/the-navigator-420b24fc57da) like the people of J&T do because we
can wrap all this VC creation on `Screen extension`

```swift
//We pass from this
extension Screen {
    static func job(id: String) -> Self {
        return .init() { JobViewController(id: id) }
    }
}

//To
extension Screen {
    static func job(id: String) -> Self {
        return .init() { JobModuleBuilder(id: id).build() }
    }
}
```

### Why not Runtime Params?

Runtime params are provided on other Libraries, why this does not provides them?

Runtime parameteres are not provided as is, let my explain.

With usually dynamic parameters case (`module.resolve(parameter: "parameter"`) you lose type-safe, parameter name, order and have a maximum provided by the library. That is not a good option.
Also, if you have a dependency graph of 2 o more leves with runtime params, you will need pass all those params along the whole graph.

eg: 
```swift 

//This is pseudocode

struct A {
    let parameter: String
}

struct B {
    let a: A
}

struct C {
    let b: B
}

//If you need C, you must share the parameter among all dependencies
//C dependends on B that depends on A that have a runtime param so...
container.register() { (parameter: String) in A(parameter: parameter)  }
container.register() { (parameter: String) in B(a: container.resolve(arguments: parameter)) }
container.register() { (parameter: String) in C(b: container.resolve(arguments: parameter)) }

```

This is not type-safe, not named, and you don't know the number of arguments that A needs when you're typing the registration B or C.
The main point is that your "CoreComponents" like in this case these are, is that the should not have dynamic parameters on runtime.

The most used example of this is and HTTPClient with the url provided in runtime maybe you must use an `Environment` object that provides you
the url in runtime. eg:

```swift

let networkComponent = Component {
    factory { HTTClient(url: Environment.current.hostURL) }
}

```

And if you have more than one URL use tagged factories to have different URLs

```swift 
let networkComponent = Component {
    //app usual client
    factory { HTTClient(url: Environment.current.hostURL) }
    //google addresses client
    factory(tag: "address") { HTTClient(url: "googleaddressurl") }
}

```

However if your components still need runtime params then you have the next option.

**ModuleBuilders** to the rescue.

With module builders you have the option to customize the `init` method. This means you can provide **real runtime parameters, named and type-safe**.
Then, you can extend the `Injection` module provided by `injectMe` with custom components and then the magic happens...

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

Its highly recommend that your shared module instances doesn't depends on custom components dependencies because you will need to provide them on all the ModuleBuilders and you can forget it and make a crash on runtime.

Anyway, it's better if your "Core components" doesn't need dynamic parameters on init.

### Testing

Parent module will help you here a lot. You can create a TestingModule overriding your Production module with mock dependencies and have the option to use 
real components and mock components.

Remember, the module resolve chain will try to resolve his own dependencies first then if no instance it's found will call his parent.
This provide to us the ability of override real components with parent dependencies.


### More tips.

- How can I create a singleton?:
```swift
single { YourSingleton() }
```

- How can I create a weak singleton?:
```swift
weak { YourClass() }
```

Note: _This will create a new instance if there's no instance retained on memory. If the last instance created is still alive, then will return that instance. Only for Reference Types_

- The module only can be created with components?:

No, you can create a module with factories, singletons and components, eg:

```swift 
let module = Module {
    component { yourComponent }
    factory { YourInstance() }
    single { YourSingleton() }
}
```

- Do you need two factories with the same type/protocol?

Use tags:

```swift
let module = Module {
    factory { YourMagicService() as MagicService }
    factory(tag: "hisMagicService") { HisMagicService() as MagicService }
}

//then
module.resolve(tag: "hisMagicService")
```

- Do you need create a new Module within other Module?
Yes, you can. You can create a new Module with a parent module simply doing:

```swift
let module = Module(parent: yourParentModule) {
    factory { NewInstance() }
}
```

Remember, all factories are registred to a type/protocol, so, if you write two registrations for the same type, the last will override the first, so take this in mind. 

Please try to have a pyramid dependency graph.

- Do you need to resolve some dependency provided by `injectMe` out from a ModuleBuilder?
You can do it using:

```swift 
let thing: Magic = resolve()
```

**Remember** This will only use the instances provided on `injectMe`


### Overriding and Singleton Instances

Factories are not created until they are provided to a module, so take this in mind.
There is an important note to know when sharing singletons and parent modules.
If you're trying to override a dependency of a singleton inside a module with a parent and the singleton it's inside the parent, this could
not happen because that instance can be created before you override it.
Let see an example to clarify this:

```swift 

let parent = Module {
    factory { OneStorage() as Storage }
    single { Service(storage: $0()) }
}

let child = Module(parent: parent) {
    factory { OtherStorage() as Storage }
}

let service = parent.resolve() as Service
let childService = child.resolve() as Service

```

The storage of childService will be the same as Service because it's a singleton already resolved on the parent.
But if you change the call order then the singleton will be with the `OtherService` storage.
This is a little bit hard to see but it's the normal behaviour.

Take special care about this when testing because if you share a module between all the tests, this can raise.

For this, like you will see on the application test, the module to share its a function that returns the module, so always I get a fresh copy 
of the module and I can override without problems.

**So, keep in mind, TRY TO AVOID OVERRIDE SINGLETON DEPENDENCIES, BECAUSE THE SINGLETON CAN BE ALREADY CREATED WHEN YOU THINK YOU'RE CREATING IT**

### @Inject

You can use `@Inject` property wrapper to auto fill variables with resolved instances on your code.
This will fill those variables with the factories provided by the module where you're resolving the instances.

```swift 

class Bar {}

class Foo {
    @Inject var bar: Bar
}

let module = Module {
    factory { Foo() }
    factory { Bar() }
}

// This will have the bar dependency filled.
let foo = module.resolve() as Foo

```

And you can use this feature also on your ModuleBuilders if you want. These instances will be resolved with the module extendended in your ModuleBuilder.

```swift
final class MagicModuleBuilder: ModuleBuilder<UIViewController> {

    @Inject var some: Some

    func component() -> Component? {
        Component {
            factory { Some() }
        }
    } 

    override func build() -> UIViewController {
        MagicViewController(some: some)
    }

}
```

**Note** Your custom builded classes inside `build()` method on Module builder won't be filled since them are not resolved by the module. 
So if you want to have resolved properties inside those instances with the module provided, use dependency injection by constructor or set them 
manually afther the creation.

You can reference tagged dependencies with `@Inject` using `@Inject(tag: "yourtag")`

### Property Wrappers

You can use property wrappers to resolve instances provided previously to the shared module by `injectMe`.

`@Inject` will be instanciated on initialization
`@LazyInect` will be instanced by demand

```swift
@Inject service: Service
@LazyInject service: Service

//With tags
@Inject(tag: "tag") service: Service
@LazyInject(tag: "tag") service: Service
```

### Logger

There is a Logger that will print all the operations while reoslving a type.
There are 3 log lines:

`Solving type....` `(.debug)` logged when a `module.resolve()` its called.

`Parent solving type...` `(.debug)` logged when a `module.resolve()` it's getting that dependency from the parent.

`Factory not found...` `(.error)` logged when a factory is not found. This will crash.

By default when is DEBUG the logger level will be `.debug` else will be `.error`. You can change is default value calling `inject(logger: Level)`

## Installation

This is a pre alpha version, so maybe it will change, hope not to much, but the option it's here.

#### Carthage:

Add this line to your Cartfile

```
github "JulianAlonso/Injection" "master"
```

#### Cocoapods:

Add this line to your Podfile

```
pod 'Injection', '~> 0.0'
```

Update your README with the following line if you want to add the badge to your repo.

[![Powered by Injection](https://img.shields.io/badge/powered%20by-INJECTION-blue.svg?longCache=true&style=flat)](https://github.com/JulianAlonso/Injection)

```
[![Powered by Injection](https://img.shields.io/badge/powered%20by-INJECTION-blue.svg?longCache=true&style=flat)](https://github.com/JulianAlonso/Injection)
```

## Want to contribute?

Make sure that have installed [Carthage](https://github.com/Carthage/Carthage) and [Tuist](https://tuist.io/) on your local machine.

Clone the project.

Run on the root project folder `fastlane setup_project`, I should use [Bundler](https://bundler.io/) so I run `bundler exec fastlane setup_project`, if you use _Bundler_ also, run before all `bundle install`

Create your own branch with reference to the issue your solving eg: `XXX_little_description` XXX == issue number, write code and tests, and make a PR, all work will be wellcome.

:rocket:

### Test the code

Tests are under `Injection/Test` folder. 
You can check all'em are passing by running `fastlane test`.

## Want to payme a coffe? :coffee:

This option is not available yet ☹️. But I appreciate it.


#### More info

DSL functions inspired on [Koin](https://insert-koin.io/)

## Author

Developed by: Julian Alonso, find me on Twitter - [@maisterjuli](https://twitter.com/MaisterJuli)