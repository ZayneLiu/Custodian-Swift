//
//  File.swift
//
//
//  Created by Zayne on 09/06/2021.
//

import Foundation
import NaturalLanguage
import Kanna
import ZIPFoundation

@available(iOS 15.0, *)
@available(macOS 11.0, *)
public class PowerPoint: File {
	override func index() {
		print("Indexing `.\(ext)` file `\(name)`")

		guard let archive = Archive(url: url, accessMode: .read, preferredEncoding: .utf8)
		else { return }

		var documentXML = ""
		let namespaces = [
			"o": "urn:schemas-microsoft-com:office:office",
			// "w":"http://schemas.openxmlformats.org/wordprocessingml/2006/main",
			"p": "http://schemas.openxmlformats.org/presentationml/2006/main",
			"a": "http://schemas.openxmlformats.org/drawingml/2006/main",
		]

		do {
			var slideCount = 0
			var tmp = try archive.extract(archive["ppt/presentation.xml"]!) { data in

				let presentationXML = String(decoding: data, as: UTF8.self)

				if let doc = try? XML(xml: presentationXML, encoding: .utf8) {
					for node in doc.xpath("//p:sldIdLst//p:sldId", namespaces: namespaces) {
						slideCount += 1
					}
					print("\(slideCount) slides in total.")
				}
			}

			var slideText: [String] = []

			for num in 1...slideCount {
				// Read each slide.xml file in `slides`
				let filename = "ppt/slides/slide\(num).xml"

				let _ = try archive.extract(archive[filename]!) { data in
					let slideXML = String(decoding: data, as: UTF8.self)
					if let doc = try? XML(xml: slideXML, encoding: .utf8) {
						for node in doc.xpath("//a:p", namespaces: namespaces) { slideText.append(node.text!) }
					}
				}
			}

			fileContent = slideText.joined(separator: "\n")

			//			let _ = try archive.extract(archive["ppt/slides/document.xml"]!) { data in
			//				documentXML = String(decoding: data, as: UTF8.self)
			//			}
			//
			//			if let doc = try? XML(xml: documentXML, encoding: .utf8) {
			//
			//				var lines: [String] = []
			//				for node in doc.xpath("//a:p", namespaces: namespaces) {
			//					lines.append(node.text!)
			//				}
			//
			//				// Read `.docx` file content
			//				fileContent = lines.joined(separator: "\n")
			//			}
		} catch {
		}

		// Read `.txt` file content
		// fileContent = try! String(
		// contentsOfFile: url.path,
		// encoding: String.Encoding.utf8
		// )

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
