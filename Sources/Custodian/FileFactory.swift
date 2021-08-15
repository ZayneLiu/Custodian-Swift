//
//  File.swift
//
//
//  Created by Zayne on 11/06/2021.
//

import Foundation

@available(iOS 12.0, *)
@available(macOS 10.15, *)
class FileFactory {
	private init() {}

	static func createFile(url: URL, folderUrl: URL) -> File {
		if ["txt"].contains(url.pathExtension.lowercased()) {
			return TextFile(url: url, containingFolderUrl: folderUrl)
		}
		return File(url: url, containingFolderUrl: folderUrl)
	}
}
