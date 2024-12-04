//
//  UIViewController+Extensions_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

typealias UIViewController_MGRE = UIViewController

extension UIViewController_MGRE {
    static func loadFromNib_MGRE() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            let nibName = String(describing: T.self).components(separatedBy: "<").first ?? String(describing: T.self)
            return T.init(nibName: nibName, bundle: Bundle.main)
        }
        
        return instantiateFromNib()
    }
    
    func hideKeyboardWhenTappedAround_MGRE() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard_MGRE))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard_MGRE() {
        view.endEditing(true)
    }
}
