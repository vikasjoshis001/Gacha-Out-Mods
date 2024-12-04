//
//  UIHelper.swift
//  ios-mod-gacha-ref-02
//
//  Created by Vikas Joshi on 04/12/24.
//

import Foundation
import UIKit

struct UIHelper {
    static func createGradientLayer(color1: String, color2: String) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(named: color1)?.cgColor ?? UIColor.clear.cgColor,
            UIColor(named: color2)?.cgColor ?? UIColor.clear.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0) // Top-left corner
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)   // Bottom-right corner
        gradientLayer.frame = UIScreen.main.bounds // Full-screen gradient
        return gradientLayer
    }
}
