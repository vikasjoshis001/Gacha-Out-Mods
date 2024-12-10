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

// MARK: - Mods_MGRE

// struct ModsResponseCodable_MGRE: Codable {
//    let list: [Mods_MGRE]
//
//    enum CodingKeys_MGRE: String, CodingKey {
//        case list = "qqwm"
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys_MGRE.self)
//        self.list = try container.decode([Mods_MGRE].self, forKey: .list)
//    }
// }
//
// struct Mods_MGRE: Codable, ModelProtocol_MGRE {
//    static let type: ContentType_MGRE = .mods_mgre
//    let id: Int
//    let name: String
//    let image: String
//    let description: String
//    let filePath: String
//    let new: Bool
//    let top: Bool
//
//    var favId: String { String(id) }
//    var searchText: String? { name }
//
//    enum CodingKeys_MGRE: String, CodingKey {
//        case id = "id", name = "2nx", image = "xgqej-", description = "kdmn8xz3o",
//             new = "lastAdded", top = "isTop", filePath = "g2663hwnn"
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys_MGRE.self)
//        self.id = try container.decode(Int.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.image = try container.decode(String.self, forKey: .image)
//        self.description = try container.decode(String.self, forKey: .description)
//        self.new = Bool(try container.decode(String.self, forKey: .new)) ?? false
//        self.top = Bool(try container.decode(String.self, forKey: .top)) ?? false
//        self.filePath = try container.decode(String.self, forKey: .filePath)
//    }
//
//    init?(from entity: ContentEntity) {
//        guard let id = entity.id,
//              let name = entity.name,
//              let image = entity.image,
//              let description = entity.descr,
//              let filePath = entity.filePath else { return nil }
//        self.id = Int(id) ?? 0
//        self.name = name
//        self.image = image
//        self.description = description
//        self.filePath = filePath
//        self.new = entity.new
//        self.top = entity.top
//    }
// }

// struct ModsResponseCodable_MGRE: Codable {
//    let mods: [Mods_MGRE]
//
//    enum CodingKeys: String, CodingKey {
//        case mods = "qqwm"
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        debugPrint("Mods Container 1 are = ", container)
//        let modsContainer = try container.decode([String: [String: Mods_MGRE]].self, forKey: .mods)
//        debugPrint("Mods Container 2 are = ", modsContainer)
//        self.mods = modsContainer["Mods"]?.map { _, mod in mod } ?? []
//        debugPrint("Block Mods are = ", mods)
//    }
// }

struct Mods_MGRE: Codable, Hashable, ModelProtocol_MGRE {
    static let type: ContentType_MGRE = .mods_mgre

    let id: String
    let name: String
    let image: String
    let description: String
    let filePath: String
    let new: Bool
    let top: Bool

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }

    static func == (lhs: Mods_MGRE, rhs: Mods_MGRE) -> Bool {
        return lhs.name == rhs.name &&
            lhs.image == rhs.image &&
            lhs.description == rhs.description
            && lhs.id == rhs.id
    }

//    var favId: String { String(id) }
    var favId: String { id }
    var searchText: String? { name }

    enum CodingKeys: String, CodingKey {
        case id, name = "2nx", image = "xgqej-",
             description = "kdmn8xz3o", new = "lastAdded",
             top = "isTop", filePath = "g2663hwnn"
    }

    init?(from entity: ContentEntity) {
        guard
            let name = entity.name,
            let image = entity.image,
            let description = entity.descr,
            let filePath = entity.filePath
        else {
            return nil
        }

        self.id = UUID().uuidString
        self.name = name
        self.image = "content/6737730ea7e31/\(image)"
        self.description = description
        self.filePath = filePath
        self.new = entity.new
        self.top = entity.top
    }
}

// MARK: - WallpapersListCodable_MGRE

struct WallpapersListCodable_MGRE: Codable {
    let list: [Wallpaper_MGRE]

    enum CodingKeys_MGRE: String, CodingKey {
        case list = "m6yr"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGRE.self)
        self.list = try container.decode([Wallpaper_MGRE].self, forKey: .list)
    }
}

// MARK: - Wallpaper_MGRE

struct Wallpaper_MGRE: Codable, ModelProtocol_MGRE {
    static let type: ContentType_MGRE = .wallpapers_mgre
    let id: String
    let image: String
    var new: Bool
    let top: Bool

    var favId: String { id }
    var searchText: String? { nil }

    enum CodingKeys_MGRE: String, CodingKey {
        case new = "isNew", top = "1cxwc4", image = "e7wu46os-q", id = "1cei1"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGRE.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.new = try Bool(container.decode(String.self, forKey: .new)) ?? false
        self.top = try Bool(container.decode(String.self, forKey: .top)) ?? false
        self.image = try container.decode(String.self, forKey: .image)
    }

    init?(from entity: ContentEntity) {
        guard let id = entity.id,
              let image = entity.image else { return nil }
        self.id = id
        self.image = image
        self.new = entity.new
        self.top = entity.top
    }
}

// MARK: - CharactersResponseCodable_MGRE

struct CharactersResponseCodable_MGRE: Codable {
    let list: [Character_MGRE]

    enum CodingKeys_MGRE: String, CodingKey {
        case list = "supxqqoyl3"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGRE.self)
        self.list = try container.decode([Character_MGRE].self, forKey: .list)
    }
}

// MARK: - Character_MGRE

struct Character_MGRE: Codable, ModelProtocol_MGRE {
    static let type: ContentType_MGRE = .characters_mgre
    let id: Int
    let image: String
//    let description: String
    let new: Bool
    let top: Bool

    var favId: String { String(id) }
    var searchText: String? { nil /* description */ }

    enum CodingKeys_MGRE: String, CodingKey {
        case id = "dr6sg6i1", image = "aa9iigtr", new = "isNew", top = "isTop" // , description = "dr6sg6t3"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGRE.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.image = try container.decode(String.self, forKey: .image)
        self.new = try Bool(container.decode(String.self, forKey: .new)) ?? false
        self.top = try Bool(container.decode(String.self, forKey: .top)) ?? false
//        self.description = try container.decode(String.self, forKey: .description)
    }

    init?(from entity: ContentEntity) {
        guard let id = entity.id,
              let image = entity.image /* ,
               let description = entity.descr */ else { return nil }
        self.id = Int(id) ?? 0
        self.image = image
        self.new = entity.new
        self.top = entity.top
//        self.description = description
    }
}

// MARK: - OutfitIdeasListCodable_MGRE

struct OutfitIdeasListCodable_MGRE: Codable {
    let list: [OutfitIdea_MGRE]

    enum CodingKeys_MGRE: String, CodingKey {
        case list = "km8rncdgy"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGRE.self)
        self.list = try container.decode([OutfitIdea_MGRE].self, forKey: .list)
    }
}

// MARK: - OutfitIdea_MGRE

struct OutfitIdea_MGRE: Codable, ModelProtocol_MGRE {
    static let type: ContentType_MGRE = .outfitIdeas_mgre
    let id: Int
    let image: String
//    let description: String
    let new: Bool
    let top: Bool

    var favId: String { String(id) }
    var searchText: String? { nil /* description */ }

    enum CodingKeys_MGRE: String, CodingKey {
        case id = "eg-d4", image = "pgnri4mc", new = "isNew", top = "isTop" // , description = "eg-t3"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGRE.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.image = try container.decode(String.self, forKey: .image)
        self.new = try Bool(container.decode(String.self, forKey: .new)) ?? false
        self.top = try Bool(container.decode(String.self, forKey: .top)) ?? false
//        self.description = try container.decode(String.self, forKey: .description)
    }

    init?(from entity: ContentEntity) {
        guard let id = entity.id,
              let image = entity.image /* ,
               let description = entity.descr */ else { return nil }
        self.id = Int(id) ?? 0
        self.image = image
        self.new = entity.new
        self.top = entity.top
//        self.description = description
    }
}

// MARK: - CollectionsListCodable_MGRE

struct CollectionsListCodable_MGRE: Codable {
    let list: [Collections_MGRE]

    enum CodingKeys_MGRE: String, CodingKey {
        case list = "d9otsrt"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGRE.self)
        self.list = try container.decode([Collections_MGRE].self, forKey: .list)
    }
}

// MARK: - Collections_MGRE

struct Collections_MGRE: Codable, ModelProtocol_MGRE {
    static let type: ContentType_MGRE = .collections_mgre
    let id: Int
    let image: String
//    let description: String
    let new: Bool
    let top: Bool

    var favId: String { String(id) }
    var searchText: String? { nil /* description */ }

    enum CodingKeys_MGRE: String, CodingKey {
        case id = "9szf2", image = "9szt3", new = "isNew", top // , description = "9szd4"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGRE.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.image = try container.decode(String.self, forKey: .image)
        self.new = try container.decode(Bool.self, forKey: .new)
        self.top = try container.decode(Bool.self, forKey: .top)
//        self.description = try container.decode(String.self, forKey: .description)
    }

    init?(from entity: ContentEntity) {
        guard let id = entity.id,
              let image = entity.image /* ,
               let description = entity.descr */ else { return nil }
        self.id = Int(id) ?? 0
        self.image = image
        self.new = entity.new
        self.top = entity.top
//        self.description = description
    }
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
