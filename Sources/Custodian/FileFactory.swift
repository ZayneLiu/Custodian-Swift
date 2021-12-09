//
//  FileFactory.swift
//
//
//  Created by Zayne on 11/06/2021.
//

import Foundation

@available(iOS 15.0, *)
@available(macOS 11.0, *)
public class FileFactory {
	private init() {}

	static let allowedExt = ["txt", "md", "html", "docx", "pptx", "pdf"]

	static func indexFile(url: URL, folderUrl: URL) -> File? {
		let fileExt = url.pathExtension.lowercased()
		if allowedExt.contains(fileExt) {
			switch fileExt {
				case "txt":
					return Txt(url: url, containingFolderUrl: folderUrl)
				case "md":
					return Markdown(url: url, containingFolderUrl: folderUrl)
				case "html":
					return HTML(url: url, containingFolderUrl: folderUrl)
				case "docx":
					return Word(url: url, containingFolderUrl: folderUrl)
				case "pptx":
					return PowerPoint(url: url, containingFolderUrl: folderUrl)
				case "pdf":
					return PDF(url: url, containingFolderUrl: folderUrl)
				default:
					break
			}
		}
		return nil
	}
}
