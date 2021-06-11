//
//  File.swift
//
//
//  Created by Zayne on 09/06/2021.
//

import Foundation

class Folder: Indexable {
	var lines: [String] = []
	var name: String = ""
	var url: URL
	var files: [File] = []
	/// which word appeared in which file
	var thumbnail: [String: [File]] = [:]

	init(url: URL) {
		self.url = url
		name = url.lastPathComponent
	}
}

extension Folder {
	@available(macOS 10.14, *)
	func index() throws {
		let fileManager = FileManager.default

		let enumerator = fileManager.enumerator(atPath: url.path)!

		for case let item as String in enumerator {
			let fileUrl = url.appendingPathComponent(item)

			// Skip directories and hidden files, `.xxx`
			if !fileUrl.hasDirectoryPath,
			   !fileUrl.lastPathComponent.starts(with: ["."])
			{
				#warning("call factory")
				files.append(File(url: fileUrl, containingFolder: self))
			}
		}
	}
}
