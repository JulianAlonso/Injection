import ProjectDescription

public extension TargetDependency {
    static let nimble: TargetDependency = .framework(path: .carthage("Nimble"))
}

extension Path {
    private static let FrameworksRoot = "Carthage/Build/iOS"

    static func carthage(_ name: String) -> Path {
        .relativeToRoot("\(FrameworksRoot)/\(name).framework")
    }
}
