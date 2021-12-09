//
//  File.swift
//
//
//  Created by Zayne on 09/06/2021.
//

import Foundation

@available(iOS 12.0, *)
@available(macOS 10.15, *)
public class TextFile: File {
	override func index() {
		print("Indexing `.\(ext)` file `\(name)`")
		// Read `.txt` file content
		fileContent = try! String(
			contentsOfFile: url.path,
			encoding: String.Encoding.utf8
		)
		let res = StringTokenizer.Tokenize(content: fileContent)

		setThumbnail(data: res)
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
		let occurrences = thumbnail.keys.contains(keyword) ? thumbnail[keyword]! : []
		// TODO: no match return type, and check

		return SearchResult(file: self, keyword: keyword, occurrences: occurrences)
	}
}
