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
        let audioDevice = Device.audio
        let videoDevice = Device.video
        return VideoSession(audioDevice: audioDevice, videoDevice: videoDevice)
    }()

    lazy var preview: VideoPreviewLayer = {
        return VideoPreviewLayer(size: CGSize(width: self.bounds.width, height: self.bounds.height), session: self.session)
    }()

    override func awakeFromNib() {
        super.awakeFromNib()

        print("Camera preview awake")

        #if (arch(i386) || arch(x86_64)) && os(iOS)

        #else
//            let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) as AVCaptureDevice
//
//            do {
//                let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
//
//                cameraSession.beginConfiguration()
//
//                if (cameraSession.canAddInput(deviceInput) == true) {
//                    cameraSession.addInput(deviceInput)
//                }
//
//                let dataOutput = AVCaptureVideoDataOutput()
//                dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(value: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange as UInt32)]
//                dataOutput.alwaysDiscardsLateVideoFrames = true
//
//                if (cameraSession.canAddOutput(dataOutput) == true) {
//                    cameraSession.addOutput(dataOutput)
//                }
//
//                cameraSession.commitConfiguration()
//
//                let queue = DispatchQueue(label: "com.invasivecode.videoQueue")
//                dataOutput.setSampleBufferDelegate(self, queue: queue)
//
//            }
//            catch let error as NSError {
//                NSLog("\(error), \(error.localizedDescription)")
//            }
//            
//            self.layer.addSublayer(previewLayer)
//            
//            cameraSession.startRunning()



            let audioDevice = Device.audio
            let videoDevice = Device.video
            //let session = VideoSession(audioDevice: audioDevice, videoDevice: videoDevice)
            //let preview = VideoPreviewLayer(size: CGSize(width: self.bounds.width, height: self.bounds.height), session: session)
            self.layer.addSublayer(preview)

        #endif
    }
}

extension CameraPreview: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        
    }
}
