//
//  Helper.swift
//  ios-mod-gacha-ref-02
//
//  Created by Vikas Joshi on 05/12/24.
//

import Foundation
import UIKit

/* Store for all helper functions used in app. */
struct Helper {
    static func getDeviceType() -> UIUserInterfaceIdiom {
        return UIDevice.current.userInterfaceIdiom
    }
    
    static func setIdToFields(decoder: Decoder) -> String {
        if let key = decoder.codingPath.last?.stringValue {
            return key
        } else {
            return UUID().uuidString
        }
    }
    
    static func deviceSpecificImage(image: String) -> String {
        let device = getDeviceType()
        let ipadString = "Ipad"
        
        return device == .phone ? image : "\(image)\(ipadString)"
    }
    
    static func getBottomInset() -> CGFloat {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first {
            return window.safeAreaInsets.bottom
        }
        return 0
    }
    
    static func getBottomConstraint() -> CGFloat {
        let device = getDeviceType()
        if device == .phone {
            let bottomInset = getBottomInset()
            if bottomInset == 0 {
                return 34
            } else {
                return 0
            }
        }
        return 79.5
    }
}
