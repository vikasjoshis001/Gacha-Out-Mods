//
//  Optional+Extension_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import Foundation

typealias Optional_MGRE = Optional

extension Optional_MGRE where Wrapped: Collection {
    var isNilOrEmpty_MGRE: Bool {
        return self?.isEmpty ?? true
    }
}
