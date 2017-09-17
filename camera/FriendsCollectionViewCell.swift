//
//  FriendsCollectionViewCell.swift
//  camera
//
//  Created by Rplay on 25/05/2017.
//  Copyright © 2017 Rplay. All rights reserved.
//

import Foundation
import UIKit

/// Friends collection view cell.
class FriendsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var profilePictureView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.profilePictureView.layer.cornerRadius = self.profilePictureView.bounds.width / 2
        let longPressGesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(self.longPressGestureHandler(longPressGesture:)))
        self.profilePictureView.addGestureRecognizer(longPressGesture)
    }

    /**
     Long press gesture handler.
     
     - parameter longPressGesture: the long press gesture object.
     */
    func longPressGestureHandler(longPressGesture: UILongPressGestureRecognizer) {
        switch longPressGesture.state {
        case .began:
            let captureNotification = Notification(name: KPNotification.startCapture.name)
            NotificationCenter.default.post(captureNotification)
        case .ended:
            let stopNotification = Notification(name: KPNotification.stopCapture.name)
            NotificationCenter.default.post(stopNotification)
        default:
            return
        }
    }
}
