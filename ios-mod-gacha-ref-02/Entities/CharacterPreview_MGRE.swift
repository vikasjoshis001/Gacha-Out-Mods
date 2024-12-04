//
//  CharacterPreview_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

final class CharacterPreview_MGRE: Hashable {
    
    let id: UUID
    let contentData: Data
    let content: [String: String]
    
    init(id: UUID,
         contentData: Data,
         content: [String: String]) {
        self.id = id
        self.contentData = contentData
        self.content = content
    }
    
    init?(from model: CharacterModel_MGRE) {
        guard let contentData = model.image?.pngData() else { return nil }
        self.id = model.id
        self.contentData = contentData
        self.content = model.content.reduce(into: [String: String]()) { (result, object) in
            result[object.contentType] = object.id
        }
    }
    
    static func == (lhs: CharacterPreview_MGRE,
                    rhs: CharacterPreview_MGRE) -> Bool {
        lhs.id == rhs.id
    }
    
    init?(from entity: CharacterEntity) {
        guard let id = entity.id,
              let content = entity.content,
              let contentData = entity.contentData else { return nil }
        
        self.id = id
        self.content = content
        self.contentData = contentData
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var image: UIImage? { .init(data: contentData) }
}
