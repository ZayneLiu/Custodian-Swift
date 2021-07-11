//
//  File.swift
//
//
//  Created by Zayne on 09/06/2021.
//

import Foundation

@available(macOS 10.15, *)
class Folder: Indexable, ObservableObject {
	private static var folders: [URL: Folder] = [:]

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

// @available(macOS 10.15, *)
// extension Folder {
//	static var getFolders: [Int: Folder] {
//		get { folders }
//		set { folders = newValue }
//	}
//
//	/// - Parameter key: Folder URL.
//	/// - Parameter value: Updated Folder instance.
//	static func updateFolders(url: URL, folder: Folder) {
//		var _folders = getFolders
//		_folders[url.hashValue] = folder
//	}
// }

@available(macOS 10.15, *)
extension Folder {
	func index() throws {
		let fileManager = FileManager.default
		let enumerator = fileManager.enumerator(atPath: url.path)!
		for case let item as String in enumerator {
			let fileUrl = url.appendingPathComponent(item)

			// Skip directories and hidden files, `.xxx`
			if !fileUrl.hasDirectoryPath,
			   !fileUrl.lastPathComponent.starts(with: ["."])
			{
				let file = FileFactory.createFile(url: fileUrl, folderUrl: url)
				file.index()

				files.append(file)
			}
		}
	}
}

//		Folder.getFolders.updateValue(self, forKey: url.hashValue)

//	static func getFolder(url: URL) -> Folder {
//		print(url.hashValue)
//		var a = folders
//		return folders[url.hashValue]!
//	}
