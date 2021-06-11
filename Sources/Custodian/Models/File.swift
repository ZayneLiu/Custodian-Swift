//
//  File.swift
//
//
//  Created by Zayne on 09/06/2021.
//

import Foundation

class File: Equatable, Searchable, Indexable {
	/// File name.
	var name: String
	/// File type, (Aduio / Text).
	var type: FileType
	/// File URL.
	var url: URL
	/// File extension.
	var ext: String
	/// A dictionary of each word and its occurances in a specific file.
	var thumbnail: [String: Int] = [:]
	/// A set of unique words appeared in file.
	var wordSet = Set<String>()
	/// The containing folder of the file, (nested directories are ignored)
	var containingFolder: Folder?

	#warning("strucutral change for index, to include location info")

	static func == (lhs: File, rhs: File) -> Bool {
		lhs.url == rhs.url
	}

	init(url: URL, containingFolder: Folder? = nil) {
		self.containingFolder = containingFolder
		self.url = url
		name = self.url.lastPathComponent
		type = FileType.Text
		ext = url.pathExtension
	}

	/// Add a word to `thumbnail`.
	func addToThumbnail(s: String) {
		#warning("Handle different forms of word")
		// [n, v, adj, adv]
		let key = s.trimmingCharacters(
			in: .whitespaces.union(.punctuationCharacters)
		)
		if thumbnail.keys.contains(key) {
			thumbnail[key] = thumbnail[key]! + 1
		} else {
			thumbnail[key] = 1
		}
	}

	// All things not inplemented

	@available(macOS 10.14, *)
	func index() { print("Not Implemented!!") }

	func search(keyword _: String) -> [String: Any] {
		print("Not Implemented!!")
		return [:]
	}

	func deepSearch(keyword _: String) -> [String: Any] {
		print("Not Implemented!!")
		return [:]
	}
}

enum FileType {
	case Audio
	case Text
}
