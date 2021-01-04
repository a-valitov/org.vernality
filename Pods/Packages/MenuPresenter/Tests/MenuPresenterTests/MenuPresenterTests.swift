import XCTest
@testable import MenuPresenter

final class MenuPresenterTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(MenuPresenter().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
