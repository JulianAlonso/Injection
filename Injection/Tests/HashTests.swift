import Foundation
@testable import Injection
import Nimble
import XCTest

final class HashTests: XCTestCase {

    func testHashAreIqualBetweenOptionalAndNotOptional() {
        let hash = Hash(type: A.self, tag: nil)
        let optional = Hash(type: A?.self, tag: nil)

        expect(hash).to(equal(optional))
    }

    func testTwoHashWithDifferentTagsAreDifferent() {
        let tag = Hash(type: A.self, tag: "A")
        let hash = Hash(type: A.self, tag: nil)

        expect(tag).toNot(equal(hash))
    }

}

private struct A {}
