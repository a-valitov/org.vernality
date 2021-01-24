import XCTest
@testable import PCSupplier

final class PCSupplierTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(PCSupplier().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
