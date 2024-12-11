//
//  CharactersResponseCodable_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Vikas Joshi on 11/12/24.
//

import Foundation

// MARK: - CharactersResponseCodable_MGRE

struct CharactersResponseCodable_MGRE: Codable {
    let characters: CharacterSection_MGRE?

    enum CodingKeys: String, CodingKey {
        case characters = "supxqqoyl3"
    }
}

// MARK: - CharacterSection_MGRE

struct CharacterSection_MGRE: Codable {
    let characters: [String: Character_MGRE]?

    enum CodingKeys: String, CodingKey {
        case characters = "s3pyxa1_"
    }
}

// MARK: - Character_MGRE

struct Character_MGRE: Codable, Hashable, ModelProtocol_MGRE {
    static let type: ContentType_MGRE = .mods_mgre

    let id: String
    let name: String
    let image: String
    let description: String
    let new: Bool
    let top: Bool

    enum CodingKeys: String, CodingKey {
        case name = "36rdu"
        case image = "aa9iigtr"
        case description = "ql745eq_62"
        case new = "isNew"
        case top = "isTop"
    }

    var favId: String { id }
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

        id = UUID().uuidString
        self.name = name
        self.image = "content/6737734a3d155/\(image)"
        self.description = description
        new = entity.new
        top = entity.top
    }

    // Standard Decodable initializer
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
