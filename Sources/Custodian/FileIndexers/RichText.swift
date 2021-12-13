//
//  RTF.swift
//  
//
//  Created by Zayne on 13/12/2021.
//

import Foundation

public class RichText: File {
	override func index() {
		print("Indexing `.\(ext)` file `\(name)`")

		do {
			let attributedStringWithRtf: NSAttributedString = try NSAttributedString(url: url, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)
			fileContent = attributedStringWithRtf.string
		} catch let error {
			print("Got an error \(error)")
		}

		let res = StringTokenizer.Tokenize(content: fileContent)

		setThumbnail(data: res)
	}

	override func search(keyword: String) -> SearchResult? {
		let occurrences = thumbnail.keys.contains(keyword) ? thumbnail[keyword]! : []
		// TODO: no match return type, and check
		return SearchResult(file: self, keyword: keyword, occurrences: occurrences)
	}
}

