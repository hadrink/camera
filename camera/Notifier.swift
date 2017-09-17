//
//  Notifier.swift
//  camera
//
//  Created by Rplay on 17/09/2017.
//  Copyright © 2017 Rplay. All rights reserved.
//

import Foundation

enum KPNotification {
    case startCapture
    case stopCapture

    var name: Notification.Name {
        switch self {
        case .startCapture:
            return Notification.Name(rawValue: "start_capture")
        case .stopCapture:
            return Notification.Name(rawValue: "stop_capture")
        }
    }
}
