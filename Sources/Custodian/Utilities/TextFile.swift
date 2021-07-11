//
//  File.swift
//
//
//  Created by Zayne on 09/06/2021.
//

import Foundation
import NaturalLanguage

extension File {}

@available(macOS 10.15, *)
class TextFile: File {
	override func index() {
		print("Indexing `.\(ext)` file `\(name)`")
		// Read `.txt` file content
		fileContent = try! String(
			contentsOfFile: url.path,
			encoding: String.Encoding.utf8
		)

		let sentenceTokenizer = NLTokenizer(unit: .sentence)
		sentenceTokenizer.string = fileContent
		// Enumerate every sentence in the file.
		sentenceTokenizer.enumerateTokens(in: fileContent.startIndex ..< fileContent.endIndex) { sentenceIndex, _ in

			let sentence = String(fileContent[sentenceIndex])

			let wordTokenizer = NLTokenizer(unit: .word)
			wordTokenizer.string = sentence
			// Enumerate every word in the sentence.
			wordTokenizer.enumerateTokens(in: sentence.startIndex ..< sentence.endIndex) { wordIndex, _ in
				let word = sentence[wordIndex].lowercased()

				#warning("Highly experimental, ignore words shorter than 2 characters")
				if word.count <= 2 { return true }

				addToThumbnail(s: word, index: sentenceIndex)

				return true
			}
			return true
		}
	}

//	#warning("update folder index")
//			if !wordSet.contains(word) {
//				wordSet.insert(word)
//				// Conataining folder's keywords index
//				if containingFolderUrl != nil {
//					var folder = Folder.getFolder(url: containingFolderUrl!)
//
//					if folder.thumbnail.keys.contains(word) { folder.thumbnail[word]!.append(self) }
//				}
//			}

	override func search(keyword: String) -> SearchResult {
		let occurrences = thumbnail[keyword]!

		return SearchResult(file: self, keyword: keyword, occurances: occurrences)
	}
}
