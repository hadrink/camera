//
//  MenuView.swift
//  camera
//
//  Created by Rplay on 25/05/2017.
//  Copyright © 2017 Rplay. All rights reserved.
//

import Foundation
import UIKit

/// Menu view.
class MenuView: UITableView {

    /**
     Awake from nib method. Initialize values here.
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    /**
     Setup view method.
     */
    func setupView() {
        self.dataSource = self

        for view in self.subviews {
            guard let scrollView = view as? UIScrollView else {
                continue
            }

            scrollView.delegate = self
        }
    }

    /**
     Scroll to most visible cell.
     */
    func scrollToMostVisibleCell() {
        let visibleRect = CGRect(origin: self.contentOffset, size: self.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath: IndexPath = self.indexPathForRow(at: visiblePoint)!
        self.scrollToRow(at: visibleIndexPath, at: .top, animated: true)
    }
}

/// MenuView extension from UIScrollViewDelegate
extension MenuView: UIScrollViewDelegate {

    /**
     Scroll view did end decelerating.
     */
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("did end deccelerating")
        self.scrollToMostVisibleCell()
    }

    /**
     Scroll view did end dragging.
     */
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("did end dragging")
        self.scrollToMostVisibleCell()
    }
}

/// MenuView extension from UITableViewDataSource
extension MenuView: UITableViewDataSource {

    /**
     Number of rows in section.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    /**
     Height for row at indexPath.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    /**
     Cell for row at indexPath.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        print(cell.isUserInteractionEnabled)
        switch indexPath.row {
        case 0:
            cell.backgroundColor = .blue
        case 1:
            cell.backgroundColor = .yellow
        case 2:
            cell.backgroundColor = .green
        default:
            return cell
        }

        return cell
    }
}

