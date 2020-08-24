import XCTest
@testable import FolderReactor

final class FolderReactorTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(FolderReactor().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
