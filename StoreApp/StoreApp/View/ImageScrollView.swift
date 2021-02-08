//
//  ImageScrollView.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/07.
//

import UIKit

class ImageScrollView: UIScrollView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        NotificationCenter.default.post(name: .disableAutoScroll, object: nil)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        NotificationCenter.default.post(name: .enableAutoScroll, object: nil)
    }
}

extension Notification.Name {
    static let disableAutoScroll = Notification.Name(rawValue: "DisableAutoScroll")
    static let enableAutoScroll = Notification.Name(rawValue: "EnableAutoScroll")
}
