//
//  File.swift
//
//
//  Created by Zayne on 09/06/2021.
//

// import Foundation
@testable import Custodian
import XCTest

final class RichTextFileTests: XCTestCase {
	func testIndex() {
		XCTFail()
		#if os(macOS)
			let fileUrl = URL(
				fileURLWithPath: NSString("~/Workspace/MSc/TestDocs/test.txt").expandingTildeInPath
			)
		#else
			// let fileUrl = URL("")
		#endif

		let file = TextFile(url: fileUrl)
		file.index()
		let expected = 3
		let actual = file.thumbnail["dreadful"]

		XCTAssertEqual(actual, expected)
	}

	func test() {}
}
