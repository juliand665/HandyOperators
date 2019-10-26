// swift-tools-version:5.1

import PackageDescription

let package = Package(
	name: "HandyOperators",
	products: [
		.library(
			name: "HandyOperators",
			targets: ["HandyOperators"]
		),
	],
	dependencies: [],
	targets: [
		.target(
			name: "HandyOperators",
			dependencies: []
		),
		.testTarget(
			name: "HandyOperatorsTests",
			dependencies: ["HandyOperators"]
		),
	]
)
