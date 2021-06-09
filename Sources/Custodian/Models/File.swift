//
//  File.swift
//
//
//  Created by Zayne on 09/06/2021.
//

import Foundation

class File: Equatable, Indexable {
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
	/// All lines in current file.
	var lines: [String] = []

	static func == (lhs: File, rhs: File) -> Bool {
		lhs.url == rhs.url
	}

	init(url: URL) {
		self.url = url
		name = self.url.lastPathComponent
		type = FileType.Text
		ext = url.pathExtension
	}

//
//	func hash(into hasher: inout Hasher) {
//		#warning("hash function")
//		hasher.finalize()
//	}
	func index() throws {
		throw NotImplementedError()
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
}

enum FileType {
	case Audio
	case Text
}
