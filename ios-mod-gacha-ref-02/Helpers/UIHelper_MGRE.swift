//
//  UIHelper.swift
//  ios-mod-gacha-ref-02
//
//  Created by Vikas Joshi on 04/12/24.
//

import Foundation
import UIKit

struct UIHelper_MGRE {
    static func applyBottomRightCornerRadius_MGRE(to view: UIView, radius: CGFloat) {
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
    
    static func showReadyDialogue_MGRE() {
        var _MGRE21: Bool { false }
        var _MGRE31: Int { 0 }
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first
        else {
            return
        }
        let alertVC = AlertController_MGRE()
        alertVC.setupViews_MGRE()
        alertVC.presentedView_MGRE.build_MGRE(with: AlertData_MGRE(
            with: LocalizationKeys.ready,
            rightBtnText: LocalizationKeys.ok))
        
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .coverVertical
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            window.rootViewController?.present(alertVC, animated: true)
        }
    }
}
