import XCTest
@testable import PCModel

final class PCModelTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(PCModel().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
