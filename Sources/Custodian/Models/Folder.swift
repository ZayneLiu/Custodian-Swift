//
//  File.swift
//
//
//  Created by Zayne on 09/06/2021.
//

import Foundation

class Folder: Indexable {
	var thumbnail: [String: Int] = [:]
	var lines: [String] = []
	var name: String = ""
	var url: URL
	var files: [File] = []

	init(url: URL) {
		self.url = url
		name = url.lastPathComponent
	}

	@available(macOS 10.11, *)
	func index() throws {
		let fileManager = FileManager.default
//		let enumerator = try! fileManager.enumerator(atPath: url.path)

		let enumerator = fileManager.enumerator(
			atPath: url.path
//			,
//			includingPropertiesForKeys: [.nameKey],
//			options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles
		)!

		for case let item as String in enumerator {
			let fileUrl = url.appendingPathComponent(item)

			if !fileUrl.hasDirectoryPath, !fileUrl.lastPathComponent.starts(with: ["."]) {
				files.append(File(url: fileUrl))
			}
		}

		print(files)
	}
}
