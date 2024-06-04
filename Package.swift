// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "EsCallSdk",
  products: [
    .library(
      name: "SecuredCallsSDK",
      targets: ["SecuredCallsSDK"])
  ],
  targets: [
    .binaryTarget(
      name: "SecuredCallsSDK",
      path: "./SecuredCallsSDK/SecuredCallsSDK.xcframework.zip")
  ])
