//
// Created by Zayne on 13/12/2021.
//

import Foundation
import NaturalLanguage
import Kanna
import ZIPFoundation

public class ODPresentation: File {
	override func index() {
		print("Indexing `.\(ext)` file `\(name)`")

		guard let archive = Archive(url: url, accessMode: .read, preferredEncoding: .utf8)
		else { return }

		var slideTexts: [String] = []
		let namespaces = [
			"text": "urn:oasis:names:tc:opendocument:xmlns:text:1.0",
			"office": "urn:oasis:names:tc:opendocument:xmlns:office:1.0",
			"presentation": "urn:oasis:names:tc:opendocument:xmlns:presentation:1.0",
		]

		do {
			let documentXML = try archive.extractLong("content.xml")

			if let doc = try? XML(xml: documentXML, encoding: .utf8) {
				for node in doc.xpath("//text:p", namespaces: namespaces) {
					slideTexts.append(node.text!)
				}
			}
		} catch { print(error.localizedDescription) }

		fileContent = slideTexts.joined(separator: "\n")

		let res = StringTokenizer.Tokenize(content: fileContent)
		setThumbnail(data: res)
	}
}
