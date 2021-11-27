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

		let fileManager = FileManager.default
		let enumerator = fileManager.enumerator(atPath: url.path)!

		for case let item as String in enumerator {
			let fileUrl = url.appendingPathComponent(item)

			// Skip sub directories
			if !fileUrl.hasDirectoryPath,
			   // Skip hidden files, `.xxx`
			   !fileUrl.lastPathComponent.starts(with: ["."])
			{
				guard let file = FileFactory.indexFile(url: fileUrl, folderUrl: url) else {
					// skip unsupported files
					continue
				}
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

			guard let searchRes = file.search(keyword: keyword.lowercased()) else {
				// TODO: search not implemneted
				print("`\(file.ext)` \tSearch Not Implemented!! Must be overrided.")
				return
			}
			if !searchRes.occurrences.isEmpty {
				res.append(searchRes)
			}
		}

		return res
	}
}
