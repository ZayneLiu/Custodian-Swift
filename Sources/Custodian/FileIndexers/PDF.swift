//
// Created by Zayne on 27/11/2021.
//

import Foundation
import PDFKit

@available(iOS 12, *)
@available(macOS 10.15, *)
public class PDF: File {
	override func index() {
		print("Indexing `.\(ext)` file `\(name)`")

		let doc = PDFDocument(url: url)!

		do {
			fileContent = try doc.string!
			let res = StringTokenizer.Tokenize(content: fileContent)

			setThumbnail(data: res)
		} catch {
			print(error.localizedDescription)
		}
	}

	override func search(keyword: String) -> SearchResult? {
		let occurrences = thumbnail.keys.contains(keyword) ? thumbnail[keyword]! : []
		// TODO: no match return type, and check
		return SearchResult(file: self, keyword: keyword, occurrences: occurrences)
	}
}
