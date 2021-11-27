@testable import Custodian
import XCTest

final class CustodianTests: XCTestCase {
	func testExample() {
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct
		// results.
		//		XCTAssertEqual(Custodian().text, "Hello, World!")
		Custodian().loadModel()
	}
}
