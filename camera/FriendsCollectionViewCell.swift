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

        print("Friends collection view cell awake")
    }
}
