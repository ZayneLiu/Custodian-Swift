//
//  File.swift
//
//
//  Created by Zayne on 09/06/2021.
//

@testable import Custodian
import XCTest

final class FolderTests: XCTestCase {
	let url = URL(
		fileURLWithPath: NSString("~/Workspace/MSc/TestDocs/").expandingTildeInPath,
		isDirectory: true
	)

	func testIndexFileCount() {
		let folder = Folder(url: url)
		try! folder.index()

		let expected = 15
		let actual = folder.files.count

		XCTAssertEqual(expected, actual)
	}

	func testIndexFolderThumbnail() {
		let folder = Folder(url: url)

		do {
			try folder.index()
		} catch {
			print(error)
		}

//		var a = Folder.getFolder(url: url).thumbnail

		XCTFail()
	}

	func testFolderSearchFunction() {
		let folder = Folder(url: url)

		do {
			try folder.index()
		} catch {
			print(error)
		}

		let a = folder.search(keyword: "Hamlet")
		print(a[0].occurrences)
	}
}
