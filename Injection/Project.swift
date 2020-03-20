import ProjectDescription
import ProjectDescriptionHelpers

private let name = "Injection"

let project = Project(name: name,
                      targets: [
                          Target(name: name,
                                 platform: .iOS,
                                 product: .framework,
                                 bundleId: "com.julian.\(name)",
                                 deploymentTarget: .iOS(targetVersion: "11.0", devices: .iphone),
                                 infoPlist: "Config/Injection.plist",
                                 sources: ["Sources/**"],
                                 actions: [.swiftformat, .swiftlint]),
                          Target(name: "Tests",
                                 platform: .iOS,
                                 product: .unitTests,
                                 bundleId: "com.julian.\(name)Tests",
                                 infoPlist: .default,
                                 sources: "Tests/**",
                                 dependencies: [
                                     .target(name: "\(name)"),
                                     .nimble
                                 ])
                      ])
