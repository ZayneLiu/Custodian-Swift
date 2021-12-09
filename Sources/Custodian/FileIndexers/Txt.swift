//
//  File.swift
//
//
//  Created by Zayne on 09/06/2021.
//

import Foundation

@available(iOS 12.0, *)
@available(macOS 10.15, *)
public class Txt: File {
	override func index() {
		print("Indexing `.\(ext)` file `\(name)`")
		// Read `.txt` file content
		fileContent = try! String(contentsOfFile: url.path, encoding: String.Encoding.utf8)
		let res = StringTokenizer.Tokenize(content: fileContent)

		setThumbnail(data: res)
	}

	override func search(keyword: String) -> SearchResult {
		let occurrences = thumbnail.keys.contains(keyword) ? thumbnail[keyword]! : []
		// TODO: no match return type, and check

		return SearchResult(file: self, keyword: keyword, occurrences: occurrences)
	}
}
