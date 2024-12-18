//
//  CharacterEditorImage_MGRE.swift
//  ios-mod-gacha
//
//  Created by Systems
//

import Kingfisher
import UIKit

// MARK: - CharacterEditorImage_MGRE

final class CharacterEditorImage_MGRE: UIView {
    // MARK: - Properties

    private var characterParts_MGRE: [(type: String, image: UIImage)] = []
    private var imageView_MGRE: UIImageView!
    private var combinedImage_MGRE: UIImage?
    
    var imageViews_MGRE: [(String, UIImageView)] = []
    var character_MGRE: CharacterModel_MGRE?
    var preview_MGRE: CharacterPreview_MGRE? { character_MGRE?.preview }
    
    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Helpers

    func setupImageView_MGRE() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        // Set imageView to fill the container
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        imageView.contentMode = .scaleAspectFill
        self.imageView_MGRE = imageView
        return imageView
    }
    
    private let partPositions_MGRE: [String: CGRect] = [
        "body": CGRect(x: 0, y: 0, width: 500, height: 500), // Base layer
        "bottom": CGRect(x: 150, y: 300, width: 200, height: 150), // Lower body area
        "shoes": CGRect(x: 150, y: 400, width: 200, height: 100), // Feet area
        "top": CGRect(x: 150, y: 200, width: 200, height: 200), // Upper body area
        "hair": CGRect(x: 150, y: 10, width: 300, height: 150), // Top of head
        "eyes": CGRect(x: 150, y: 150, width: 200, height: 50), // Middle of face
        "eyebrow": CGRect(x: 150, y: 130, width: 200, height: 30), // Above eyes
        "nose": CGRect(x: 200, y: 200, width: 100, height: 50), // Center of face
        "mouth": CGRect(x: 175, y: 250, width: 150, height: 50), // Below nose
        "accessory": CGRect(x: 100, y: 100, width: 300, height: 300), // General accessories
    ]
    
    // MARK: - Functions

    func addBodyPart_MGRE(from data: Data, type: String) {
        guard let partImage = UIImage(data: data) else { return }
        
        characterParts_MGRE.removeAll { $0.type == type }
        imageViews_MGRE.removeAll { $0.0 == type }

        let partView = UIImageView(image: partImage)
        partView.contentMode = .scaleAspectFit
        
        imageViews_MGRE.append((type, partView))
        characterParts_MGRE.append((type: type, image: partImage))
        
        combineImages_MGRE()
    }
        
    func createCharacterToSave_MGRE() -> UIImage? {
        combineImages_MGRE()
        return combinedImage_MGRE
    }
    
    private func combineImages_MGRE() {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 500, height: 500), false, 0.0)
        
        let drawingOrder = ["body",
                            "hair",
                            "bottom",
                            "shoes",
                            "top",
                            "eyes",
                            "eyebrow",
                            "nose",
                            "mouth",
                            "accessory"]
        
        for componentType in drawingOrder {
            if let component = characterParts_MGRE.first(where: { $0.type.lowercased() == componentType.lowercased() }) {
                component.image.draw(in: CGRect(x: 0, y: 0, width: 500, height: 500))
            }
        }

        combinedImage_MGRE = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if let combined = combinedImage_MGRE {
            imageView_MGRE.image = combined
        }
    }

    func setupCharacter_MGRE(with model: CharacterModel_MGRE, contentSet: EditorContentSet_MGRE, isNew: Bool) {
        character_MGRE = model
        _ = setupImageView_MGRE()
                        
        contentSet.contentTypesByOrder.forEach { type in
            let models = contentSet.getModels(for: type) ?? []
                
            if let model = model.content.first(where: { $0.contentType == type }),
               models.contains(where: { $0.id == model.id })
            {
                let imgPath = "\(Keys_MGRE.ImagePath_MGRE.editor_mgre)\(model.path.pdfPath)"
                
                DBManager_MGRE.shared.fetchPDFData_MGRE(with: imgPath) { [weak self] data in
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        self?.addBodyPart_MGRE(from: data, type: model.contentType)
                    }
                }
            } else if isNew, let model = models.first {
                let imgPath = "\(Keys_MGRE.ImagePath_MGRE.editor_mgre)\(model.path.pdfPath)"
                
                character_MGRE?.change_MGRE(item: model)
                DBManager_MGRE.shared.fetchPDFData_MGRE(with: imgPath) { [weak self] data in
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        self?.addBodyPart_MGRE(from: data, type: model.contentType)
                    }
                }
            }
        }
    }
    
    func changeStatus_MGRE(with model: EditorContentModel_MGRE) {
        guard let _ = imageViews_MGRE.firstIndex(where: { $0.0 == model.contentType }) else {
            return
        }
        
        let imgPath = "\(Keys_MGRE.ImagePath_MGRE.editor_mgre)\(model.path.pdfPath)"
        
        DBManager_MGRE.shared.fetchPDFData_MGRE(with: imgPath) { [weak self] data in
            guard let self = self,
                  let data = data else { return }
                
            DispatchQueue.main.async {
                // Remove old image only when we have new data
                if let index = self.imageViews_MGRE.firstIndex(where: { $0.0 == model.contentType }) {
                    self.imageViews_MGRE.remove(at: index)
                }
                    
                self.addBodyPart_MGRE(from: data, type: model.contentType)
                self.character_MGRE?.change_MGRE(item: model)
                self.character_MGRE?.update_MGRE(image: self.takeScreenshot_MGRE(of: self))
            }
        }
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
    
    func getContent_MGRE(for contentType: String) -> EditorContentModel_MGRE? {
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
