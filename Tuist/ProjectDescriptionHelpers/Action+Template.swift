import ProjectDescription

public extension TargetAction {
    static let swiftformat = TargetAction.pre(path: .relativeToRoot("scripts/swiftformat.sh"), name: "Swift Format")
    static let swiftlint = TargetAction.pre(path: .relativeToRoot("scripts/swiftlint.sh"), name: "Swift lint")
}
