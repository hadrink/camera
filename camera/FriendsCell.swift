//
//  FriendsCell.swift
//  camera
//
//  Created by Rplay on 25/05/2017.
//  Copyright © 2017 Rplay. All rights reserved.
//

import Foundation
import UIKit

/// Friends cell.
class FriendsCell: UITableViewCell {

    /**
     Friends collection view.
     */
    @IBOutlet weak var friendsCollectionView: FriendsCollectionView!

    /**
     Progress capture bar.
     */
    @IBOutlet weak var progressCaptureBar: UIProgressView!

    /**
     Maximum progress duration.
     */
    var maxDuration = Float(CaptureVideoConfig.maxDuration)

    /**
     Current duration.
     */
    var duration: Float = 0

    /**
     Progress timer.
     */
    var timer: Timer?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.progressCaptureBar.progress = 0
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleProgressCaptureBar(notification:)), name: KPNotification.startCapture.name, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.resetProgressBar(notification:)), name: KPNotification.stopCapture.name, object: nil)


        print("Friends cell awake")
    }

    /**
     Manage progress bar.
     */
    func handleProgressCaptureBar(notification: Notification) {
         self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.updateProgressbar), userInfo: nil, repeats: true)
    }

    /**
     Update progress bar depending on timer.
     */
    func updateProgressbar() {
        duration += 0.001
        print(duration)
        self.progressCaptureBar.progress = duration
    }

    func resetProgressBar(notification: Notification) {
        self.timer?.invalidate()
        self.timer = nil
        self.progressCaptureBar.progress = 0
        self.duration = 0
    }
}
