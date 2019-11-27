import Files
import Foundation
import XCTest

import CommandLineToolCore

class CommandLineToolTests: XCTestCase {
    let testFileName = "Hello.swift"
    func testCreatingFile() throws {
        let fileSystem = FileSystem()
        let tempFolder = fileSystem.temporaryFolder
        let testFolder = try tempFolder.createSubfolderIfNeeded(
            withName: "CommandLineToolTests"
        )

        try testFolder.empty()

        let fileManager = FileManager.default
        fileManager.changeCurrentDirectoryPath(testFolder.path)

        let arguments = [testFolder.path, testFileName]
        let tool = CommandLineTool(arguments: arguments)

        try tool.run()

        XCTAssertNotNil(try? testFolder.file(named: testFileName))
    }
}
