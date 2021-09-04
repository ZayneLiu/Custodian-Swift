//
//  File.swift
//
//
//  Created by Zayne on 09/06/2021.
//

import Foundation

@available(macOS 10.15, *)
public class SearchResult {
	public let id = UUID()
	public var file: File
	public var keyword: String
	public var occurrences: [Substring]
	/// A dictionary of each word and its occurances in a specific file.

	/// All lines in current file.

	public init(file: File, keyword: String, occurrences: [Range<String.Index>]) {
		self.file = file
		self.keyword = keyword
		self.occurrences = occurrences.map { index in
			file.fileContent[index]
		}
//		name = self.url.lastPathComponent
//		type = FileType.Text
//		ext = url.pathExtension
	}
}
