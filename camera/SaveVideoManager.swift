//
//  SaveVideoManager.swift
//  camera
//
//  Created by Rplay on 19/07/2017.
//  Copyright © 2017 Rplay. All rights reserved.
//

import Foundation
import AVFoundation

/// Save video manager.
class SaveVideoManager {

    /**
     Asset writer input.
     */
    private var assetWriterInput: AVAssetWriterInput

    /**
     Get cache directory to save video.
     */
    private var cacheDirectory: URL? {
        let cacheUrls = FileManager.default.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        )

        return cacheUrls.first
    }

    init(assetWriterInput: AVAssetWriterInput) {
        self.assetWriterInput = assetWriterInput
        self.save()
    }

    /**
     Save video.
     */
    private func save() {
        guard let path = cacheDirectory?.appendingPathComponent(UUID().uuidString + ".mp4") else {
            return
        }

        let writer = try? AVAssetWriter(
            outputURL: path,
            fileType: AVFileTypeMPEG4
        )

        writer?.add(self.assetWriterInput)
    }
}
