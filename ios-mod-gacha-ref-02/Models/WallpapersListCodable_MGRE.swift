//
//  WallpapersListCodable_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Vikas Joshi on 10/12/24.
//

import Foundation

// MARK: - WallpapersListCodable_MGRE

struct WallpapersListCodable_MGRE: Codable {
    let wallpapers: WallpapersSection_MGRE?

    enum CodingKeys: String, CodingKey {
        case wallpapers = "m6yr"
    }
}

// MARK: - WallpapersSection_MGRE

struct WallpapersSection_MGRE: Codable {
    let wallpapers: [String: Wallpaper_MGRE]?

    enum CodingKeys: String, CodingKey {
        case wallpapers = "m8r7s1u"
    }
}

// MARK: - Wallpaper_MGRE

struct Wallpaper_MGRE: Codable, Hashable, ModelProtocol_MGRE {
    static let type: ContentType_MGRE = .wallpapers_mgre
    let id: String
    let image: String
    var new: Bool
    let top: Bool

//    var favId: String { id }
    var favId: String { id }
    var searchText: String? { nil }

    enum CodingKeys_MGRE: String, CodingKey {
        case new = "isNew",
             top = "isPopular",
             image = "e7wu46os-q"
    }
    
    init?(from entity: ContentEntity) {
        guard let image = entity.image else { return nil }
        self.id = UUID().uuidString
        self.image = "content/6737731c09cad/\(image)"
        self.new = entity.new
        self.top = entity.top
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGRE.self)
        
        id = Helper.setIdToFields(decoder: decoder)
        new = try container.decode(Bool.self, forKey: .new)
        top = try container.decode(Bool.self, forKey: .top)
        image = try container.decode(String.self, forKey: .image)
    }
}
