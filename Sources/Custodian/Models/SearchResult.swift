//
//  File.swift
//
//
//  Created by Zayne on 09/06/2021.
//

import Foundation

class SearchResult {
	var file: File
	var keyword: String
	var occurances: [Range<String.Index>]
	/// A dictionary of each word and its occurances in a specific file.

	/// All lines in current file.
//	var lines: [String] = []

	init(file: File, keyword: String, occurances: [Range<String.Index>]) {
		self.file = file
		self.keyword = keyword
		self.occurances = occurances
//		name = self.url.lastPathComponent
//		type = FileType.Text
//		ext = url.pathExtension
	}
}
