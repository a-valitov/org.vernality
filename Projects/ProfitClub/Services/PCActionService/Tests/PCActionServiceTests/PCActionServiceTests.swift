import XCTest
@testable import PCActionService

final class PCActionServiceTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(PCActionService().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
