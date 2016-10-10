//
//  ThemeHUD.swift
//  mala-ios
//
//  Created by 王新宇 on 2/29/16.
//  Copyright © 2016 Mala Online. All rights reserved.
//

import UIKit

class ThemeHUD: NSObject {

    static let sharedInstance = ThemeHUD()

    var isShowing = false
    var dismissTimer: Timer?

    lazy var containerView: UIView = {
        let view = UIView()
        return view
        }()

    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        return view
        }()

    class func showActivityIndicator() {
        showActivityIndicatorWhileBlockingUI(true)
    }

    class func showActivityIndicatorWhileBlockingUI(_ blockingUI: Bool) {

        if self.sharedInstance.isShowing {
            return // TODO: 或者用新的取代旧的
        }

        DispatchQueue.main.async {
            if
                let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                let window = appDelegate.window {

                    self.sharedInstance.isShowing = true

                    self.sharedInstance.containerView.isUserInteractionEnabled = blockingUI

                    self.sharedInstance.containerView.alpha = 0
                    window.addSubview(self.sharedInstance.containerView)
                
                    // 设置遮罩不遮盖导航栏
                    let width = window.bounds.size.width
                    let height = window.bounds.size.height - 64
                    self.sharedInstance.containerView.frame = CGRect(x: 0, y: 64, width: width, height: height)
                
                    UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
                        self.sharedInstance.containerView.alpha = 1

                    }, completion: { (finished) -> Void in
                        var point = self.sharedInstance.containerView.center
                        point.y -= 64
                        self.sharedInstance.containerView.makeToastActivity(point)
                        
                    })
            }
        }
    }

    class func hideActivityIndicator() {
        hideActivityIndicator() {
        }
    }

    class func hideActivityIndicator(_ completion: @escaping () -> Void) {

        DispatchQueue.main.async {

            if self.sharedInstance.isShowing {

                self.sharedInstance.activityIndicator.transform = CGAffineTransform.identity

                UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
                    self.sharedInstance.activityIndicator.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
                    self.sharedInstance.activityIndicator.alpha = 0

                }, completion: { (finished) -> Void in
                    self.sharedInstance.activityIndicator.removeFromSuperview()

                    UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
                        self.sharedInstance.containerView.alpha = 0

                    }, completion: { (finished) -> Void in
                        self.sharedInstance.containerView.removeFromSuperview()

                        completion()
                    })
                })
            }
            
            self.sharedInstance.isShowing = false
        }
    }
}
