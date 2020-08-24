import XCTest
@testable import PhoneView

final class PhoneViewTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(PhoneView().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
