//
//  captureVideoManagerTests.swift
//  camera
//
//  Created by Rplay on 17/07/2017.
//  Copyright © 2017 Rplay. All rights reserved.
//

import Foundation
import XCTest
import AVFoundation
@testable import camera

class CaptureVideoManagerTests: XCTestCase, CaptureVideoManagerDelegate {

    var captureVideoManager = CaptureVideoManager()

    var waitTimerIsCapturingExpectation: XCTestExpectation?

    var waitTimerIsNotCapturingExpectation: XCTestExpectation?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    /**
     Test if capture is started.
     */
    func testCapture() {
        self.captureVideoManager.capture(buffer: nil)
        let isCapturing = self.captureVideoManager.isCapturing
        XCTAssert(isCapturing, "Video is capturing.")
    }

    /**
     Test if capture is stopped.
     */
    func testStopCapture() {
        self.captureVideoManager.capture(buffer: nil)
        self.captureVideoManager.delegate = self
        XCTAssert(self.captureVideoManager.isCapturing, "Video is capturing.")
        self.captureVideoManager.stopCapture()
        XCTAssertFalse(self.captureVideoManager.isCapturing, "Video is stopped.")
    }

    func captureVideoManager(didCaptureInput input: AVAssetWriterInput) {
        XCTAssert(true, "test if method is called when capture is stopped.")
    }

    /**
     Test if capture is stopped after timer is done.
     */
    func testCaptureStopWhenTimerIsDone() {
        self.captureVideoManager.capture(buffer: nil)
        self.waitForTimer()
    }

    func waitForTimer() {
        waitTimerIsCapturingExpectation = expectation(description: "is capturing")
        waitTimerIsNotCapturingExpectation = expectation(description: "is not capturing")

        Timer.scheduledTimer(
            timeInterval: 5,
            target: self,
            selector: #selector(self.timerIsCapturing),
            userInfo: nil,
            repeats: false
        )

        Timer.scheduledTimer(
            timeInterval: 10,
            target: self,
            selector: #selector(self.timerIsNotCapturing),
            userInfo: nil, repeats: false
        )

        waitForExpectations(timeout: 10 + 1, handler: nil)
    }

    func timerIsCapturing() {
        waitTimerIsCapturingExpectation?.fulfill()
        XCTAssert(self.captureVideoManager.isCapturing)
    }

    func timerIsNotCapturing() {
        waitTimerIsNotCapturingExpectation?.fulfill()
        XCTAssertFalse(self.captureVideoManager.isCapturing)
    }
}
