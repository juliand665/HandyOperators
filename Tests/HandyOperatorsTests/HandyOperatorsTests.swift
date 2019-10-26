import XCTest
@testable import HandyOperators

final class HandyOperatorsTests: XCTestCase {
    func testExample() {
		let x = 0
		XCTAssertEqual(x <- { $0 += 1 }, 1)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
