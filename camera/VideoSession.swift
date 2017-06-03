//
//  Session.swift
//  camera
//
//  Created by Rplay on 03/06/2017.
//  Copyright © 2017 Rplay. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class VideoSession: AVCaptureSession {

    var audioDevice: AVCaptureDevice?

    var videoDevice: AVCaptureDevice

    var preset: String

    init(audioDevice: AVCaptureDevice?, videoDevice: AVCaptureDevice, preset: String = AVCaptureSessionPresetMedium) {
        self.audioDevice = audioDevice
        self.videoDevice = videoDevice
        self.preset = preset
        super.init()
        self.createSession()
    }


    var connection: AVCaptureConnection?
    var sessionQueue: DispatchQueue?


    private func createSession() {

        self.sessionPreset = self.preset

        addVideoInput()
        addAudioInput()

        //addVideoOutput()
        //addAudioOutput()
    }

    func addVideoInput() {
        do {
            let inputVideo = try AVCaptureDeviceInput(device: videoDevice)
            self.addInput(inputVideo)
        } catch let error {
            print(error)
        }
    }

    func addAudioInput() {
        do {
            let inputAudio = try AVCaptureDeviceInput(device: audioDevice)
            self.addInput(inputAudio)
        } catch let error {
            print(error)
        }
    }

    func addVideoOutput() {
        let outputVideo = AVCaptureVideoDataOutput()
        outputVideo.alwaysDiscardsLateVideoFrames = true

        let compressionSettings = [ AVVideoProfileLevelKey: AVVideoProfileLevelH264Main41, AVVideoAverageBitRateKey : 24*(1024.0*1024.0)] as [String : Any]

        let videoSettings = [kCVPixelBufferPixelFormatTypeKey as NSString:Int(kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange), AVVideoCodecKey : AVVideoCodecH264, AVVideoCompressionPropertiesKey: compressionSettings, AVVideoWidthKey : 480,  AVVideoHeightKey : 640 ] as [AnyHashable : Any]

        outputVideo.videoSettings = videoSettings

        if self.canAddOutput(outputVideo) {
            self.addOutput(outputVideo)
        }
    }


    func addAudioOutput() {
        let outputAudio = AVCaptureAudioDataOutput()

        if self.canAddOutput(outputAudio) {
            self.addOutput(outputAudio)
        }
    }


    func startSession() {
        self.startRunning()
    }

}
