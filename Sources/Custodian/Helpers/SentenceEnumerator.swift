//
//  File.swift
//  File
//
//  Created by Zayne on 05/09/2021.
//

import Foundation
import NaturalLanguage

@available(macOS 10.15, *)
@available(iOS 12, *)
class StringTokenizer {
	#warning("Handle different forms of word")
	// [n, v, adj, adv]
	static func Tokenize(content: String) -> [String: [Range<String.Index>]] {
		var res: [String: [Range<String.Index>]] = [:]

		let sentenceTokenizer = NLTokenizer(unit: .sentence)
		sentenceTokenizer.string = content
		// Enumerate every sentence in the file.
		sentenceTokenizer.enumerateTokens(in: content.startIndex ..< content.endIndex) { sentenceIndex, _ in
			let sentence = String(content[sentenceIndex])

			let wordTokenizer = NLTokenizer(unit: .word)
			wordTokenizer.string = sentence
			// Enumerate every word in the sentence.
			wordTokenizer.enumerateTokens(in: sentence.startIndex ..< sentence.endIndex) { wordIndex, _ in
				let word = sentence[wordIndex].lowercased()

				#warning("Highly experimental, ignore words shorter than 2 characters")
				if word.count <= 2 {
					return true
				}

				// strip trailing and leading spaces and punctuation characters.
				let key = word.trimmingCharacters(in: .whitespaces.union(.punctuationCharacters))

				if !res.keys.contains(key) {
					res[key] = []
				}
				res[key]!.append(sentenceIndex)
				return true
			}
			return true
		}

		return res
	}
}
