//
//  UIHelper.swift
//  ios-mod-gacha-ref-02
//
//  Created by Vikas Joshi on 04/12/24.
//

import Foundation
import UIKit

struct UIHelper {
    static func applyBottomRightCornerRadius(to view: UIView, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: view.bounds,
            byRoundingCorners: [.bottomRight],
            cornerRadii: CGSize(width: radius, height: radius) // Adjust the radius as needed
        )
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = maskPath.cgPath
        
        view.layer.mask = maskLayer
    }
}
