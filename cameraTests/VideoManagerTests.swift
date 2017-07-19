//
//  VideoManagerTests.swift
//  camera
//
//  Created by Rplay on 17/07/2017.
//  Copyright © 2017 Rplay. All rights reserved.
//

import Foundation
import XCTest
import AVFoundation
@testable import camera

class VideoManagerTests: XCTestCase {

    var videoManager = CaptureVideoManager()

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
        self.videoManager.capture(buffer: nil)
        let isCapturing = self.videoManager.isCapturing
        XCTAssert(isCapturing, "Video is capturing.")
    }

    /**
     Test if capture is stopped.
     */
    func testStopCapture() {
        self.videoManager.capture(buffer: nil)
        XCTAssert(self.videoManager.isCapturing, "Video is capturing.")
        self.videoManager.stopCapture()
        XCTAssertFalse(self.videoManager.isCapturing, "Video is stopped.")
    }

    /**
     Test if capture is stopped after timer is done.
     */
    func testCaptureStopWhenTimerIsDone() {
        self.videoManager.capture(buffer: nil)
        self.waitForTimer()
    }

    func waitForTimer() {
        waitTimerIsCapturingExpectation = expectation(description: "is capturing")
        waitTimerIsNotCapturingExpectation = expectation(description: "is not capturing")

        Timer.scheduledTimer(
            timeInterval: 5,
            target: self,
            selector: #selector(VideoManagerTests.timerIsCapturing),
            userInfo: nil,
            repeats: false
        )

        Timer.scheduledTimer(
            timeInterval: 10,
            target: self,
            selector: #selector(VideoManagerTests.timerIsNotCapturing),
            userInfo: nil, repeats: false
        )

        waitForExpectations(timeout: 10 + 1, handler: nil)
    }

    func timerIsCapturing() {
        waitTimerIsCapturingExpectation?.fulfill()
        XCTAssert(self.videoManager.isCapturing)
    }

    func timerIsNotCapturing() {
        waitTimerIsNotCapturingExpectation?.fulfill()
        XCTAssertFalse(self.videoManager.isCapturing)
    }
}
