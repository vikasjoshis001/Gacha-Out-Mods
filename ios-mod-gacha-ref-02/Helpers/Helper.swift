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
}
