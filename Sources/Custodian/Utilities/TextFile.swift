//
//  File.swift
//
//
//  Created by Zayne on 09/06/2021.
//

import Foundation

extension File {}

class TextFile: File {
	override func index() {
		#warning("index")

		let fileContent = try! String(contentsOfFile: url.path, encoding: String.Encoding.utf8)

		// Extract all lines in text file
		lines = fileContent.components(separatedBy: .newlines)

		// Extract every word from each line
		for line in lines {
			let words = line.components(
				separatedBy: .whitespaces.union(CharacterSet([","]))
			)
			words.forEach { word in
				addToThumbnail(s: word)
			}
		}
	}
}
