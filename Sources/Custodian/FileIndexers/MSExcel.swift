//
//  Created by Zayne on 09/12/2021.
//

import Foundation
import NaturalLanguage
import Kanna
import ZIPFoundation

@available(iOS 15.0, *)
@available(macOS 11.0, *)
public class MSExcel: File {
	//	override func index() {
	//		print("Indexing `.\(ext)` file `\(name)`")
	//
	//		guard let archive = Archive(url: url, accessMode: .read, preferredEncoding: .utf8)
	//		else { return }
	//
	//		do {
	//
	//			let namespaces = [
	//				"o": "urn:schemas-microsoft-com:office:office",
	//				"": "http://schemas.openxmlformats.org/spreadsheetml/2006/main",
	//				"r": "http://schemas.openxmlformats.org/officeDocument/2006/relationships",
	//				"w": "http://schemas.openxmlformats.org/wordprocessingml/2006/main",
	//			]
	//
	//			let workbookXML = try archive.extractLong("xl/workbook.xml")
	//
	//			var count = 0
	//			if let doc = try? XML(xml: workbookXML, encoding: .utf8) {
	//				for node in doc.xpath("//sheets//sheet", namespaces: namespaces) {
	//					count += 1
	//					print(node["name"])
	//				}
	//				print("\(count) slides in total.")
	//			}
	//
	//			//			if let doc = try? XML(xml: spreadsheetXML, encoding: .utf8) {
	//			//
	//			//				var lines: [String] = []
	//			//				for node in doc.xpath("//w:p", namespaces: namespaces) { lines.append(node.text!) }
	//			//
	//			//				// Read `.docx` file content
	//			//				fileContent = lines.joined(separator: "\n")
	//			//			}
	//		} catch {
	//			print(error.localizedDescription)
	//		}
	//
	//		let res = StringTokenizer.Tokenize(content: fileContent)
	//		setThumbnail(data: res)
	//	}
}
