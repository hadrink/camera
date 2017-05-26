//
//  MenuView.swift
//  camera
//
//  Created by Rplay on 25/05/2017.
//  Copyright © 2017 Rplay. All rights reserved.
//

import Foundation
import UIKit

protocol MenuTableViewDelegate {
    func menuTableView(didBeginEditing textInput: UITextInput)
}

/// Menu view.
class MenuTableView: UITableView {

    /**
     Awake from nib method. Initialize values here.
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()

        print("Menu table view awake")

        self.addBlurEffect(style: .dark, alpha: 1.0)

    }

    /**
     Setup view method.
     */
    func setupView() {
        self.dataSource = self
        self.delegate = self
        self.register(UINib(nibName: "FriendsCell", bundle: nil), forCellReuseIdentifier: "FriendsCell")
        self.register(UINib(nibName: "InvitationsCell", bundle: nil), forCellReuseIdentifier: "InvitationsCell")

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
        let visibleRect = CGRect(
            origin: self.contentOffset,
            size: self.bounds.size
        )

        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = self.indexPathForRow(at: visiblePoint)!
        self.scrollToRow(at: visibleIndexPath, at: .top, animated: true)
    }
}

/// MenuView extension from UIScrollViewDelegate
extension MenuTableView: UIScrollViewDelegate {

    /**
     Scroll view did end decelerating.
     */
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollToMostVisibleCell()
    }

    /**
     Scroll view did end dragging.
     */
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.scrollToMostVisibleCell()
    }
}

extension MenuTableView: UITableViewDelegate {

    /**
     Height for row at indexPath.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

/// MenuView extension from UITableViewDataSource
extension MenuTableView: UITableViewDataSource {

    /**
     Number of rows in section.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    /**
     Cell for row at indexPath.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: UITableViewCell?

        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsCell
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "InvitationsCell", for: indexPath) as! InvitationsCell
        default:
            return UITableViewCell()
        }

        return cell!
    }
}

/// Menu TableView Delegate
extension MenuTableView: MenuTableViewDelegate {
    func menuTableView(didBeginEditing textInput: UITextInput) {
        return
    }
}

extension UITableView {

    /**
     Add a simple blur effect.
     - parameter style: Style you want (UIBlurEffectStyle).
     - parameter alpha: Opacity you want (CGFloat).
     */
    func addBlurEffect(style: UIBlurEffectStyle, alpha: CGFloat) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = alpha
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        self.backgroundView = blurEffectView
    }
}

