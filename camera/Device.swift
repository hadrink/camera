//
//  Device.swift
//  camera
//
//  Created by Rplay on 03/06/2017.
//  Copyright © 2017 Rplay. All rights reserved.
//

import Foundation
import AVFoundation

class Device {

    static var audio: AVCaptureDevice {
        return  AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio)
    }

    static var video: AVCaptureDevice {
        return  AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    }
}
