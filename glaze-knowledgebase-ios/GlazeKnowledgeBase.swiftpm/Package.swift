// swift-tools-version: 5.9
import PackageDescription
import AppleProductTypes

let package = Package(
    name: "GlazeKnowledgeBase",
    platforms: [
        .iOS("17.0")
    ],
    products: [
        .iOSApplication(
            name: "GlazeKnowledgeBase",
            targets: ["GlazeKnowledgeBase"],
            bundleIdentifier: "com.piaceramic.glazeknowledgebase",
            teamIdentifier: "",
            displayVersion: "1.0.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .palette),
            accentColor: .presetColor(.brown),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "GlazeKnowledgeBase",
            path: "Sources",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
