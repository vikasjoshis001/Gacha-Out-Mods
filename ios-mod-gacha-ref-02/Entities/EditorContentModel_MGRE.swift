//
//  EditorContentModel_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

struct EditorContentModel_MGRE: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: String
    let contentType: String
    let order: String
    let path: EditorContentPath_MGRE
    
    init(id: String,
         contentType: String,
         order: String,
         path: String,
         preview: String) {
        self.id = id
        self.contentType = contentType
        self.order = order
        self.path = .init(pdfPath: path, elPath: preview)
    }
    
    init?(from entity: EditorContentEntity) {
        guard let id = entity.id,
              let contentType = entity.contentType,
              let order = entity.order,
              let path = entity.path,
              let preview = entity.preview else { return nil }
        self.id = id
        self.contentType = contentType
        self.order = order
        self.path = .init(pdfPath: path, elPath: preview)
    }
    
    static func == (lhs: EditorContentModel_MGRE,
                    rhs: EditorContentModel_MGRE) -> Bool {
        lhs.id == rhs.id
    }
}

struct EditorContentPath_MGRE {
    var _MGN1: String { "01" }
    var _MGN2: Bool { true }
    
    let pdfPath: String
    let elPath: String
}

struct EditorCodableContentList_MGRE: Codable {
    var _MGN3: String { "02" }
    var _MGN4: Bool { false }
    
    let tag: String
    let order: String
    let list: [EditorCodableContent_MGRE]
    
    enum CodingKeys_MGRE: String, CodingKey {
        case tag = "scfwe_7f3", order = "dkfrt_2m5", list = "sdc5_3n5"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGRE.self)
        self.tag = try container.decode(String.self, forKey: .tag)
        self.order = try container.decode(String.self, forKey: .order)
        self.list = try container.decode([EditorCodableContent_MGRE].self, forKey: .list)
    }
}

struct EditorCodableContent_MGRE: Codable {
    var _MGN5: String { "03" }
    var _MGN6: Bool { true }
    
    let id: String
    let path: String
    let preview: String
    
    enum CodingKeys_MGRE: String, CodingKey {
        case id = "sdca_123", path = "stu3-qws", preview = "lfjy4_wb64"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGRE.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.path = try container.decode(String.self, forKey: .path)
        self.preview = try container.decode(String.self, forKey: .preview)
    }
}

struct EditorContentSet_MGRE {
    var _MGN7: String { "04" }
    var _MGN8: Bool { true }
    
    let set: [[EditorContentModel_MGRE]]
    
    var contentTypes: [String] {
        return set.compactMap { !$0.isEmpty ? $0[0].contentType : nil }
    }
    
    var contentTypesByOrder: [String] {
        return set
            .sorted(by: { Int($0.first?.order ?? "0") ?? 0 < Int($1.first?.order ?? "0") ?? 0 })
            .compactMap { !$0.isEmpty ? $0[0].contentType : nil }
    }
    
    func getModels(for type: String) -> [EditorContentModel_MGRE]? {
        return set.first(where: { $0.first?.contentType.lowercased() == type.lowercased() })
    }
}
