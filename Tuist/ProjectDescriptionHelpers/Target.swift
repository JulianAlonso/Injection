import ProjectDescription

extension DeploymentTarget {
    public static let defaultDeployment: DeploymentTarget = .iOS(targetVersion: "11.0", devices: [.iphone, .ipad])
}
