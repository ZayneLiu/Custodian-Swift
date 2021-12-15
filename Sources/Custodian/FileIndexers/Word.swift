//
//  File.swift
//
//
//  Created by Zayne on 09/06/2021.
//

import Foundation
import ZIPFoundation
import Kanna

//
@available(iOS 15.0, *)
@available(macOS 11.0, *)
public class MSWord: File {
	override func index() {
		print("Indexing `.\(ext)` file `\(name)`")

		guard let archive = Archive(url: url, accessMode: .read, preferredEncoding: .utf8)
		else { return }

		var lines: [String] = []
		let namespaces = [
			"o": "urn:schemas-microsoft-com:office:office",
			"w": "http://schemas.openxmlformats.org/wordprocessingml/2006/main",
		]

		do {
			let documentXML = try archive.extractLong("word/document.xml")

			if let doc = try? XML(xml: documentXML, encoding: .utf8) {
				for node in doc.xpath("//w:p", namespaces: namespaces) { lines.append(node.text!) }
			}
		} catch {
			print(error.localizedDescription)
		}

		// Read `.docx` file content
		fileContent = lines.joined(separator: "\n")

		let res = StringTokenizer.Tokenize(content: fileContent)
		setThumbnail(data: res)
	}
}
