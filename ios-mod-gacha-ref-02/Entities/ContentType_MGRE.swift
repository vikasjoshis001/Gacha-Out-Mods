//
//  ContentType_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

enum ContentType_MGRE: Int, CaseIterable {
    case editor_mgre = 0,
         mods_mgre,
         outfitIdeas_mgre,
         characters_mgre,
         collections_mgre,
         wallpapers_mgre
    
    var int64_MGRE: Int64 { Int64(rawValue) }
    
    var associatedPath_MGRE: Keys_MGRE.Path_MGRE {
        switch self {
        case .editor_mgre:          return .editor_mgre
        case .mods_mgre:            return .mods_mgre
        case .outfitIdeas_mgre:     return .outfitIdeas_mgre
        case .characters_mgre:      return .characters_mgre
        case .collections_mgre:     return .collections_mgre
        case .wallpapers_mgre:      return .wallpapers_mgre
        }
    }
    
    var cellClass_MGRE: UICollectionViewCell.Type? {
        switch self {
        case .mods_mgre:            return ModsCellNew.self
        case .outfitIdeas_mgre:     return ModsCell_MGRE.self
        case .characters_mgre:      return ContentCell_MGRE.self
        case .collections_mgre:     return ContentCell_MGRE.self
        case .wallpapers_mgre:      return WallpaperCell_MGRE.self
        default: return nil
        }
    }
}
