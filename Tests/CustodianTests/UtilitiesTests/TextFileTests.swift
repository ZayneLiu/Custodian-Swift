//
//  File.swift
//
//
//  Created by Zayne on 09/06/2021.
//

// import Foundation
@testable import Custodian
import XCTest

final class TextFileTests: XCTestCase {
	#if os(macOS)
		let fileUrl = URL(
			fileURLWithPath: NSString("~/Workspace/MSc/TestDocs/test.txt").expandingTildeInPath
		)
	#else

	#endif

	func testIndex() {
		let file = TextFile(url: fileUrl)
		file.index()
		let expected = 3
		let actual = file.thumbnail["dreadful"]

		XCTAssertEqual(actual, expected)
	}

	func testSearch() {
		let file = TextFile(url: fileUrl)
		file.index()
		XCTFail()
	}
}
