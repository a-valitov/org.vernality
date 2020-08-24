import XCTest
@testable import ActivityPresenter

final class ActivityPresenterTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ActivityPresenter().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
