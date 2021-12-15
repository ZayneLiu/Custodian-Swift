//
// Created by Zayne on 15/12/2021.
//

import Foundation
import ZIPFoundation

extension Archive {
	// for some reason the archive was retrieved in multiple parts,
	// assuming it is due to the content length
	func extractLong(_ contentPath: String) throws -> String {
		var list: [String] = []
		let _ = try self.extract(self[contentPath]!) { data in
			list.append(String(decoding: data, as: UTF8.self))
		}
		return list.joined(separator: "")
	}
}

