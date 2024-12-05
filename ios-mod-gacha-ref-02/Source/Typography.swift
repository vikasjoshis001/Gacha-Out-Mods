//
//  Typography.swift
//  ios-mod-gacha-ref-02
//
//  Created by Vikas Joshi on 04/12/24.
//

import Foundation
import UIKit

/* A struct to store all typography used in the app. */
enum Typography {
    static let heading = UIFont(name: StringConstants.ptSansRegular,
                                size: 20) ??
        UIFont.systemFont(ofSize: 50,
                          weight: .bold)
}
