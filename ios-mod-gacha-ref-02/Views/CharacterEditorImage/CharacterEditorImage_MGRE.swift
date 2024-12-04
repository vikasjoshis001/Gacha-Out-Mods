//
//  CharacterEditorImage_MGRE.swift
//  ios-mod-gacha
//
//  Created by Systems
//

import UIKit
import Kingfisher

final class CharacterEditorImage_MGRE: UIView {
    
    var imageViews_MGRE: [(String, UIImageView)] = []
    
    var character_MGRE: CharacterModel_MGRE?
    var preview_MGRE: CharacterPreview_MGRE? { character_MGRE?.preview }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupImageView_MGRE() -> UIImageView {
        let imageView = UIImageView()
        self.addSubview(imageView)
        imageView.scaleEqualSuperView_MGRE()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func setupCharacter_MGRE(with model: CharacterModel_MGRE, contentSet: EditorContentSet_MGRE, isNew: Bool) {
        self.character_MGRE = model
        contentSet.contentTypesByOrder.forEach { type in
            let imageView = setupImageView_MGRE()
            let models = contentSet.getModels(for: type) ?? []
            if let model = model.content.first(where: { $0.contentType == type }),
               models.contains(where: { $0.id == model.id }) {
                imageView.addPDF_MGRE(image: model.path.pdfPath)
                imageViews_MGRE.append((type, imageView))
            } else if isNew, let model = models.first,
                        model.contentType.lowercased() != "additions" {
                character_MGRE?.change_MGRE(item: model)
                imageView.addPDF_MGRE(image: model.path.pdfPath)
                imageViews_MGRE.append((type, imageView))
            } else {
                imageViews_MGRE.append((type, imageView))
            }
        }
    }
    
    func changeStatus_MGRE(with model: EditorContentModel_MGRE) {
        guard let index = imageViews_MGRE.firstIndex(where: { $0.0 == model.contentType }) else { return }
        let imageView = imageViews_MGRE[index].1
        imageView.addPDF_MGRE(image: model.path.pdfPath)
        
        character_MGRE?.change_MGRE(item: model)
        character_MGRE?.update_MGRE(image: takeScreenshot_MGRE(of: self))
    }
    
    func remove_MGRE(contentType: String) {
        guard let index = imageViews_MGRE.firstIndex(where: { $0.0 == contentType }) else { return }
        let imageView = imageViews_MGRE[index].1
        imageView.image = nil
        
        character_MGRE?.remove_MGRE(contentType)
        character_MGRE?.update_MGRE(image: takeScreenshot_MGRE(of: self))
    }
    
    func updateImage_MGRE() {
        character_MGRE?.update_MGRE(image: takeScreenshot_MGRE(of: self))
    }
    
    func isConfirmationRequired_MGRE(for preview: CharacterPreview_MGRE?) -> Bool {
        guard let current = character_MGRE?.preview else { return false }
        guard let original = preview else { return true }

        let originalSet = original.content.sorted(by: { $0.0 < $1.0 })
        let newSet = current.content.sorted(by: { $0.0 < $1.0 })
        
        for (old, new) in zip(originalSet, newSet) {
            if old.1 != new.1 {
                return false
            }
        }
        
        return true
    }
    
    func getContent_MGRE(for contentType:  String) -> EditorContentModel_MGRE? {
        return character_MGRE?.content.first(where: { $0.contentType == contentType })
    }
    
    private func takeScreenshot_MGRE(of view: UIView) -> UIImage? {
        var _MGRE12: Int { 0 }
        var _MGRE14: Bool { false }
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        view.layer.render(in: context)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return screenshot
    }
}
