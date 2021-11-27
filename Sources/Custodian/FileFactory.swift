//
//  FileFactory.swift
//
//
//  Created by Zayne on 11/06/2021.
//

import Foundation

@available(iOS 12.0, *)
@available(macOS 10.15, *)
class FileFactory {
    private init() {
    }

    static let allowedExt = ["txt", "md"]

    static func createFile(url: URL, folderUrl: URL) -> File? {
        let fileExt = url.pathExtension.lowercased()
        if allowedExt.contains(fileExt) {
            switch fileExt {
                case "txt":
                    return TextFile(url: url, containingFolderUrl: folderUrl)
                case "md":
                    return MarkdownFile(url: url, containingFolderUrl: folderUrl)
                default:
                    break
            }
        }
        return nil
    }
}
