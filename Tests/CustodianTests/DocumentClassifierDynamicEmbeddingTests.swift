import CoreML
@testable import Custodian
import XCTest

@available(macOS 12.0, *)
@available(iOS 13.0, *)
final class DocumentClassifierDynamicEmbeddingTests: XCTestCase {
//	TODO: Load model
//	TODO: make predications

	func testLoading() {
		let model = try? DocumentClassifierDynamicEmbedding(configuration: MLModelConfiguration())
		XCTAssert(model !== nil)
	}

	func testPrediction() {
		let text  = "technology"
		let model = try? DocumentClassifierDynamicEmbedding(configuration: MLModelConfiguration())

		let expected = "tech"
		let actual   = try? model?.prediction(text: text)

		XCTAssert(actual?.label == expected)
	}
}
