//
//  File.swift
//
//
//  Created by Zayne on 09/06/2021.
//

@testable import Custodian
import XCTest

@available(iOS 15.0, *)
final class FileTests: XCTestCase {
	let folder = Folder(url: URL(fileURLWithPath: "~/Workspace/", isDirectory: true))
	let url    = URL(fileURLWithPath: "~/Workspace/TODO.org")

	func testFields() {
		let file = File(url: url)

		XCTAssertEqual(file.ext, "org", "get file ext failed")
		XCTAssertEqual(file.name, "TODO.org", "get file name failed")
	}
}
