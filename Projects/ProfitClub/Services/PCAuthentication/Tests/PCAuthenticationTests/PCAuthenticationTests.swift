import XCTest
@testable import PCAuthentication

final class PCAuthenticationTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(PCAuthentication().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
