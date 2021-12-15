// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
		name: "Custodian",
        platforms: [
            .iOS(.v14), .macOS(.v11)
        ],
		products: [
			// Products define the executables and libraries a package produces, and make them visible to other packages.
			.library(
					name: "Custodian",
					targets: ["Custodian"]
			),
		],
		dependencies: [
			// Dependencies declare other packages that this package depends on.
			// .package(url: /* package url */, from: "1.0.0"),
			.package(name: "Ink", url: "https://github.com/johnsundell/ink.git", from: "0.5.1"),
			.package(name: "SwiftSoup", url: "https://github.com/scinfu/SwiftSoup.git", from: "2.3.3"),
			.package(name: "ZIPFoundation", url: "https://github.com/weichsel/ZIPFoundation.git", from: "0.9.12"),
            // .package(name: "SwiftyXMLParser", url: "https://github.com/yahoojapan/SwiftyXMLParser.git", from: "5.6.0"),
            .package(name: "Kanna", url: "https://github.com/tid-kijyun/Kanna.git", from: "5.2.2"),

		],
		targets: [
			// Targets are the basic building blocks of a package. A target can define a module or a test suite.
			// Targets can depend on other targets in this package, and on products in packages this package depends on.
			.target(
					name: "Custodian",
					dependencies: [
						.product(name: "Ink", package: "Ink"),
						.product(name: "SwiftSoup", package: "SwiftSoup"),
						.product(name: "ZIPFoundation", package: "ZIPFoundation"),
                        // .product(name: "SwiftyXMLParser", package: "SwiftyXMLParser")
                        .product(name: "Kanna", package: "Kanna")
					],
					resources: [
						.copy("MLModels/DocumentClassifierDynamicEmbedding.mlmodelc"),
                        .copy("MLModels/DocumentClassifierDynamicEmbedding.mlmodel"),
					]
			),
			.testTarget(
					name: "CustodianTests",
					dependencies: ["Custodian"]
			),
		]
)
