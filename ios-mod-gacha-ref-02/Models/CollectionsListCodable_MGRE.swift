//
//  CollectionsListCodable_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Vikas Joshi on 11/12/24.
//

import Foundation

// MARK: - CollectionsListCodable_MGRE

struct CollectionsListCodable_MGRE: Codable {
    let collections: CollectionsSection_MGRE?

    enum CodingKeys: String, CodingKey {
        case collections = "d9otsrt"
    }
}

// MARK: - CollectionsSection_MGRE

struct CollectionsSection_MGRE: Codable {
    let collections: [String: Collections_MGRE]?

    enum CodingKeys: String, CodingKey {
        case collections = "8lkd"
    }
}

// MARK: - Collections_MGRE

struct Collections_MGRE: Codable, Hashable, ModelProtocol_MGRE {
    static let type: ContentType_MGRE = .collections_mgre

    let id: String
    let name: String
    let image: String
    let new: Bool
    let top: Bool

    enum CodingKeys: String, CodingKey {
        case name = "-c-4b_hx7u"
        case image = "h76bk"
        case new = "isNew"
        case top = "isPopular"
    }

    var favId: String { String (id) }
    var searchText: String? { name }

    init?(from entity: ContentEntity) {
        guard
            let name = entity.name,
            let image = entity.image
        else {
            return nil
        }

        id = UUID().uuidString
        self.name = name
        self.image = image
        new = entity.new
        top = entity.top
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = Helper.setIdToFields(decoder: decoder)
        name = try container.decode(String.self, forKey: .name)
        image = try container.decode(String.self, forKey: .image)
        new = try container.decode(Bool.self, forKey: .new)
        top = try container.decode(Bool.self, forKey: .top)
    }
}
