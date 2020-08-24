import XCTest
@testable import Channels

final class ChannelsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Channels().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
