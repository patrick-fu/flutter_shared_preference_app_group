// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "shared_preference_app_group",
    platforms: [
        .iOS("13.0"),
        .macOS("10.15"),
    ],
    products: [
        .library(
            name: "shared-preference-app-group",
            targets: ["shared_preference_app_group"]
        ),
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
    ],
    targets: [
        .target(
            name: "shared_preference_app_group",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
            ],
            resources: [
                .process("PrivacyInfo.xcprivacy"),
            ],
            cSettings: [
                .headerSearchPath("include/shared_preference_app_group"),
            ]
        ),
    ]
)
