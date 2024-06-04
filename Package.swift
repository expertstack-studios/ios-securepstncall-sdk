// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SecuredCallsSDK",
  products: [
    .library(
      name: "SecuredCallsSDK",
      targets: ["SecuredCallsSDK"])
  ],
  targets: [
    .binaryTarget(
      name: "SecuredCallsSDK",
      path: "./SDK/SecuredCallsSDK.xcframework.zip")
  ])
