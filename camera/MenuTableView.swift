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
        setupNotifications()
        setupGesture()

        print("Menu table view awake")
    }

    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)    }

    /**
     Setup view method.
     */
    func setupView() {
        self.addBlurEffect(style: .dark, alpha: 1.0)
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
     Setup gesture.
     */
    func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.activeEndEditing))
        self.superview!.addGestureRecognizer(tapGesture)
    }

    /**
     Call end editing to hide the keyboard.
     */
    func activeEndEditing() {
        self.endEditing(true)
    }

    /**
     Keyboard will show notification.
     */
    func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = self.getKeyboardFrame(from: notification) else {
            return
        }

        for constraint in self.superview!.constraints {
            guard constraint.firstAttribute == .bottom else {
                continue
            }

            self.animate(from: constraint, to: -keyboardFrame.height)
        }
    }

    /**
     Keyboard will hide notification.
     */
    func keyboardWillHide(notification: NSNotification) {
        guard let keyboardFrame = self.getKeyboardFrame(from: notification) else {
            return
        }

        for constraint in self.superview!.constraints {
            guard constraint.firstAttribute == .bottom else {
                continue
            }

            self.animate(from: constraint, to: +keyboardFrame.height)
        }
    }

    /**
     Animate a constraint.
     - parameter constraint: A constrain (NSLayoutConstraint).
     - parameter value: The new constraint value (CGFloat).
     */
    func animate(from constraint: NSLayoutConstraint, to value: CGFloat) {
        constraint.constant += value
        UIView.animate(withDuration: 0.6, animations: {
            self.superview?.layoutIfNeeded()
        })
    }

    /**
     Get keyboard frame.
     - parameter notification: A keyboard notification (NSNotification).

     - returns: The keyboard frame (CGRect?).
     */
    func getKeyboardFrame(from notification: NSNotification) -> CGRect? {
        guard let keyboardSize = (notification.userInfo?[
            UIKeyboardFrameBeginUserInfoKey
            ] as? NSValue
            )?.cgRectValue
            else {
                return nil
        }

        return keyboardSize
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

