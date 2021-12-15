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
public class MSPowerPoint: File {
	override func index() {
		print("Indexing `.\(ext)` file `\(name)`")

		guard let archive = Archive(url: url, accessMode: .read, preferredEncoding: .utf8)
		else { return }

		var slideText: [String] = []
		let namespaces = [
			"o": "urn:schemas-microsoft-com:office:office",
			"p": "http://schemas.openxmlformats.org/presentationml/2006/main",
			"a": "http://schemas.openxmlformats.org/drawingml/2006/main",
		]

		do {
			var slideCount = 0
			let presentationXML = try archive.extractLong("ppt/presentation.xml")

			if let doc = try? XML(xml: presentationXML, encoding: .utf8) {
				for _ in doc.xpath("//p:sldIdLst//p:sldId", namespaces: namespaces) {
					slideCount += 1
				}
				print("\(slideCount) slides in total.")
			}

			for num in 1...slideCount {
				// Read each slide.xml file in `slides`
				let filename = "ppt/slides/slide\(num).xml"

				let slideXML = try archive.extractLong(filename)
				if let doc = try? XML(xml: slideXML, encoding: .utf8) {
					for node in doc.xpath("//a:p", namespaces: namespaces) { slideText.append(node.text!) }
				}
			}
		} catch {
		}

		fileContent = slideText.joined(separator: "\n")

		let res = StringTokenizer.Tokenize(content: fileContent)
		setThumbnail(data: res)
	}
}
