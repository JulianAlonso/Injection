import ProjectDescription

extension String {
    var target: TargetReference { TargetReference(stringLiteral: self) }
    var testableTarget: TestableTarget { TestableTarget(target: target) }
}
