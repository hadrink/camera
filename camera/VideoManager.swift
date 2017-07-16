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

struct VideoManager {

    var startDate: Date?

    var endDate: Date?

    var maxTime: Int = 10

    var isCapturing: Bool = false

    private var assetWriterInput = AVAssetWriterInput(mediaType: "", outputSettings: [:])

    private var writer = try? AVAssetWriter(outputURL: URL(string: "")!, fileType: "MP4")

    /**
     Save the video.
     */
    func save() {
        writer?.add(assetWriterInput)
    }

    /**
     Capture a video buffer
     */
    mutating func capture(buffer: CMSampleBuffer) {
        guard !captureNeedToStop else {
            self.captureStopped()
            return
        }

        self.captureStarted()
        assetWriterInput.append(buffer)
    }

    mutating func captureStarted() {
        guard !self.isCapturing else {
            return
        }

        self.startDate = Date()
        let calendar = Calendar.current
        self.endDate = calendar.date(byAdding: .second, value: maxTime, to: startDate!)
        self.isCapturing = true
    }

    mutating func captureStopped() {
        self.startDate = nil
        self.endDate = nil
        self.save()
        self.isCapturing = false
    }

    var captureNeedToStop: Bool {
        guard let endDate = self.endDate, Date() > endDate else {
            return false
        }

        return true
    }
}
