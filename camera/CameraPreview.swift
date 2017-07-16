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

    override func awakeFromNib() {
        super.awakeFromNib()

        print("Camera preview awake")

        #if (arch(i386) || arch(x86_64)) && os(iOS)

        #else
            self.layer.addSublayer(preview)
            session.startSession()
            session.videoOutput?.setSampleBufferDelegate(self, queue: DispatchQueue(label: "video_queue"))

        #endif
    }
}

extension CameraPreview: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!,
                       didOutputSampleBuffer sampleBuffer: CMSampleBuffer!,
                       from connection: AVCaptureConnection!) {

    }
}
