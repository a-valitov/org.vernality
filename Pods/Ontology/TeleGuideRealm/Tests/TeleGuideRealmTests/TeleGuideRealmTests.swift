import XCTest
@testable import TeleGuideRealm

final class TeleGuideRealmTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(TeleGuideRealm().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
