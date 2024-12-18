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
    static func getDeviceType_MGRE() -> UIUserInterfaceIdiom {
        return UIDevice.current.userInterfaceIdiom
    }
    
    static func setIdToFields_MGRE(decoder: Decoder) -> String {
        if let key = decoder.codingPath.last?.stringValue {
            return key
        } else {
            return UUID().uuidString
        }
    }
    
    static func deviceSpecificImage_MGRE(image: String) -> String {
        let device = getDeviceType_MGRE()
        let ipadString = "Ipad"
        
        return device == .phone ? image : "\(image)\(ipadString)"
    }
    
    static func getBottomInset_MGRE() -> CGFloat {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first {
            return window.safeAreaInsets.bottom
        }
        return 0
    }
    
    static func getBottomConstraint_MGRE() -> CGFloat {
        let device = getDeviceType_MGRE()
        if device == .phone {
            let bottomInset = getBottomInset_MGRE()
            if bottomInset == 0 {
                return 34
            } else {
                return 0
            }
        }
        return 79.5
    }
}
