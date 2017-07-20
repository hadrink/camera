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
     Writer object.
     */
    private var writer: AVAssetWriter?

    /**
     Return filename.
     */
    internal var filename: String? {
        return writer?.outputURL.lastPathComponent
    }

    /**
     Return filepath.
     */
    internal var filepath: URL? {
        return writer?.outputURL
    }

    init(assetWriterInput: AVAssetWriterInput) {
        self.write(assetWriterInput)
    }

    /**
     Write video.
     */
    private func write(_ input: AVAssetWriterInput) {
        let cacheUrls = FileManager.default.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        )

        let filename = UUID().uuidString + ".mp4"
        let path = cacheUrls.first
        guard let filepath = path?.appendingPathComponent(filename) else {
            return
        }

        self.writer = try? AVAssetWriter(
            outputURL: filepath,
            fileType: AVFileTypeMPEG4
        )

        writer?.add(input)
    }
}
