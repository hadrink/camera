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

class CameraPreview: UIView {

//    lazy var cameraSession: AVCaptureSession = {
//        let s = AVCaptureSession()
//        s.sessionPreset = AVCaptureSessionPresetHigh
//        return s
//    }()
//
//    lazy var previewLayer: AVCaptureVideoPreviewLayer = {
//        let preview =  AVCaptureVideoPreviewLayer(session: self.cameraSession)
//        preview?.bounds = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
//        preview?.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
//        preview?.videoGravity = AVLayerVideoGravityResize
//        return preview!
//    }()

    lazy var session: VideoSession = {
        return VideoSession(audioDevice: Device.audio, videoDevice: Device.video)
    }()

    lazy var preview: VideoPreviewLayer = {
        return VideoPreviewLayer(size: CGSize(width: self.bounds.width, height: self.bounds.height), session: self.session)
    }()

    override func awakeFromNib() {
        super.awakeFromNib()

        print("Camera preview awake")

        #if (arch(i386) || arch(x86_64)) && os(iOS)

        #else
            self.layer.addSublayer(preview)
            session.startSession()
            session.videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "video_queue"))

        #endif
    }
}

extension CameraPreview: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {

    }
}
