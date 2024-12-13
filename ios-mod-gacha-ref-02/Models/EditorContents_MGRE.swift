////
////  EditorContentModel_MGRE.swift
////  ios-mod-gacha-ref-02
////
////  Created by Vikas Joshi on 12/12/24.
////
//
//import Foundation
//
struct EditorContents: Codable {
    let rvn3a20vig: EditorCategories // jsonKey
    
    enum CodingKeys: String, CodingKey {
        case rvn3a20vig
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        rvn3a20vig = try container.decode(EditorCategories.self, forKey: .rvn3a20vig)
    }
}

struct EditorCategories: Codable {
    let accessory: [String: EditorItems]
    let shoes: [String: EditorItems]
    let eyebrow: [String: EditorItems]
    let nose: [String: EditorItems]
    let mouth: [String: EditorItems]
    let top: [String: EditorItems]
    let body: [String: EditorItems]
    let eyes: [String: EditorItems]
    let bottom: [String: EditorItems]
    let hair: [String: EditorItems]
    
    enum CodingKeys: String, CodingKey {
        case accessory = "Accessory"
        case shoes = "Shoes"
        case eyebrow = "Eyebrow"
        case nose = "Nose"
        case mouth = "Mouth"
        case top = "Top"
        case body = "Body"
        case eyes = "Eyes"
        case bottom = "Bottom"
        case hair = "Hair"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        accessory = try container.decodeIfPresent([String: EditorItems].self, forKey: .accessory) ?? [:]
        shoes = try container.decodeIfPresent([String: EditorItems].self, forKey: .shoes) ?? [:]
        eyebrow = try container.decodeIfPresent([String: EditorItems].self, forKey: .eyebrow) ?? [:]
        nose = try container.decodeIfPresent([String: EditorItems].self, forKey: .nose) ?? [:]
        mouth = try container.decodeIfPresent([String: EditorItems].self, forKey: .mouth) ?? [:]
        top = try container.decodeIfPresent([String: EditorItems].self, forKey: .top) ?? [:]
        body = try container.decodeIfPresent([String: EditorItems].self, forKey: .body) ?? [:]
        eyes = try container.decodeIfPresent([String: EditorItems].self, forKey: .eyes) ?? [:]
        bottom = try container.decodeIfPresent([String: EditorItems].self, forKey: .bottom) ?? [:]
        hair = try container.decodeIfPresent([String: EditorItems].self, forKey: .hair) ?? [:]
    }
}

struct EditorItems: Codable {
    let gender: String
    let isPopular: Bool
    let isNew: Bool
    let thumbnail: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case gender = "a8c20" // BodyType
        case isPopular
        case isNew
        case thumbnail = "_sqryzo-" // skinEditorImage
        case image = "ab7bx" // skinEditorPreview
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        gender = try container.decode(String.self, forKey: .gender)
        isPopular = try container.decode(Bool.self, forKey: .isPopular)
        isNew = try container.decode(Bool.self, forKey: .isNew)
        thumbnail = try container.decode(String.self, forKey: .thumbnail)
        image = try container.decode(String.self, forKey: .image)
    }
}
