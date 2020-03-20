import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(name: "InjectionExampleApp",
                      targets: [
                          Target(name: "App",
                                 platform: .iOS,
                                 product: .app,
                                 bundleId: "com.julian.InjectionApp",
                                 deploymentTarget: .iOS(targetVersion: "13.0", devices: .iphone),
                                 infoPlist: "Config/App.plist",
                                 sources: ["Sources/**"],
                                 actions: [.swiftformat, .swiftlint],
                                 dependencies: [.injection]),
                          Target(name: "Tests",
                                 platform: .iOS,
                                 product: .unitTests,
                                 bundleId: "com.devengo.InjectionApp-Tests",
                                 infoPlist: .default,
                                 sources: ["Tests/**"],
                                 dependencies: [.target(name: "App"), .nimble])
                      ])
