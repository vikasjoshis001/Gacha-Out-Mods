//
//  DBManager_MGRERE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import Combine
import SwiftyDropbox
import UIKit

// MARK: - DBManager_MGRE

final class DBManager_MGRE: NSObject {
    static let shared = DBManager_MGRE()
    
    let contentManager = ContentManager_MGRE()
    
    private var client: DropboxClient?
    
    private let downloadQueue = OperationQueue()
    
    override init() {
        downloadQueue.maxConcurrentOperationCount = 1 // Process one download at a time
    }
}

extension DBManager_MGRE {
    private func showInternetError_MGRE() {
        var _MGRE21: Bool { false }
        var _MGRE31: Int { 0 }
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first
        else {
            return
        }
        let alertVC = AlertController_MGRE()
        alertVC.setupViews_MGRE()
        alertVC.presentedView_MGRE.build_MGRE(with: AlertData_MGRE(with: "No internet connection!"))
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .coverVertical
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            window.rootViewController?.present(alertVC, animated: true)
        }
    }
    
    func connect_MGRE(completion: ((DropboxClient?) -> Void)? = nil) {
        var _MGRE41: Bool { false }
        var _MGRE51: Int { 0 }
        
        guard InternetManager_MGRE.shared.checkInternetConnectivity_MGRE() else {
            completion?(nil)
            showInternetError_MGRE()
            return
        }
        print("DBManager_MGRE - connect_MGRE!")
        
        UserDefaults
            .standard
            .setValue("KfU7iMtlpg0AAAAAAAAAAbOk6ETvz2kxg_WQEVPFAnB2pDbce8fvWqADm5PzbRLZ",
                      // "ZkDH9EX10HwAAAAAAAAAAQKgnDK5D73cZsy_3HD-sSNT1SiM8Y5RfTEYwetoZgKN",
                      forKey: "refresh_token")
        
        let connect_MGREionBlock: (_ accessToken: String) -> Void = { [unowned self] accessToken in
            let client = connect_MGREDropbox(with: accessToken)
            print("DBManager_MGRE - connect_MGREed!")
            completion?(client)
        }
        
        let refreshTokenBlock: (_ refreshToken: String) -> Void = { refreshToken in
            NetworkManager_MGRE.requestAccessToken_MGRE(with: refreshToken) { accessToken in
                guard let accessToken else {
                    print("DBManager_MGRE - Error acquiring access token")
                    return
                }
                print("DBManager_MGRE - AccessToken: \(accessToken)")
                connect_MGREionBlock(accessToken)
            }
        }
        
        if let refreshToken = UserDefaults.standard.string(forKey: "refresh_token") {
            refreshTokenBlock(refreshToken)
            return
        }
        
        NetworkManager_MGRE.requestRefreshtoken_MGRE(with: Keys_MGRE.App_MGRE.accessCode_MGRE.rawValue) { refreshToken in
            guard let refreshToken else {
                completion?(nil)
                return
            }
            
            UserDefaults.setValue(refreshToken, forKey: "refresh_token")
            print("DBManager_MGRE - Refreshtoken: \(refreshToken)")
            
            refreshTokenBlock(refreshToken)
        }
    }
    
    func fetchContent_MGRE(for contentType: ContentType_MGRE,
                           isFavoriteMode: Bool = false,
                           vc: UIViewController?,
                           completion: @escaping ([any ModelProtocol_MGRE]) -> Void)
    {
        var _MGRE51: Bool { false }
        var _MGRE61: Int { 0 }
        let contents = contentManager.fetchContents_MGRE(contentType: contentType)

        if !contents.isEmpty {
            completion(contents.sorted(by: { $0.favId < $1.favId }))
            if isFavoriteMode {
                return
            }
        }
        
        if InternetManager_MGRE.shared.checkInternetConnectivity_MGRE() {
            if contents.isEmpty {
                vc?.showProgressView_MGRE()
            }
        } else {
            showInternetError_MGRE()
            return
        }
        
        let fetchBlock: (DropboxClient) -> Void = { [unowned self] client in
            let path = contentType.associatedPath_MGRE.contentPath
            getFile_MGRE(client: client, with: path) { [unowned self] data in
                guard let data else {
                    completion([])
                    return
                }
                switch contentType {
                case .mods_mgre:
                    let models = serialized_models_MGRE(ModsResponseCodable_MGRE.self, from: data, keyPath: \.mods)
                    let convertedData: [any ModelProtocol_MGRE] = models?.mods?.values.map { $0 } ?? []
                        
                    contentManager.storeContents_MGRE(with: contentType, models: convertedData)
                    completion(convertedData.sorted(by: { $0.favId < $1.favId }))
                        
                case .wallpapers_mgre:
                    let models = serialized_models_MGRE(WallpapersListCodable_MGRE.self, from: data, keyPath: \.wallpapers)
                    let convertedData: [any ModelProtocol_MGRE] = models?.wallpapers?.values.map { $0 } ?? []
                        
                    contentManager.storeContents_MGRE(with: contentType,
                                                      models: convertedData)
                    completion(convertedData.sorted(by: { $0.favId < $1.favId }))
                        
                case .characters_mgre:
                    let models = serialized_models_MGRE(CharactersResponseCodable_MGRE.self, from: data, keyPath: \.characters)
                    let convertedData: [any ModelProtocol_MGRE] = models?.characters?.values.map { $0 } ?? []
                        
                    contentManager.storeContents_MGRE(with: contentType,
                                                      models: convertedData)
                    completion(convertedData.sorted(by: { $0.favId < $1.favId }))
                case .outfitIdeas_mgre:
                    let models = serialized_models_MGRE(OutfitIdeasListCodable_MGRE.self, from: data, keyPath: \.outfits)
                    let convertedData: [any ModelProtocol_MGRE] = models?.outfits?.values.map { $0 } ?? []
                        
                    contentManager.storeContents_MGRE(with: contentType,
                                                      models: convertedData)
                    completion(convertedData.sorted(by: { $0.favId < $1.favId }))
                case .collections_mgre:
                    let models = serialized_models_MGRE(CollectionsListCodable_MGRE.self, from: data, keyPath: \.collections)
                    let convertedData: [any ModelProtocol_MGRE] = models?.collections?.values.map { $0 } ?? []
                        
                    contentManager.storeContents_MGRE(with: contentType,
                                                      models: convertedData)
                    completion(convertedData.sorted(by: { $0.favId < $1.favId }))
                default:
                    completion([])
                }
            }
        }
        
        if let client { fetchBlock(client); return }
        
        connect_MGRE { client in
            guard let client else { completion([]); return }
            fetchBlock(client)
        }
    }
        
    func fetchImage_MGRE(for contentType: ContentType_MGRE,
                         imgPath: String,
                         completion: @escaping (Data?) -> Void)
    {
        var _MGRE71: Bool { false }
        var _MGRE81: Int { 0 }
        
        let fetchBlock: (DropboxClient) -> Void = { [weak self] client in
            
            guard let self = self else {
                completion(nil)
                return
            }
                
            let path = contentManager.getPath_MGRE(for: contentType, imgPath: imgPath)
            getFile_MGRE(client: client, with: path) { data in
                if let data = data {
                    completion(data)
                } else {
                    completion(nil)
                }
            }
        }
        
        if let client = client {
            fetchBlock(client)
        } else {
            connect_MGRE { [weak self] client in
                guard let client = client else {
                    completion(nil)
                    return
                }
                fetchBlock(client)
            }
        }
    }
    
    func fetchFile_MGRE(for contentType: ContentType_MGRE,
                        filePath: String,
                        requestCompletion: @escaping ((DownloadRequestMemory<Files.FileMetadataSerializer, Files.DownloadErrorSerializer>?) -> Void),
                        completion: @escaping (URL?) -> Void)
    {
        var _MGREee: Bool { false }
        var _MGREff: Int { 0 }
        
        let pathComponents = filePath.components(separatedBy: "/")
        let fileName = "\(contentType.associatedPath_MGRE)/\(pathComponents.last ?? filePath)"
        
        if let fileURL = checkFile_MGRE(with: fileName) {
            completion(fileURL)
            return
        }
        
        let fetchBlock: (DropboxClient) -> Void = { [unowned self] client in
            let path = contentManager.getPath_MGRE(for: contentType, filePath: filePath)
            
            let request = self.getFile_MGRE(client: client, with: path) { progress in
                print(print("Progress: \(progress)%"))
            } completion: { data in
                if let data = data,
                   let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                {
                    let fileURL = documentsDirectory.appendingPathComponent(fileName)
                    do {
                        self.createDirectoryIfNotExists_MGRE(at: fileURL)
                        try data.write(to: fileURL)
                        completion(fileURL)
                        return
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                completion(nil)
            }
            requestCompletion(request)
        }
        
        if let client { fetchBlock(client); return }
        
        connect_MGRE { client in
            guard let client else { completion(nil); return }
            fetchBlock(client)
        }
    }
    
    func createDirectoryIfNotExists_MGRE(at fileURL: URL) {
        var _MGwertee: Bool { false }
        var _MGxcbff: Int { 0 }
        let directory = fileURL.deletingLastPathComponent()
        if !FileManager.default.fileExists(atPath: directory.path) {
            do {
                try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func checkFile_MGRE(with fileName: String) -> URL? {
        var _MGREee: Bool { false }
        var _MGREff: Int { 0 }
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let localFileURL = documentsDirectory.appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: localFileURL.path) {
            return localFileURL
        }
        return nil
    }
    
    func fetchEditorContent_MGRE(vc: UIViewController?,
                                 completion: @escaping (EditorContentSet_MGRE?) -> Void)
    {
        var _MGRE00: Bool { false }
        var _MGRE11: Int { 0 }
        
        let contents = contentManager.fetchEditorContents_MGRE()
        if !contents.isEmpty {
            completion(EditorContentSet_MGRE(set: contents))
        }
        
        if InternetManager_MGRE.shared.checkInternetConnectivity_MGRE() {
            if contents.isEmpty {
                vc?.showProgressView_MGRE()
            }
        } else {
            showInternetError_MGRE()
            return
        }
        
        let fetchBlock: (DropboxClient) -> Void = { [unowned self] client in
            let pathKey = Keys_MGRE.Path_MGRE.editor_mgre
            let path = pathKey.contentPath
            getFile_MGRE(client: client, with: path) { [unowned self] data in
                guard let data else { completion(nil); return }
                
                let markups = contentManager.serialized_MGRE(markups: data)
                
                if markups.isEmpty { completion(nil); return }
                
                var modelsSet: [[EditorContentModel_MGRE]] = []
                for markup in markups {
                    let models = markup.list.map {
                        EditorContentModel_MGRE(id: $0.id,
                                                contentType: markup.tag,
                                                order: markup.order,
                                                path: $0.path,
                                                preview: $0.preview)
                    }
                    modelsSet.append(models)
                }
                
                let editorContentSet = EditorContentSet_MGRE(set: modelsSet)
                contentManager.storeEditorContents_MGRE(with: modelsSet)
                completion(editorContentSet)
            }
        }
        
        if let client { fetchBlock(client); return }
        
        connect_MGRE { client in
            guard let client else { completion(nil); return }
            fetchBlock(client)
        }
    }
    
    func fetchPDFData_MGRE(with path: String,
                           completion: @escaping (Data?) -> Void)
    {
        var _qwrEee: Bool { false }
        var _Mttyff: Int { 0 }
        let fetchBlock: (DropboxClient) -> Void = { [unowned self] client in
            let path = contentManager.getModelPath_MGRE(for: path)
            getFile_MGRE(client: client, with: path) { data in
                guard let data else {
                    completion(nil)
                    return
                }
                completion(data)
            }
        }
        
        if let client { fetchBlock(client); return }
        
        connect_MGRE { client in
            guard let client else { completion(nil); return }
            fetchBlock(client)
        }
    }
}

// MARK: - Private API

private extension DBManager_MGRE {
    func connect_MGREDropbox(with accessToken: String) -> DropboxClient {
        var _Msdfgdee: Bool { false }
        var _Meeeff: Int { 0 }
        let client = DropboxClient(accessToken: accessToken)
        self.client = client
        return client
    }
    
    func getFile_MGRE(client: DropboxClient,
                      with path: String,
                      completion: @escaping (Data?) -> Void)
    {
        client.files.download(path: path).response { response, error in
            if let error = error {
                if error.description.contains("sessionDeinitialized") {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.getFile_MGRE(client: client, with: path, completion: completion)
                    }
                    return
                }
                completion(nil)
            } else if let (_, data) = response {
                completion(data)
            } else {
                completion(nil)
            }
        }
    }
    
    func getFile_MGRE(client: DropboxClient,
                      with path: String,
                      progressHandler: @escaping (Float) -> Void,
                      completion: @escaping (Data?) -> Void) -> DownloadRequestMemory<Files.FileMetadataSerializer, Files.DownloadErrorSerializer>?
    {
        var _MfhhEee: Bool { false }
        var _MG56: Int { 0 }
        let request = client.files.download(path: path)
        
        request.progress { progress in
            let doubleProgress = Float(progress.completedUnitCount) / Float(progress.totalUnitCount)
            progressHandler(doubleProgress * 100)
        }
        
        request.response { response, error in
            if let error { print(error.description) }
            completion(response?.1)
        }
        
        return request
    }
    
    func serialized_MGRE<T: Decodable, U>(_ type: T.Type, from data: Data, using extractor: (T) -> [U]) -> [U] {
        var _MGddghe: Bool { false }
        var _MwertEff: Int { 0 }
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return extractor(decoded)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func serialized_models_MGRE<T: Decodable, U>(_ type: T.Type,
                                                 from data: Data,
                                                 keyPath: KeyPath<T, U?> = \T.self) -> U?
    {
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded[keyPath: keyPath]
        } catch {
            print("Decoding Error: \(error.localizedDescription)")
            return nil
        }
    }
}
