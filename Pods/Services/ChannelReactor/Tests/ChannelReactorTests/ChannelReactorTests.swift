import XCTest
@testable import ChannelReactor

final class ChannelReactorTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ChannelReactor().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
