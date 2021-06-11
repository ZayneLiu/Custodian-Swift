//
//  File.swift
//
//
//  Created by Zayne on 09/06/2021.
//

import Foundation
import NaturalLanguage

extension File {}

class TextFile: File {
	@available(macOS 10.14, *)
	override func index() {
		// Read `.txt` file content
		let fileContent: String = try! String(
			contentsOfFile: url.path,
			encoding: String.Encoding.utf8
		)

		let wordTokenizer = NLTokenizer(unit: .word)
		wordTokenizer.string = fileContent
		// Enumerate every word in the file.
		wordTokenizer.enumerateTokens(in: fileContent.startIndex ..< fileContent.endIndex) { wordTokenRange, _ in
			let word = fileContent[wordTokenRange].lowercased()

			#warning("Highly experimental")
			if word.count <= 2 { return true }

			addToThumbnail(s: word)

			if !wordSet.contains(word) {
				wordSet.insert(word)

				// Conataining folder's keywords index
				if containingFolder != nil,
				   containingFolder!.thumbnail.keys.contains(word)
				{
					containingFolder!.thumbnail[word]!.append(self)
				}
			}

			return true
		}
	}

	override func search(keyword: String) -> [String: Any] {
		keyword
		return [:]
	}
}
