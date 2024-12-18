//
//  ModsResponseCodable_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Vikas Joshi on 10/12/24.
//

import Foundation

// MARK: - ModsResponseCodable_MGRE

struct ModsResponseCodable_MGRE: Codable {
    let mods: ModsSection_MGRE?

    enum CodingKeys: String, CodingKey {
        case mods = "qqwm"
    }
}

// MARK: - ModsSection_MGRE

struct ModsSection_MGRE: Codable {
    let mods: [String: Mods_MGRE]?

    enum CodingKeys: String, CodingKey {
        case mods = "Mods"
    }
}

// MARK: - Mods_MGRE

struct Mods_MGRE: Codable, Hashable, ModelProtocol_MGRE {    
    static let type: ContentType_MGRE = .mods_mgre

    let id: String
    let name: String
    let image: String
    let description: String
    let filePath: String
    let new: Bool
    let top: Bool

    enum CodingKeys: String, CodingKey {
        case name = "2nx"
        case image = "xgqej-"
        case description = "kdmn8xz3o"
        case filePath = "g2663hwnn"
        case new = "lastAdded"
        case top = "isTop"
    }

    var favId: String { String (id) }
    var searchText: String? { name }

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
        self.image = image
        self.description = description
        self.filePath = filePath
        new = entity.new
        top = entity.top
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = Helper.setIdToFields(decoder: decoder)
        name = try container.decode(String.self, forKey: .name)
        image = try container.decode(String.self, forKey: .image)
        description = try container.decode(String.self, forKey: .description)
        filePath = try container.decode(String.self, forKey: .filePath)
        new = try container.decode(Bool.self, forKey: .new)
        top = try container.decode(Bool.self, forKey: .top)
    }
}

