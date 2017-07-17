//
//  VideoManager.swift
//  camera
//
//  Created by Rplay on 16/07/2017.
//  Copyright © 2017 Rplay. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation

/// Video Manager.
class VideoManager: NSObject {

    var maxTime: TimeInterval = 10

    var timer: Timer?

    var isCapturing: Bool = false

    //private var assetWriterInput = AVAssetWriterInput(mediaType: AVMediaTypeVideo, outputSettings: [:])

    //private var writer = try? AVAssetWriter(outputURL: URL(string: UUID().uuidString)!, fileType: "mp4")

    /**
     Save the video.
     */
    func save() {
        //writer?.add(assetWriterInput)
    }

    /**
     Capture a video buffer.
     */
    func capture(buffer: CMSampleBuffer) {
        guard let timer = self.timer, timer.isValid else {
            self.captureStopped()
            return
        }

        self.captureStarted()
        //assetWriterInput.append(buffer)
    }

    /**
     Active capture.
     */
    func captureStarted() {
        guard !self.isCapturing else {
            return
        }

        self.stopCatptureIn(interval: maxTime)
        self.isCapturing = true
    }

    /**
     Stop capture.
     */
    func captureStopped() {
        self.timer?.invalidate()
        self.timer = nil
        self.save()
        self.isCapturing = false
    }

    /**
     Set timer to stop capture.
     */
    func stopCatptureIn(interval: TimeInterval) {
        self.timer = Timer.scheduledTimer(
            timeInterval: interval,
            target: self,
            selector: #selector(self.captureStopped),
            userInfo: nil,
            repeats: false
        )
    }
}
