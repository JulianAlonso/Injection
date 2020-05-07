import ProjectDescription

public extension TargetDependency {
    static let injection: TargetDependency = .package(product: "Injection")
    static let nimble: TargetDependency = .package(product: "Nimble")
}

public extension Package {
    static let nimble: Package = .package(url: "https://github.com/Quick/Nimble.git", from: "8.0.0")
    static let injection: Package = .package(path: .relativeToRoot("."))
}
