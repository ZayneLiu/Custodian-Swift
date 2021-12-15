//
// Created by Zayne on 13/12/2021.
//

import Foundation
import ZIPFoundation
import Kanna

/// Open Document (Text)
public class ODText: File {
	//		text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
	override func index() {
		print("Indexing `.\(ext)` file `\(name)`")

		guard let archive = Archive(url: url, accessMode: .read, preferredEncoding: .utf8)
		else { return }

		var lines: [String] = []
		let namespaces = [
			"text": "urn:oasis:names:tc:opendocument:xmlns:text:1.0",
			"office": "urn:oasis:names:tc:opendocument:xmlns:office:1.0",
		]

		do {
			let documentXML = try archive.extractLong("content.xml")

			if let doc = try? XML(xml: documentXML, encoding: .utf8) {
				for node in doc.xpath("//text:p", namespaces: namespaces) {
					lines.append(node.text!)
				}
			}
		} catch { print(error.localizedDescription) }

		// Read `.docx` file content
		fileContent = lines.joined(separator: "\n")

		let res = StringTokenizer.Tokenize(content: fileContent)
		setThumbnail(data: res)
	}

	override func search(keyword: String) -> SearchResult? {
		let occurrences = thumbnail.keys.contains(keyword) ? thumbnail[keyword]! : []
		// TODO: no match return type, and check
		return SearchResult(file: self, keyword: keyword, occurrences: occurrences)
	}
}
