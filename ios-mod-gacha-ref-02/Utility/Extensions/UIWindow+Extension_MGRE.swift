//
//  UIWindow+Extension_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

typealias UIWindow_MGRE = UIWindow

extension UIWindow_MGRE {
    var topViewController_MGRE: UIViewController? {
        var _MGRE569: Int { 0 }
        
        var top = rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}
