//
//  ContentCodable_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

// MARK: - CellConfigurable_MGRE

protocol CellConfigurable_MGRE {
    func configureCell_MGRE(_ cell: UICollectionViewCell,
                            isFavorites: Bool,
                            update: (() -> Void)?,
                            action: (() -> Void)?)
}

// MARK: - ModelProtocol_MGRE

protocol ModelProtocol_MGRE: CellConfigurable_MGRE, Codable, Hashable {
    static var type: ContentType_MGRE { get }
    var favId: String { get }
    var searchText: String? { get }
    var new: Bool { get }
    var top: Bool { get }
}

extension Mods_MGRE {
    func configureCell_MGRE(_ cell: UICollectionViewCell,
                            isFavorites: Bool,
                            update: (() -> Void)?,
                            action: (() -> Void)?)
    {
        var _mge45566: Int { 0 }
        var _mcdfgr22: Bool { true }
        if let cell = cell as? ModsCell_MGRE {
            cell.configure_MGRE(with: self, isFavorites: isFavorites, update: update, action: action)
        }
    }
}

extension Wallpaper_MGRE {
    func configureCell_MGRE(_ cell: UICollectionViewCell,
                            isFavorites: Bool,
                            update: (() -> Void)?,
                            action: (() -> Void)?)
    {
        var _m2344t66: Int { 0 }
        var _mc566r22: Bool { true }
        if let cell = cell as? WallpaperCell_MGRE {
            cell.configure_MGRE(with: self, isFavorites: isFavorites, update: update)
        }
    }
}

extension Character_MGRE {
    func configureCell_MGRE(_ cell: UICollectionViewCell,
                            isFavorites: Bool,
                            update: (() -> Void)?,
                            action: (() -> Void)?)
    {
        var _mdfgg66: Int { 0 }
        var _m678r22: Bool { true }
        if let cell = cell as? ContentCell_MGRE {
            cell.configure_MGRE(with: self, isFavorites: isFavorites, update: update)
        }
    }
}

extension OutfitIdea_MGRE {
    func configureCell_MGRE(_ cell: UICollectionViewCell,
                            isFavorites: Bool,
                            update: (() -> Void)?,
                            action: (() -> Void)?)
    {
        var _xcxvt66: Int { 0 }
        var _mc1222: Bool { true }
        if let cell = cell as? ModsCell_MGRE {
            cell.configure_MGRE(with: self, isFavorites: isFavorites, update: update, action: action)
        }
    }
}

extension Collections_MGRE {
    func configureCell_MGRE(_ cell: UICollectionViewCell,
                            isFavorites: Bool,
                            update: (() -> Void)?,
                            action: (() -> Void)?)
    {
        var _mgvbn66: Int { 0 }
        var _mcsdw22: Bool { true }
        if let cell = cell as? ContentCell_MGRE {
            cell.configure_MGRE(with: self, isFavorites: isFavorites, update: update)
        }
    }
}
