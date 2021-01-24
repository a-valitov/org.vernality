import XCTest
@testable import PCMember

final class PCMemberTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(PCMember().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
