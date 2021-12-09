//
//  File.swift
//
//
//  Created by Zayne on 09/06/2021.
//

import Foundation
import NaturalLanguage
import ZIPFoundation

//import SwiftyXMLParser

import Kanna

//
@available(iOS 15.0, *)
@available(macOS 11.0, *)
public class Word: File {
	override func index() {
		print("Indexing `.\(ext)` file `\(name)`")

		guard let archive = Archive(url: url, accessMode: .read, preferredEncoding: .utf8)
		else { return }

		var documentXML = ""

		do {
			let _ = try archive.extract(archive["word/document.xml"]!) { data in
				documentXML = String(decoding: data, as: UTF8.self)
			}

			if let doc = try? XML(xml: documentXML, encoding: .utf8) {
				let namespaces = [
					"o": "urn:schemas-microsoft-com:office:office",
					"w": "http://schemas.openxmlformats.org/wordprocessingml/2006/main",
				]

				var lines: [String] = []
				for node in doc.xpath("//w:p", namespaces: namespaces) { lines.append(node.text!) }

				// Read `.docx` file content
				fileContent = lines.joined(separator: "\n")
			}
		} catch {
			print(error.localizedDescription)
		}

		let sentenceTokenizer = NLTokenizer(unit: .sentence)
		sentenceTokenizer.string = fileContent
		// Enumerate every sentence in the file.
		sentenceTokenizer.enumerateTokens(in: fileContent.startIndex..<fileContent.endIndex) { sentenceIndex, _ in

			let sentence = String(fileContent[sentenceIndex])

			let wordTokenizer = NLTokenizer(unit: .word)
			wordTokenizer.string = sentence
			// Enumerate every word in the sentence.
			wordTokenizer.enumerateTokens(in: sentence.startIndex..<sentence.endIndex) { wordIndex, _ in
				let word = sentence[wordIndex].lowercased()

				#warning("Highly experimental, ignore words shorter than 2 characters")
				if word.count <= 2 {
					return true
				}

				addToThumbnail(s: word, index: sentenceIndex)

				return true
			}
			return true
		}
	}

	//
	//	//	#warning("update folder index")
	//	//			if !wordSet.contains(word) {
	//	//				wordSet.insert(word)
	//	//				// Conataining folder's keywords index
	//	//				if containingFolderUrl != nil {
	//	//					var folder = Folder.getFolder(url: containingFolderUrl!)
	//	//
	//	//					if folder.thumbnail.keys.contains(word) { folder.thumbnail[word]!.append(self) }
	//	//				}
	//	//			}
	//
	override func search(keyword: String) -> SearchResult? {
		let occurrences = thumbnail.keys.contains(keyword) ? thumbnail[keyword]! : []
		// TODO: no match return type, and check
		return SearchResult(file: self, keyword: keyword, occurrences: occurrences)
	}
}
