//
//  File.swift
//
//
//  Created by Zayne on 09/06/2021.
//

import Foundation
import CoreML

@available(macOS 10.15, *)
public class File: Equatable, Searchable, Indexable {
	/// File name.
	public var name: String
	/// File type, (Aduio / Text).
	public var type: FileType
	/// File URL.
	public var url: URL
	/// File extension.
	public var ext: String
	/// Text Classification [NLP]
	public var textClassification: String = ""
	/// A dictionary of each word and its occurances in a specific file.
	var thumbnail: [String: [Range<String.Index>]] = [:]
	/// A set of unique words appeared in file.
	var wordSet = Set<String>()
	/// The containing folder of the file, (nested directories are ignored)
	var containingFolderUrl: URL?
	/// File content in readable string format
	var fileContent: String = ""

	public static func ==(lhs: File, rhs: File) -> Bool {
		lhs.url == rhs.url
	}

	public init(url: URL, containingFolderUrl: URL? = nil) {
		self.containingFolderUrl = containingFolderUrl
		self.url = url
		name = self.url.lastPathComponent
		#warning("File type")
		type = FileType.Text
		ext = url.pathExtension
	}

	/// Add a word to `thumbnail`.
	func addToThumbnail(s: String, index: Range<String.Index>) {
		let key = s.trimmingCharacters(in: .whitespaces.union(.punctuationCharacters))

		if !thumbnail.keys.contains(key) { thumbnail[key] = [] }
		thumbnail[key]!.append(index)
	}

	func setThumbnail(data: [String: [Range<String.Index>]]) { thumbnail = data }

	/// All things not implemented and to be overwritten
	func index() { print("Not Implemented!!") }

	func classify() {
		let model = try? DocumentClassifierDynamicEmbedding(configuration: MLModelConfiguration())
		textClassification = try! model?.prediction(text: fileContent).label as! String
	}

	/// Default search for all file types
	func search(keyword: String) -> SearchResult? {
		let occurrences = thumbnail.keys.contains(keyword) ? thumbnail[keyword]! : []
		// TODO: no match return type, and check
		return SearchResult(file: self, keyword: keyword, occurrences: occurrences)
	}
}

struct CustodianError: Error {
	enum ErrorType {
		case searchNotImplemented
	}

	let msg: String
	let type: ErrorType
}

public enum FileType: String {
	case Audio
	case PDF
	case Text
	case Office_Word
	case Office_Excel
	case Office_PowerPoint
}
