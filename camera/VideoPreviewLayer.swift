//
//  Preview.swift
//  camera
//
//  Created by Rplay on 03/06/2017.
//  Copyright © 2017 Rplay. All rights reserved.
//

import Foundation
import AVFoundation

class VideoPreviewLayer: AVCaptureVideoPreviewLayer {

    init(size: CGSize, session: VideoSession) {
        super.init(session: session)
        self.create(from: size, session: session)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /**
     Create video preview layer.

     - parameter size: Size for preview layer (CGSize).
     - parameter session: An AVCaptureSession is mandatory (AVCaptureSession).
     */
    private func create(from size: CGSize, session: AVCaptureSession){
        self.frame.size = size
        self.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.connection.videoOrientation = .portrait
    }
}


