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

protocol CaptureVideoManagerDelegate {
    func captureVideoManager(didCaptureInput input: AVAssetWriterInput)
}

/// Video Manager.
class CaptureVideoManager: NSObject {

    /**
     Capture video manager delegate.
     */
    var delegate: CaptureVideoManagerDelegate?

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
    private var maxDuration: TimeInterval = CaptureVideoConfig.maxDuration

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

    private var saveVideoManager = SaveVideoManager()

    /**
     Capture a video buffer.
     */
    func capture(buffer: CMSampleBuffer?) {
        let startTime = CMSampleBufferGetPresentationTimeStamp(buffer!)
        self.startCapture(startTime: startTime)
        guard let buffer = buffer,
              CMSampleBufferDataIsReady(buffer),
              assetWriterInput.isReadyForMoreMediaData else {
            return
        }

        assetWriterInput.append(buffer)
    }

    /**
     Active capture.
     */
    private func startCapture(startTime: CMTime) {
        guard !self._isCapturing else {
            return
        }

        assetWriterInput.expectsMediaDataInRealTime = true
        saveVideoManager.write(input: assetWriterInput, startTime: startTime)
        DispatchQueue.main.async {
            self.stopCatptureIn(self.maxDuration)
        }
        self._isCapturing = true
    }

    /**
     Set timer to stop capture.
     */
    func stopCatptureIn(_ duration: TimeInterval) {
        self.timer = Timer.scheduledTimer(
            timeInterval: duration,
            target: self,
            selector: #selector(self.stopCapture),
            userInfo: nil,
            repeats: false
        )
    }

    /**
     Stop capture.
     */
    func stopCapture() {
        self.timer?.invalidate()
        self.timer = nil
        self._isCapturing = false
        let stopNotification = Notification(name: Notification.Name(rawValue: "stop_capture"))
        NotificationCenter.default.post(stopNotification)
        assetWriterInput.markAsFinished()
    }
}
