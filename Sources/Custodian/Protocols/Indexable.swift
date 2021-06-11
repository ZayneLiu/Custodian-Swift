//
//  File.swift
//
//
//  Created by Zayne on 09/06/2021.
//

import Foundation

protocol Indexable {
	var thumbnail: [String: Int] { get set }

	@available(macOS 10.14, *)
	func index() throws
}
