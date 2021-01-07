import XCTest
@testable import PCSupplierService

final class PCSupplierServiceTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(PCSupplierService().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
