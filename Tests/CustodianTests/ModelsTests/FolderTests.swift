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

	// func testIndexFileCount() {
	//	let folder = Folder(url: url)
	//	try! folder.index()
	//
	//	// work out the number of files automatically
	//	var expected = 0
	//	for case let file as String in FileManager.default.enumerator(atPath: url.path)! {
	//		let fileUrl = url.appendingPathComponent(file)
	//		if !fileUrl.hasDirectoryPath,
	//		   !fileUrl.lastPathComponent.starts(with: ["."]) { expected += 1 }
	//	}
	//
	//	let actual = folder.files.count
	//
	//	XCTAssertEqual(expected, actual)
	// }

	func testIndexSupportedFileTypes() {
		let folder = Folder(url: url)
		try! folder.index()
		var expected = 0

		for case let file as String in FileManager.default.enumerator(atPath: url.path)! {
			let fileUrl = url.appendingPathComponent(file)
			if FileFactory.allowedExt.contains(fileUrl.pathExtension.lowercased())
			{ expected += 1 }
		}

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

		// var a = Folder.getFolder(url: url).thumbnail
		// TODO: implement folder level thumbnail.

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
		print("hits:", a[0].occurrences.count)
	}
}
