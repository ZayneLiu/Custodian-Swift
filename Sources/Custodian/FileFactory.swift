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

	//    static let msDocExt =
	static let allowedExt = [
		"txt", "md", "html", "docx", "docm", "pptx", "pptm", "pdf", "rtf", "odt", "odp",
	]

	//    "xlsx"
	static func indexFile(url: URL, folderUrl: URL) -> File? {
		let fileExt = url.pathExtension.lowercased()
		if allowedExt.contains(fileExt) {
			switch fileExt {
				case "txt":
					return PlainText(url: url, containingFolderUrl: folderUrl)
				case "md":
					return Markdown(url: url, containingFolderUrl: folderUrl)
				case "html":
					return HTML(url: url, containingFolderUrl: folderUrl)
				case "docx", "docm":
					return MSWord(url: url, containingFolderUrl: folderUrl)
				case "pptx", "pptm":
					return MSPowerPoint(url: url, containingFolderUrl: folderUrl)
				case "pdf":
					return PDF(url: url, containingFolderUrl: folderUrl)
				case "rtf":
					return RichText(url: url, containingFolderUrl: folderUrl)
				case "odt":
					return ODText(url: url, containingFolderUrl: folderUrl)
				case "odp":
					return ODPresentation(url: url, containingFolderUrl: folderUrl)
					// case "xlsx":
					//	 return MSExcel(url: url, containingFolderUrl: folderUrl)
				default:
					break
			}
		}
		return nil
	}
}
