//
//  SaveManagerTests.swift
//  camera
//
//  Created by Rplay on 20/07/2017.
//  Copyright © 2017 Rplay. All rights reserved.
//

import Foundation
import XCTest
import AVFoundation
@testable import camera

class SaveVideoManagerTests: XCTestCase, SaveVideoManagerDelegate {

    let saveVideoManager = SaveVideoManager()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSaveVideoManager() {
        let assetWriterInput = AVAssetWriterInput(
            mediaType: AVMediaTypeVideo,
            outputSettings: [
                AVVideoCodecKey: AVVideoCodecH264,
                AVVideoHeightKey: 720 ,
                AVVideoWidthKey: 1280
            ]
        )

        saveVideoManager.delegate = self
        saveVideoManager.write(input: assetWriterInput)
        XCTAssertEqual(saveVideoManager.filename, saveVideoManager.filepath?.lastPathComponent)
    }

    func saveVideoManager(didSaveVideoAt filepath: URL) {
        XCTAssertEqual(filepath, saveVideoManager.filepath)
    }
}
