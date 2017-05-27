//
//  MenuView.swift
//  camera
//
//  Created by Rplay on 27/05/2017.
//  Copyright © 2017 Rplay. All rights reserved.
//

import Foundation
import UIKit

class MenuView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()

        print("Menu view awake")
        let view = Bundle.main.loadNibNamed("MenuTableView", owner: MenuTableView.self, options: nil) as? MenuTableView
        self.addSubview(view!)
    }
}
