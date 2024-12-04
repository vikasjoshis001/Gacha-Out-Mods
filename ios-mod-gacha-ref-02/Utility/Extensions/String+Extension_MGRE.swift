//
//  String+Extension_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Vikas Joshi on 04/12/24.
//

import Foundation

extension String {
    // Method to get the localized version of the string
    func localized() -> String {
        let localizedString = NSLocalizedString(self, comment: "")

        if localizedString == self {
            let fallbackBundle = Bundle.main.path(forResource: "en", ofType: "lproj").flatMap { Bundle(path: $0) }
            return fallbackBundle?.localizedString(forKey: self, value: nil, table: nil) ?? self
        }

        return localizedString
    }
}
