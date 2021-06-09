//
//  File.swift
//
//
//  Created by Zayne on 09/06/2021.
//

@testable import Custodian
import XCTest

final class FileTests: XCTestCase {
	func testFields() {
		let url = URL(fileURLWithPath: "~/Workspace/TODO.org")
		let file = File(url: url)

		XCTAssertEqual(file.ext, "org", "get file ext failed")
		XCTAssertEqual(file.name, "TODO.org", "get file name failed")
	}
}
