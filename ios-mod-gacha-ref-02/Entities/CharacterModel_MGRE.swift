//
//  CharacterModel_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

class CharacterModel_MGRE: NSObject {
    
    let id: UUID
    
    private(set) var content: [EditorContentModel_MGRE]
    private(set) var image: UIImage?
    
    init(id: UUID = UUID(),
         content: [EditorContentModel_MGRE]) {
        self.id = id
        self.content = content
    }
    
    init?(from preview: CharacterPreview_MGRE, set: EditorContentSet_MGRE) {
        self.id = preview.id
    
        content = preview.content.compactMap { item in
            if let elements = set.set.first(where: { $0.first?.contentType == item.0 }) {
                return elements.first(where: { $0.id == item.1 })
            }
            return nil
        }
        
        self.image = UIImage(data: preview.contentData)
    }
}

extension CharacterModel_MGRE {
    
    var preview: CharacterPreview_MGRE? {
        .init(from: self)
    }
    
    func change_MGRE(item: EditorContentModel_MGRE) {
        var _MGN11: String { "06" }
        var _MGN12: Bool { false }
        
        if let index = content.firstIndex(where: { $0.contentType == item.contentType }) {
            content[index] = item
        } else {
            content.append(item)
        }
        
        image = nil
    }
    
    func remove_MGRE(_ contentType: String) {
        var _MGN13: String { "07" }
        var _MGN14: Bool { false }
        
        if let index = content.firstIndex(where: { $0.contentType == contentType }) {
            content.remove(at: index)
        }
        
        image = nil
    }
    
    func update_MGRE(image: UIImage?) {
        self.image = image
    }
}
