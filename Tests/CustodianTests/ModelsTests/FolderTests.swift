//
//  File.swift
//
//
//  Created by Zayne on 09/06/2021.
//

@testable import Custodian
import XCTest

final class FolderTests: XCTestCase {
	func testIndex() {
		let url = URL(
			fileURLWithPath: NSString("~/Workspace/MSc/TestDocs/").expandingTildeInPath,
			isDirectory: true)
		let folder = Folder(url: url)
		
		try! folder.index()
		
		
		let expected = 15
		let actual = folder.files.count

		XCTAssertEqual(expected, actual)
	}
}