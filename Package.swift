// swift-tools-version: 6.0
//
// Backdrop: moving backgrounds for Drift and Galileo, and on their own.
//
//   RenderCore   GPU context, colour science, finishing, readback, video writing
//   BackdropKit  generative background engine (Metal, analytic, loopable)
//   StageKit     the shared stage: renderer, scene engine and export
//   StudioKit    shared design language, controls and window chrome
//   Updates      in-app updates from GitHub releases (Sparkle)
//
//   Backdrop     the background studio
//
// Drift 2 and Galileo 2 are built on the same engine in their own
// repositories, bomkino/pitchdog-drift and bomkino/galileo-gallery.
//
import PackageDescription

let settings: [SwiftSetting] = [
    .swiftLanguageMode(.v5),
]

// The app loads Sparkle from Contents/Frameworks, where scripts/build.sh puts it.
let appLinker: [LinkerSetting] = [
    .unsafeFlags(["-Xlinker", "-rpath", "-Xlinker", "@executable_path/../Frameworks"]),
]

let package = Package(
    name: "Backdrop",
    platforms: [.macOS(.v14)],
    products: [
        .library(name: "RenderCore", targets: ["RenderCore"]),
        .library(name: "BackdropKit", targets: ["BackdropKit"]),
        .library(name: "StageKit", targets: ["StageKit"]),
        .library(name: "StudioKit", targets: ["StudioKit"]),
        .executable(name: "Backdrop", targets: ["BackdropApp"]),
    ],
    dependencies: [
        // In-app updates from GitHub releases (Updates module).
        .package(url: "https://github.com/sparkle-project/Sparkle", exact: "2.10.0"),
    ],
    targets: [
        .target(name: "RenderCore", swiftSettings: settings),
        .target(name: "BackdropKit", dependencies: ["RenderCore"], swiftSettings: settings),
        .target(name: "StageKit", dependencies: ["RenderCore", "BackdropKit"], swiftSettings: settings),
        .target(name: "StudioKit", dependencies: ["RenderCore", "BackdropKit", "StageKit"], swiftSettings: settings),
        .target(name: "Updates", dependencies: [.product(name: "Sparkle", package: "Sparkle")], swiftSettings: settings),
        .executableTarget(name: "BackdropApp", dependencies: ["StudioKit", "Updates"], swiftSettings: settings, linkerSettings: appLinker),
    ]
)
