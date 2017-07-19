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
class CaptureVideoManager: NSObject {

    /**
     Check if video is capturing.
     */
    internal var isCapturing: Bool {
        return _isCapturing
    }

    /**
     Check if video is capturing (private value).
     */
    private var _isCapturing: Bool = false

    /**
     Record max duration.
     */
    private var maxDuration: TimeInterval = 10

    /**
     Timer to save the record at max duration.
     */
    private var timer: Timer?

    /**
     Set buffers into an asset writer input.
     */
    private var assetWriterInput = AVAssetWriterInput(
        mediaType: AVMediaTypeVideo,
        outputSettings: [
            AVVideoCodecKey: AVVideoCodecH264,
            AVVideoHeightKey: 720 ,
            AVVideoWidthKey: 1280
        ]
    )

    /**
     Save the video.
     */
//    func save() {
//        //writer?.add(assetWriterInput)
//    }

    /**
     Capture a video buffer.
     */
    func capture(buffer: CMSampleBuffer?) {
        self.startCapture()
        guard let buffer = buffer else { return }
        assetWriterInput.append(buffer)
    }

    /**
     Active capture.
     */
    private func startCapture() {
        guard !self.isCapturing else {
            return
        }

        self.stopCatptureIn(maxDuration)
        self._isCapturing = true
    }

    /**
     Stop capture.
     */
    func stopCapture() {
        self.timer?.invalidate()
        self.timer = nil
        self._isCapturing = false
        SaveVideoManager(assetWriterInput: self.assetWriterInput)
    }

    /**
     Set timer to stop capture.
     */
    private func stopCatptureIn(_ duration: TimeInterval) {
        self.timer = Timer.scheduledTimer(
            timeInterval: duration,
            target: self,
            selector: #selector(self.stopCapture),
            userInfo: nil,
            repeats: false
        )
    }
}
