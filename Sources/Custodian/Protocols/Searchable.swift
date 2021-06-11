//
//  File.swift
//
//
//  Created by Zayne on 09/06/2021.
//

import Foundation

protocol Searchable {
//	var thumbnail: [String: Int] { get set }
//	var lines: [String] { get set }


	func search(keyword:String)->[String:Any]
	func deepSearch(keyword:String)->[String:Any]
}
