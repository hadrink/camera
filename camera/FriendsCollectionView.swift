//
//  FriendsCollectionView.swift
//  camera
//
//  Created by Rplay on 25/05/2017.
//  Copyright © 2017 Rplay. All rights reserved.
//

import Foundation
import UIKit

/// Friends collection view.
class FriendsCollectionView: UICollectionView {

    /**
     Awake from nib.
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }

    /**
     Setup view.
     */
    func setupView() {
        let nib = UINib(nibName: "FriendsCollectionViewCell", bundle: nil)
        self.register(
            nib,
            forCellWithReuseIdentifier: "FriendsCollectionViewCell"
        )

        self.backgroundColor = .clear
        self.dataSource = self
//        self.delegate = self

        print("Friends collection awake")
    }
}

/// Friends collection view extension from UICollectionViewDataSource.
extension FriendsCollectionView: UICollectionViewDataSource {

    /**
     Number of items in section.
     */
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    /**
     Cell for item at indexPath.
     */
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "FriendsCollectionViewCell",
                for: indexPath
            ) as? FriendsCollectionViewCell
        else {
            return UICollectionViewCell()
        }

        return cell
    }
}
