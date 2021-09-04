//
//  File.swift
//
//
//  Created by Zayne on 09/06/2021.
//

import Foundation

@available(iOS 13.0, *)
@available(macOS 10.15, *)
public class Folder {
	private static var folders: [URL: Folder] = [:]

	public var name: String = ""
	public var url: URL
	public var files: [File] = []
	/// which word appeared in which file
	public var thumbnail: [String: [File]] = [:]

	public init(url: URL) {
		self.url = url
		name = url.lastPathComponent
	}
}

@available(iOS 13.0, *)
@available(macOS 10.15, *)
extension Folder: Indexable {
	public func index() throws {
		// iOS specific code to access selected folder
		url.startAccessingSecurityScopedResource()
		let supportedExts = ["txt"]

		let fileManager = FileManager.default
		let enumerator = fileManager.enumerator(atPath: url.path)!

		for case let item as String in enumerator {
			let fileUrl = url.appendingPathComponent(item)

			// Skip directories and hidden files, `.xxx`
			if !fileUrl.hasDirectoryPath,
			   !fileUrl.lastPathComponent.starts(with: ["."]),
			   supportedExts.contains(fileUrl.pathExtension)
			{
				let file = FileFactory.createFile(url: fileUrl, folderUrl: url)
				file.index()

				files.append(file)
			}
		}
		// iOS specific code to access selected folder
		url.stopAccessingSecurityScopedResource()
	}

	public func search(keyword: String) -> [SearchResult] {
		var res: [SearchResult] = []

		files.forEach { file in

			let searchRes = file.search(keyword: keyword.lowercased())
			if !searchRes.occurrences.isEmpty {
				res.append(searchRes)
			}
		}

		return res
	}
}
