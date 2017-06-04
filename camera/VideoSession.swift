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

/// Video Session.
class VideoSession: AVCaptureSession {

    /**
     Audio device.
     */
    var audioDevice: AVCaptureDevice?

    /**
     Video device.
     */
    var videoDevice: AVCaptureDevice

    /**
     Video preset.
     */
    var preset: String

    /**
     Initialize a video session.
     - parameter audioDevice: The audio device (AVCaptureDevice).
     - parameter videoDevice: The video device required (AVCaptureDevice).
     - parameter preset: The video quality (String).
     */
    init(audioDevice: AVCaptureDevice?,
         videoDevice: AVCaptureDevice,
         preset: String = AVCaptureSessionPresetMedium) {
        self.audioDevice = audioDevice
        self.videoDevice = videoDevice
        self.preset = preset
        super.init()
        self.createSession()
    }

    /**
     Create session for self.
     */
    private func createSession() {
        self.sessionPreset = self.preset
        addVideoInput()
        addAudioInput()
    }

    /**
     Add a video input from a video device.
     */
    private func addVideoInput() {
        do {
            let inputVideo = try AVCaptureDeviceInput(device: videoDevice)
            self.addInput(inputVideo)
        } catch let error {
            print(error)
        }
    }

    /**
     Add an audio input from an audio device.
     */
    private func addAudioInput() {
        do {
            let inputAudio = try AVCaptureDeviceInput(device: audioDevice)
            self.addInput(inputAudio)
        } catch let error {
            print(error)
        }
    }

    /**
     Get the video output.
     */
    lazy var videoOutput: AVCaptureVideoDataOutput? = {
        let outputVideo = AVCaptureVideoDataOutput()
        outputVideo.alwaysDiscardsLateVideoFrames = true
        let compressionSettings = [
            AVVideoProfileLevelKey: AVVideoProfileLevelH264Main41,
            AVVideoAverageBitRateKey : 24*(1024.0*1024.0)] as [String : Any
        ]
        let videoSettings = [
            kCVPixelBufferPixelFormatTypeKey as NSString:Int(kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange),
            AVVideoCodecKey: AVVideoCodecH264,
            AVVideoCompressionPropertiesKey: compressionSettings,
            AVVideoWidthKey: 480,
            AVVideoHeightKey: 640 ] as [AnyHashable : Any]

        outputVideo.videoSettings = videoSettings

        guard self.canAddOutput(outputVideo) else {
            return nil
        }

        self.addOutput(outputVideo)
        return outputVideo
    }()

    /**
     Get the audio output.
     */
    lazy var audioOutput: AVCaptureAudioDataOutput? = {
        let outputAudio = AVCaptureAudioDataOutput()
        guard self.canAddOutput(outputAudio) else {
            return nil
        }

        self.addOutput(outputAudio)
        return outputAudio
    }()

    func startSession() {
        self.startRunning()
    }

}
