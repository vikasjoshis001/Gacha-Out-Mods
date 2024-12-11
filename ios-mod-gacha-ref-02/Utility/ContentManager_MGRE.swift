//
//  ContentManager_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import CoreData
import Foundation

// MARK: - ContentManager_MGRE

final class ContentManager_MGRE: NSObject {
    lazy var managedContext_MGRE: NSManagedObjectContext = persistentContainer_MGRE.viewContext
    
    private lazy var persistentContainer_MGRE: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ContentCache_MGRE")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    func getModelPath_MGRE(for imgPath: String) -> String {
        String(format: "/%@", imgPath)
    }
        
    func getPath_MGRE(for contentType: ContentType_MGRE, imgPath: String) -> String {
        switch contentType {
        case .mods_mgre:
            var originalString = imgPath

            let replacementString = "TipsAndTricks"
            if let range = originalString.range(of: "Tips_and_Tricks") {
                originalString.replaceSubrange(range, with: replacementString)
            }
            return String(format: "/%@", originalString)
        case .wallpapers_mgre, .editor_mgre, .outfitIdeas_mgre, .characters_mgre, .collections_mgre:
            return String(format: "/%@", imgPath)
        }
    }
    
    func getPath_MGRE(for contentType: ContentType_MGRE, filePath: String) -> String {
        switch contentType {
        case .mods_mgre:
            return String(format: "/%@", filePath)
        default: return ""
        }
    }
    
    func serialized_MGRE(markups data: Data) -> [EditorCodableContentList_MGRE] {
        if let jsonObj = jsonObj_MGRE(from: data, with: "dfnsh-sd5"),
           let markups = try? JSONDecoder().decode([EditorCodableContentList_MGRE].self,
                                                   from: jsonObj)
        {
            return markups
        }
        return []
    }
    
    func fetchContents_MGRE(contentType: ContentType_MGRE) -> [any ModelProtocol_MGRE] {
        let fetchRequest = ContentEntity.fetchRequest()
        fetchRequest.predicate = .init(format: "contentType == %i", contentType.int64_MGRE)
        do {
            let result = try managedContext_MGRE.fetch(fetchRequest)
            switch contentType {
            case .mods_mgre: return result.compactMap { Mods_MGRE(from: $0) }
            case .outfitIdeas_mgre: return result.compactMap { OutfitIdea_MGRE(from: $0) }
            case .characters_mgre: return result.compactMap { Character_MGRE(from: $0) }
            case .collections_mgre: return result.compactMap { Collections_MGRE(from: $0) }
            case .wallpapers_mgre: return result.compactMap { Wallpaper_MGRE(from: $0) }
            default: return []
            }
        } catch let error as NSError {
            print(error.localizedDescription)
            return []
        }
    }
    
    func storeContents_MGRE(with contentType: ContentType_MGRE,
                            models: [any ModelProtocol_MGRE])
    {
        let fetchRequest = ContentEntity.fetchRequest()
        fetchRequest.predicate = .init(format: "contentType == %i", contentType.int64_MGRE)
        
        do {
            let result = try managedContext_MGRE.fetch(fetchRequest)
            for model in models {
                if let entity = result.first(where: { $0.id == model.favId }) {
                    update_MGRE(entity: entity, model: model, contentType: contentType)
                } else {
                    let entity = ContentEntity(context: managedContext_MGRE)
                    update_MGRE(entity: entity, model: model, contentType: contentType)
                }
            }
            
            saveContext_MGRE()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func update_MGRE(entity: ContentEntity,
                             model: any ModelProtocol_MGRE,
                             contentType: ContentType_MGRE)
    {
        switch contentType {
        case .mods_mgre:
            if let model = model as? Mods_MGRE {
                entity.contentType = contentType.int64_MGRE
                entity.id = model.favId
                entity.name = model.name
                entity.image = model.image
                entity.descr = model.description
                entity.filePath = model.filePath
                entity.new = model.new
                entity.top = model.top
            }
        case .outfitIdeas_mgre:
            if let model = model as? OutfitIdea_MGRE {
                entity.contentType = contentType.int64_MGRE
                entity.id = model.favId
                entity.image = model.image
//                entity.descr = model.description
                entity.new = model.new
                entity.top = model.top
            }
        case .characters_mgre:
            if let model = model as? Character_MGRE {
                entity.contentType = contentType.int64_MGRE
                entity.id = model.favId
                entity.image = model.image
                entity.descr = model.description
                entity.new = model.new
                entity.top = model.top
            }
        case .collections_mgre:
            if let model = model as? Collections_MGRE {
                entity.contentType = contentType.int64_MGRE
                entity.id = model.favId
                entity.image = model.image
//                entity.descr = model.description
                entity.new = model.new
                entity.top = model.top
            }
        case .wallpapers_mgre:
            if let model = model as? Wallpaper_MGRE {
                entity.contentType = contentType.int64_MGRE
                entity.id = model.favId
                entity.image = model.image
                entity.new = model.new
                entity.top = model.top
            }
        default: break
        }
    }
    
    func fetchEditorContents_MGRE() -> [[EditorContentModel_MGRE]] {
        let fetchRequest = EditorContentEntity.fetchRequest()
    
        do {
            let result = try managedContext_MGRE.fetch(fetchRequest)
            let groupedModels = result.reduce(into: [String: [EditorContentEntity]]()) { result, model in
                result[model.contentType ?? "value", default: []].append(model)
            }
            
            let sortedModelArrays = groupedModels.values.map { group -> [EditorContentEntity] in
                group.sorted(by: { $0.id < $1.id })
            }.sorted { group1, group2 -> Bool in
                guard let firstGroup1 = group1.first, let firstGroup2 = group2.first else { return false }
                return (firstGroup1.sortOrder ?? "0") < (firstGroup2.sortOrder ?? "0")
            }
            
            return sortedModelArrays.map { value in
                value.compactMap { EditorContentModel_MGRE(from: $0) }
            }
        } catch let error as NSError {
            print(error.localizedDescription)
            return []
        }
    }
    
    func storeEditorContents_MGRE(with models: [[EditorContentModel_MGRE]]) {
        let fetchRequest = EditorContentEntity.fetchRequest()
        do {
            let result = try managedContext_MGRE.fetch(fetchRequest)
            for entity in result {
                managedContext_MGRE.delete(entity)
            }
            
            for value in models.enumerated() {
                for model in value.element {
                    let entity = EditorContentEntity(context: managedContext_MGRE)
                    entity.id = model.id
                    entity.contentType = model.contentType
                    entity.order = model.order
                    entity.path = model.path.pdfPath
                    entity.preview = model.path.elPath
                    entity.sortOrder = String(value.offset)
                }
            }
            
            saveContext_MGRE()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func fetchFavorites_MGRE(contentType: ContentType_MGRE) -> [String] {
        let fetchRequest = FavoritesEntity.fetchRequest()
        fetchRequest.predicate = .init(format: "contentType == %i", contentType.int64_MGRE)
        do {
            let result = try managedContext_MGRE.fetch(fetchRequest)
            return result.compactMap { $0.id }
        } catch let error as NSError {
            print(error.localizedDescription)
            return []
        }
    }
    
    func storeFavorites_MGRE(with id: String, contentType: ContentType_MGRE) {
        let fetchRequest = FavoritesEntity.fetchRequest()
        fetchRequest.predicate = .init(format: "contentType == %i AND id == %@",
                                       contentType.int64_MGRE,
                                       id as CVarArg)

        fetchRequest.fetchLimit = 1
        
        do {
            if let entity = try managedContext_MGRE.fetch(fetchRequest).first {
                entity.id = id
                entity.contentType = contentType.int64_MGRE
            } else {
                let entity = FavoritesEntity(context: managedContext_MGRE)
                entity.id = id
                entity.contentType = contentType.int64_MGRE
            }
            
            saveContext_MGRE()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func deleteFavorites_MGRE(with id: String, contentType: ContentType_MGRE) {
        let fetchRequest = FavoritesEntity.fetchRequest()
        fetchRequest.predicate = .init(format: "contentType == %i AND id == %@",
                                       contentType.int64_MGRE,
                                       id as CVarArg)
        fetchRequest.fetchLimit = 1
        
        do {
            if let entity = try managedContext_MGRE.fetch(fetchRequest).first {
                managedContext_MGRE.delete(entity)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
            managedContext_MGRE.rollback()
        }
    }
    
    func fetchCharacters_MGRE() -> [CharacterPreview_MGRE] {
        let fetchRequest = CharacterEntity.fetchRequest()
        do {
            return try managedContext_MGRE
                .fetch(fetchRequest)
                .compactMap { CharacterPreview_MGRE(from: $0) }
        } catch let error as NSError {
            print(error.localizedDescription)
            return []
        }
    }
    
    func removeAllCharacters_MGRE() {
        let fetchRequest = CharacterEntity.fetchRequest()
        
        do {
            let characters = try managedContext_MGRE.fetch(fetchRequest)
            
            for character in characters {
                managedContext_MGRE.delete(character)
            }
            
            saveContext_MGRE()
            print("All characters removed successfully.")
        } catch let error as NSError {
            print("Error removing characters: \(error.localizedDescription)")
        }
    }
    
    func store_MGRE(character preview: CharacterPreview_MGRE) {
        let fetchRequest = CharacterEntity.fetchRequest()
        fetchRequest.predicate = .init(format: "%K == %@", "id",
                                       preview.id as CVarArg)
        fetchRequest.fetchLimit = 1
        
        do {
            if let entity = try managedContext_MGRE.fetch(fetchRequest).first {
                entity.content = preview.content
                entity.contentData = preview.contentData
            } else {
                let entity = CharacterEntity(context: managedContext_MGRE)
                entity.id = preview.id
                entity.content = preview.content
                entity.contentData = preview.contentData
            }
            
            saveContext_MGRE()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func delete_MGRE(character preview: CharacterPreview_MGRE) {
        let fetchRequest = CharacterEntity.fetchRequest()
        fetchRequest.predicate = .init(format: "%K == %@", "id",
                                       preview.id as CVarArg)
        fetchRequest.fetchLimit = 1
        
        do {
            if let entity = try managedContext_MGRE.fetch(fetchRequest).first {
                managedContext_MGRE.delete(entity)
            }
            saveContext_MGRE()
        } catch let error as NSError {
            print(error.localizedDescription)
            managedContext_MGRE.rollback()
        }
    }
}

// MARK: - Private API

private extension ContentManager_MGRE {
    func jsonObj_MGRE(from data: Data, with key: String) -> Data? {
        if let jsonDict = jsonDict_MGRE(from: data),
           let jsonObj = jsonDict[key],
           let data = try? JSONSerialization.data(withJSONObject: jsonObj)
        {
            return data
        }
        
        return nil
    }
    
    func jsonDict_MGRE(from data: Data) -> [String: Any]? {
        try? JSONSerialization.jsonObject(with: data) as? [String: Any]
    }
    
    func execute_MGRE(deleteRequest: NSBatchDeleteRequest) -> Bool {
        do {
            try managedContext_MGRE.execute(deleteRequest)
            return true
        } catch {
            print(error.localizedDescription)
            managedContext_MGRE.rollback()
            return false
        }
    }
    
    func saveContext_MGRE() {
        guard managedContext_MGRE.hasChanges else {
            return
        }
        
        do {
            try managedContext_MGRE.save()
        } catch let error as NSError {
            print(error.localizedDescription)
            managedContext_MGRE.rollback()
        }
    }
}
