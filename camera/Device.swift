//
//  Device.swift
//  camera
//
//  Created by Rplay on 03/06/2017.
//  Copyright © 2017 Rplay. All rights reserved.
//

import Foundation
import AVFoundation

/// Device object.
struct Device {

    /**
     Get audio.
     */
    static var audio: AVCaptureDevice {
        return  AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio)
    }

    /**
     Get video.
     */
    static var video: AVCaptureDevice {
        return AVCaptureDevice.defaultDevice(
            withDeviceType: .builtInWideAngleCamera,
            mediaType: AVMediaTypeVideo,
            position: .front
        )
    }
}
