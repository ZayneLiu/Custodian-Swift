//
//  Protocols.swift
//
//
//  Created by Zayne on 12/08/2021.
//

import Foundation

@available(macOS 10.14, *)
protocol Indexable {
	func index() throws
}

@available(macOS 10.15, *)
protocol Searchable {
	//	var thumbnail: [String: Int] { get set }
	//	var lines: [String] { get set }

	func search(keyword: String) -> SearchResult?
}
