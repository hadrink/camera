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
    override func awakeFromNib() {
        super.awakeFromNib()

        print("Friends cell awake")
        self.backgroundColor = .red
    }
}
