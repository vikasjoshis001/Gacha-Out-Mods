//
//  MenuItem_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

// MARK: - MenuItem_MGRE

enum MenuItem_MGRE: String, CaseIterable {
    case wallpapers_MGRE
    case mods_MGRE
    case characters_MGRE
    case collections_MGRE
    case editor_MGRE
    case outfitIdeas_MGRE
    case favorites_MGRE
}

extension MenuItem_MGRE {
    var localizedTitle: String {
        switch self {
        case .wallpapers_MGRE:
            return LocalizationKeys.wallpapers_MGRE
        case .mods_MGRE:
            return LocalizationKeys.mods_MGRE
        case .characters_MGRE:
            return LocalizationKeys.characters_MGRE
        case .collections_MGRE:
            return LocalizationKeys.collections_MGRE
        case .editor_MGRE:
            return LocalizationKeys.editor_MGRE
        case .outfitIdeas_MGRE:
            return LocalizationKeys.outfitIdeas_MGRE
        case .favorites_MGRE:
            return LocalizationKeys.favorites_MGRE
        }
    }
}
