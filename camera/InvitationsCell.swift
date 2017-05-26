//
//  InvitationsCell.swift
//  camera
//
//  Created by Rplay on 26/05/2017.
//  Copyright © 2017 Rplay. All rights reserved.
//

import Foundation
import UIKit

class InvitationsCell: UITableViewCell {

    @IBOutlet weak var friendSearchBar: UISearchBar!

    var delegate: MenuTableViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear

        print("Invatation cell awake")

        friendSearchBar.delegate = self
    }
}

extension InvitationsCell: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        delegate?.menuTableView(didBeginEditing: searchBar as! UITextInput)
    }
}
