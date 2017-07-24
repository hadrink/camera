//
//  SaveVideoManager.swift
//  camera
//
//  Created by Rplay on 19/07/2017.
//  Copyright © 2017 Rplay. All rights reserved.
//

import Foundation
import AVFoundation

protocol SaveVideoManagerDelegate {
    func saveVideoManager(didSaveVideoAt filepath: URL)
}

/// Save video manager.
class SaveVideoManager {

    /**
     Save video manager delegate.
     */
    internal var delegate: SaveVideoManagerDelegate?

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

    /**
     Write video.
     */
    func write(input: AVAssetWriterInput, startTime: CMTime) {
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
        writer?.startWriting()
        writer?.startSession(atSourceTime: startTime)
//        writer?.finishWriting(completionHandler: {
//            guard let filepath = self.filepath else { return }
//            self.delegate?.saveVideoManager(didSaveVideoAt: filepath)
//        })
    }
}
