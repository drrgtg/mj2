//
//  PMToast.swift
//  ProductMJ2
//
//  Created by 刘Sir on 2020/9/25.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit
import Foundation
import Toast_Swift
class PMToast: NSObject {
    open class func showToast(_ message: String, view: UIView? = nil) {
        if let inView = view {
            inView.makeToast(message)
        } else {
            if let keyWindow = UIApplication.shared.keyWindow {
                keyWindow.makeToast(message)
            }
        }
    }
    open class func showSuccess(_ message: String) {
        SVProgressHUD.showSuccess(withStatus: message)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            SVProgressHUD.dismiss()
        }
    }
    open class func showLoading(_ message: String) {
        SVProgressHUD.show(withStatus: message)
    }
    open class func hidLoading() {
        SVProgressHUD.dismiss()
    }
}
