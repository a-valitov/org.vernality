import XCTest
@testable import TeleGuideModel

final class TeleGuideModelTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(TeleGuideModel().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
