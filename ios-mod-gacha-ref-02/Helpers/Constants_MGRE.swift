//
//  Constants_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

enum Images_MGRE: String {
    case menuChevron
    case menuChevronBlack
    
    case menuIcon
    case searchIcon
    case backChevronIcon
    case closeIcon
    case deleteIcon
    case doneIcon
    
    case favoriteIconEmpty
    case favoriteIcon
    case heartIcon
    case heartIconEmpty
    
    case chevronTopIcon
    case chevronBottomIcon
    
    case deleteLargeIcon
}

extension UIImage_MGRE {
    convenience init?(_ name: Images_MGRE, in bundle: Bundle = Bundle.main) {
        self.init(named: name.rawValue, in: bundle, compatibleWith: nil)
    }
}
