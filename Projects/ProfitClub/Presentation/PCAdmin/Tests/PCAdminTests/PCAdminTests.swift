import XCTest
@testable import PCAdmin

final class PCAdminTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(PCAdmin().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
