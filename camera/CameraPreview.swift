//
//  CameraPreview.swift
//  camera
//
//  Created by Rplay on 26/05/2017.
//  Copyright © 2017 Rplay. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

class CameraPreview: UIView {

    lazy var session: VideoSession = {
        return VideoSession(audioDevice: Device.audio, videoDevice: Device.video)
    }()

    lazy var preview: VideoPreviewLayer = {
        let size = CGSize(width: self.bounds.width, height: self.bounds.height)
        return VideoPreviewLayer(size: size, session: self.session)
    }()

    var captureVideoManager: CaptureVideoManager = CaptureVideoManager()

    var canCapture: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.startCaptureRequest(notification:)),
            name: Notification.Name("start_capture_request"),
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.stopCaptureRequest(notification:)),
            name: Notification.Name("stop_capture"),
            object: nil
        )


        #if (arch(i386) || arch(x86_64)) && os(iOS)
        #else
            self.layer.addSublayer(preview)
            session.startSession()
            session.videoOutput?.setSampleBufferDelegate(self, queue: DispatchQueue(label: "video_queue"))
        #endif
    }

    /**
     Catpure request received.
     */
    func startCaptureRequest(notification: Notification) {
        print("capture request")
        self.canCapture = true
    }

    /**
     Stop catpure request received.
     */
    func stopCaptureRequest(notification: Notification) {
        print("stop capture request")
        self.canCapture = false
    }
}

extension CameraPreview: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!,
                       didOutputSampleBuffer sampleBuffer: CMSampleBuffer!,
                       from connection: AVCaptureConnection!) {
        guard canCapture else {
            return
        }

        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }

        self.captureVideoManager.delegate = self
        self.captureVideoManager.capture(buffer: sampleBuffer)
    }
}

extension CameraPreview: CaptureVideoManagerDelegate {

    func captureVideoManager(didCaptureInput input: AVAssetWriterInput) {

    }
}

extension CameraPreview: SaveVideoManagerDelegate {
    func saveVideoManager(didSaveVideoAt filepath: URL) {
        print("video saved at \(filepath)")
    }
}

