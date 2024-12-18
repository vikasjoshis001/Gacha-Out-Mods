//
//  OutfitIdeasListCodable_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Vikas Joshi on 11/12/24.
//

import Foundation

// MARK: - OutfitIdeasListCodable_MGRE

struct OutfitIdeasListCodable_MGRE: Codable {
    let outfits: OutfitSection_MGRE?

    enum CodingKeys: String, CodingKey {
        case outfits = "km8rncdgy"
    }
}

// MARK: - OutfitSection_MGRE

struct OutfitSection_MGRE: Codable {
    let outfits: [String: OutfitIdea_MGRE]?

    enum CodingKeys: String, CodingKey {
        case outfits = "63c"
    }
}

// MARK: - OutfitIdea_MGRE

struct OutfitIdea_MGRE: Codable, Hashable, ModelProtocol_MGRE {
    static let type: ContentType_MGRE = .outfitIdeas_mgre

    let id: String
    let name: String
    let image: String
    let description: String
    let new: Bool
    let top: Bool

    enum CodingKeys: String, CodingKey {
        case name = "qnbxc5im"
        case image = "pgnri4mc"
        case description = "btyp5ukd"
        case new = "isNew"
        case top = "isTop"
    }

    var favId: String { String (id) }
    var searchText: String? { name }

    init?(from entity: ContentEntity) {
        guard
            let name = entity.name,
            let image = entity.image,
            let description = entity.descr
        else {
            return nil
        }

        id = UUID().uuidString
        self.name = name
        self.image = image
        self.description = description
        new = entity.new
        top = entity.top
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = Helper.setIdToFields(decoder: decoder)
        name = try container.decode(String.self, forKey: .name)
        image = try container.decode(String.self, forKey: .image)
        description = try container.decode(String.self, forKey: .description)
        new = try container.decode(Bool.self, forKey: .new)
        top = try container.decode(Bool.self, forKey: .top)
    }
}
