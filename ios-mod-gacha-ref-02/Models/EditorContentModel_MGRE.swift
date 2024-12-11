////
////  EditorContentModel_MGRE.swift
////  ios-mod-gacha-ref-02
////
////  Created by Vikas Joshi on 12/12/24.
////
//
//import Foundation
//
//struct EditorContentModel_MGRE: Codable {
//    let rvn3a20vig: Categories
//    let metadata: Metadata
//    
//    enum CodingKeys: String, CodingKey {
//        case rvn3a20vig
//        case metadata = "0"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        rvn3a20vig = try container.decode(Categories.self, forKey: .rvn3a20vig)
//        metadata = try container.decode(Metadata.self, forKey: .metadata)
//    }
//}
//
//struct Categories: Codable {
//    let accessory: [String: Item]
//    let shoes: [String: Item]
//    let eyebrow: [String: Item]
//    let nose: [String: Item]
//    let mouth: [String: Item]
//    let top: [String: Item]
//    let body: [String: Item]
//    let eyes: [String: Item]
//    let bottom: [String: Item]
//    let hair: [String: Item]
//    
//    enum CodingKeys: String, CodingKey {
//        case accessory = "Accessory"
//        case shoes = "Shoes"
//        case eyebrow = "Eyebrow"
//        case nose = "Nose"
//        case mouth = "Mouth"
//        case top = "Top"
//        case body = "Body"
//        case eyes = "Eyes"
//        case bottom = "Bottom"
//        case hair = "Hair"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        accessory = try container.decodeIfPresent([String: Item].self, forKey: .accessory) ?? [:]
//        shoes = try container.decodeIfPresent([String: Item].self, forKey: .shoes) ?? [:]
//        eyebrow = try container.decodeIfPresent([String: Item].self, forKey: .eyebrow) ?? [:]
//        nose = try container.decodeIfPresent([String: Item].self, forKey: .nose) ?? [:]
//        mouth = try container.decodeIfPresent([String: Item].self, forKey: .mouth) ?? [:]
//        top = try container.decodeIfPresent([String: Item].self, forKey: .top) ?? [:]
//        body = try container.decodeIfPresent([String: Item].self, forKey: .body) ?? [:]
//        eyes = try container.decodeIfPresent([String: Item].self, forKey: .eyes) ?? [:]
//        bottom = try container.decodeIfPresent([String: Item].self, forKey: .bottom) ?? [:]
//        hair = try container.decodeIfPresent([String: Item].self, forKey: .hair) ?? [:]
//    }
//}
//
//struct Item: Codable {
//    let gender: String
//    let isPopular: Bool
//    let isNew: Bool
//    let thumbnail: String
//    let image: String
//    
//    enum CodingKeys: String, CodingKey {
//        case gender = "a8c20"
//        case isPopular
//        case isNew
//        case thumbnail = "_sqryzo-"
//        case image = "ab7bx"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        gender = try container.decode(String.self, forKey: .gender)
//        isPopular = try container.decode(Bool.self, forKey: .isPopular)
//        isNew = try container.decode(Bool.self, forKey: .isNew)
//        thumbnail = try container.decode(String.self, forKey: .thumbnail)
//        image = try container.decode(String.self, forKey: .image)
//    }
//}
//
//struct Metadata: Codable {
//    let fil: String
//    let ekl: String
//    let w2nd8l8a: String
//    let ut82sg: String
//    let azgz495c9: String
//    let pdui74: String
//    let z72b: String
//    let wbv: String
//    let ea2tuz: String
//    let y272427: String
//    
//    enum CodingKeys: String, CodingKey {
//        case fil = "4fil"
//        case ekl
//        case w2nd8l8a = "30w2nd8l8a"
//        case ut82sg = "zut82sg"
//        case azgz495c9 = "qazgz495c9"
//        case pdui74 = "3pdui74"
//        case z72b = "799z72b"
//        case wbv = "dwbv"
//        case ea2tuz = "eea2tuz"
//        case y272427 = "gy272427"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        fil = try container.decode(String.self, forKey: .fil)
//        ekl = try container.decode(String.self, forKey: .ekl)
//        w2nd8l8a = try container.decode(String.self, forKey: .w2nd8l8a)
//        ut82sg = try container.decode(String.self, forKey: .ut82sg)
//        azgz495c9 = try container.decode(String.self, forKey: .azgz495c9)
//        pdui74 = try container.decode(String.self, forKey: .pdui74)
//        z72b = try container.decode(String.self, forKey: .z72b)
//        wbv = try container.decode(String.self, forKey: .wbv)
//        ea2tuz = try container.decode(String.self, forKey: .ea2tuz)
//        y272427 = try container.decode(String.self, forKey: .y272427)
//    }
//}
