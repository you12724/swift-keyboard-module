//
//  KeyboardModule.swift
//  KeyboardTest
//
//  Created by 堀 洋輔 on 2017/11/02.
//  Copyright © 2017年 yosuke_hori. All rights reserved.
//

import Foundation
import UIKit

protocol KeyboardModule {
    func handleKeyboardWillShowNotification(notification: Notification)
    func handleKeyboardWillHideNotification(notification: Notification)
    func setObserver()
    weak var scrollView: UIScrollView! { get set }
    var activeTextField: UITextField? { get set }
}

extension KeyboardModule where Self: UIViewController {
    func handleKeyboardWillShowNotification(notification: Notification) {
        
        // スクロール領域を変更
        guard let userInfo = notification.userInfo else {
            fatalError("キーボード情報が取得できません")
        }
        guard let keyboard = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            fatalError("キーボード情報が取得できません")
        }
        let keyboardRect = scrollView.convert(keyboard.cgRectValue, from: nil)
        let keyboardMargin: CGFloat = 8.0
        let contentInset = UIEdgeInsets(top: 0, left: 0,
                                        bottom: (keyboardRect.size.height + keyboardMargin), right: 0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
        
        // スクロール位置の移動
        var viewRect = self.view.frame
        viewRect.size.height -= keyboardRect.size.height
        let scrollPointY = activeTextField?.frame.origin.y // violationReportView.frame.origin.y + reportBodyCell.frame.origin.y
        let scrollPoint = CGPoint(x: 0, y: scrollPointY!)
        scrollView.setContentOffset(scrollPoint, animated: true)
    }
    
    func handleKeyboardWillHideNotification(notification: Notification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    func setObserver() {
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil) { notification in
            self.handleKeyboardWillShowNotification(notification: notification)
        }
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: nil) { notification in
            self.handleKeyboardWillHideNotification(notification: notification)
        }
    }

}
