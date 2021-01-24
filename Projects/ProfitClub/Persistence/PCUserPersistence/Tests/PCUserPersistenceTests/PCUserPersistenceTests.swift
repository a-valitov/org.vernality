import XCTest
@testable import PCUserPersistence

final class PCUserPersistenceTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(PCUserPersistence().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
