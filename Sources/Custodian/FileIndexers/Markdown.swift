//
//  MardownFile.swift
//
//
//  Created by Zayne on 04/09/2021.
//

import Foundation
import Ink
import SwiftSoup

@available(iOS 12, *)
@available(macOS 10.15, *)
public class MarkdownFile: File {
    override func index() {
        print("Indexing `.\(ext)` file `\(name)`")

        let originalFileContent = try! String(contentsOfFile: url.path, encoding: String.Encoding.utf8)
        // fileContent = try! String(contentsOfFile: url.path, encoding: String.Encoding.utf8)

        let parser   = MarkdownParser()
        let markdown = parser.parse(originalFileContent)

        do {
            let html          = markdown.html
            let doc: Document = try SwiftSoup.parse(html)

            // print(try doc.text())
            fileContent = try doc.text()
            let res = StringTokenizer.Tokenize(content: fileContent)

            setThumbnail(data: res)
            // return try doc.text()
        } catch Exception.Error(let type, let message) {
            print(message)
        } catch {
            print("error")
        }
    }

    override func search(keyword: String) -> SearchResult? {
        let occurrences = thumbnail.keys.contains(keyword) ? thumbnail[keyword]! : []
        // TODO: no match return type, and check
        return SearchResult(file: self, keyword: keyword, occurrences: occurrences)
    }

    //	override func search(keyword _: String) -> SearchResult {}
}
