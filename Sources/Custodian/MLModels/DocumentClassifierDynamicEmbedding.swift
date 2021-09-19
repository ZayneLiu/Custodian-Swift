//
// DocumentClassifierDynamicEmbedding.swift
//
// This file was automatically generated and should not be edited.
//

import CoreML

/// Model Prediction Input Type
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
class DocumentClassifierDynamicEmbeddingInput: MLFeatureProvider {
	/// Input text as string value
	var text: String

	var featureNames: Set<String> {
		["text"]
	}

	func featureValue(for featureName: String) -> MLFeatureValue? {
		if featureName == "text" {
			return MLFeatureValue(string: text)
		}
		return nil
	}

	init(text: String) {
		self.text = text
	}
}

/// Model Prediction Output Type
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
class DocumentClassifierDynamicEmbeddingOutput: MLFeatureProvider {
	/// Source provided by CoreML

	private let provider: MLFeatureProvider

	/// Text label as string value
	lazy var label: String = {
		[unowned self] in self.provider.featureValue(for: "label")!.stringValue
	}()

	var featureNames: Set<String> {
		provider.featureNames
	}

	func featureValue(for featureName: String) -> MLFeatureValue? {
		provider.featureValue(for: featureName)
	}

	init(label: String) {
		provider = try! MLDictionaryFeatureProvider(dictionary: ["label": MLFeatureValue(string: label)])
	}

	init(features: MLFeatureProvider) {
		provider = features
	}
}

/// Class for model loading and prediction
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
class DocumentClassifierDynamicEmbedding {
	let model: MLModel

	/// URL of model assuming it was installed in the same bundle as this class
	class var urlOfModelInThisBundle: URL {
		return Bundle.module.url(forResource: "DocumentClassifierDynamicEmbedding", withExtension: "mlmodelc")!
	}

	/**
	     Construct DocumentClassifierDynamicEmbedding instance with an existing MLModel object.

	     Usually the application does not use this initializer unless it makes a subclass of DocumentClassifierDynamicEmbedding.
	     Such application may want to use `MLModel(contentsOfURL:configuration:)` and `DocumentClassifierDynamicEmbedding.urlOfModelInThisBundle` to create a MLModel object to pass-in.

	     - parameters:
	       - model: MLModel object
	 */
	init(model: MLModel) {
		self.model = model
	}

	/**
	     Construct DocumentClassifierDynamicEmbedding instance by automatically loading the model from the app's bundle.
	 */
	@available(*, deprecated, message: "Use init(configuration:) instead and handle errors appropriately.")
	convenience init() {
		try! self.init(contentsOf: type(of: self).urlOfModelInThisBundle)
	}

	/**
	     Construct a model with configuration

	     - parameters:
	        - configuration: the desired model configuration

	     - throws: an NSError object that describes the problem
	 */
	convenience init(configuration: MLModelConfiguration) throws {
		try self.init(contentsOf: type(of: self).urlOfModelInThisBundle, configuration: configuration)
	}

	/**
	     Construct DocumentClassifierDynamicEmbedding instance with explicit path to mlmodelc file
	     - parameters:
	        - modelURL: the file url of the model

	     - throws: an NSError object that describes the problem
	 */
	convenience init(contentsOf modelURL: URL) throws {
		try self.init(model: MLModel(contentsOf: modelURL))
	}

	/**
	     Construct a model with URL of the .mlmodelc directory and configuration

	     - parameters:
	        - modelURL: the file url of the model
	        - configuration: the desired model configuration

	     - throws: an NSError object that describes the problem
	 */
	convenience init(contentsOf modelURL: URL, configuration: MLModelConfiguration) throws {
		try self.init(model: MLModel(contentsOf: modelURL, configuration: configuration))
	}

	/**
	     Construct DocumentClassifierDynamicEmbedding instance asynchronously with optional configuration.

	     Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

	     - parameters:
	       - configuration: the desired model configuration
	       - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
	 */
	@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
	class func load(configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<DocumentClassifierDynamicEmbedding, Error>) -> Void) {
		load(contentsOf: urlOfModelInThisBundle, configuration: configuration, completionHandler: handler)
	}

	/**
	     Construct DocumentClassifierDynamicEmbedding instance asynchronously with URL of the .mlmodelc directory with optional configuration.

	     Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

	     - parameters:
	       - modelURL: the URL to the model
	       - configuration: the desired model configuration
	       - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
	 */
	@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
	class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<DocumentClassifierDynamicEmbedding, Error>) -> Void) {
		MLModel.__loadContents(of: modelURL, configuration: configuration) { model, error in
			if let error = error {
				handler(.failure(error))
			} else if let model = model {
				handler(.success(DocumentClassifierDynamicEmbedding(model: model)))
			} else {
				fatalError("SPI failure: -[MLModel loadContentsOfURL:configuration::completionHandler:] vends nil for both model and error.")
			}
		}
	}

	/**
	     Make a prediction using the structured interface

	     - parameters:
	        - input: the input to the prediction as DocumentClassifierDynamicEmbeddingInput

	     - throws: an NSError object that describes the problem

	     - returns: the result of the prediction as DocumentClassifierDynamicEmbeddingOutput
	 */
	func prediction(input: DocumentClassifierDynamicEmbeddingInput) throws -> DocumentClassifierDynamicEmbeddingOutput {
		try prediction(input: input, options: MLPredictionOptions())
	}

	/**
	     Make a prediction using the structured interface

	     - parameters:
	        - input: the input to the prediction as DocumentClassifierDynamicEmbeddingInput
	        - options: prediction options

	     - throws: an NSError object that describes the problem

	     - returns: the result of the prediction as DocumentClassifierDynamicEmbeddingOutput
	 */
	func prediction(input: DocumentClassifierDynamicEmbeddingInput, options: MLPredictionOptions) throws -> DocumentClassifierDynamicEmbeddingOutput {
		let outFeatures = try model.prediction(from: input, options: options)
		return DocumentClassifierDynamicEmbeddingOutput(features: outFeatures)
	}

	/**
	     Make a prediction using the convenience interface

	     - parameters:
	         - text: Input text as string value

	     - throws: an NSError object that describes the problem

	     - returns: the result of the prediction as DocumentClassifierDynamicEmbeddingOutput
	 */
	func prediction(text: String) throws -> DocumentClassifierDynamicEmbeddingOutput {
		let input_ = DocumentClassifierDynamicEmbeddingInput(text: text)
		return try prediction(input: input_)
	}

	/**
	     Make a batch prediction using the structured interface

	     - parameters:
	        - inputs: the inputs to the prediction as [DocumentClassifierDynamicEmbeddingInput]
	        - options: prediction options

	     - throws: an NSError object that describes the problem

	     - returns: the result of the prediction as [DocumentClassifierDynamicEmbeddingOutput]
	 */
	func predictions(inputs: [DocumentClassifierDynamicEmbeddingInput], options: MLPredictionOptions = MLPredictionOptions()) throws -> [DocumentClassifierDynamicEmbeddingOutput] {
		let batchIn = MLArrayBatchProvider(array: inputs)
		let batchOut = try model.predictions(from: batchIn, options: options)
		var results: [DocumentClassifierDynamicEmbeddingOutput] = []
		results.reserveCapacity(inputs.count)
		for i in 0 ..< batchOut.count {
			let outProvider = batchOut.features(at: i)
			let result = DocumentClassifierDynamicEmbeddingOutput(features: outProvider)
			results.append(result)
		}
		return results
	}
}
