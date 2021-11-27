//
//  File.swift
//
//
//  Created by Zayne on 09/06/2021.
//

// import Foundation

@testable import Custodian
import XCTest

final class MarkdownFileTests: XCTestCase {
	let fileUrl = URL(
			fileURLWithPath: NSString("~/Workspace/MSc/TestDocs/Report Note.md").expandingTildeInPath
	)

	func testIndex() {

		let file = MarkdownFile(url: fileUrl)
		file.index()

		let expected = 3
		let actual   = file.thumbnail["dreadful"]
		// TODO: finish test
		// XCTAssertEqual(actual, expected)
	}

	func testSearch() {
		let file = MarkdownFile(url: fileUrl)
	}
}
