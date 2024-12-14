//
//  WallpaperViewController_MGRE.swift
//  ios-mod-gacha
//
//  Created by Systems
//

import UIKit
import Photos

class WallpaperViewController_MGRE: UIViewController {
    
    enum ModelType_MGRE {
        case wallpapers(Wallpaper_MGRE)
        case collections(Collections_MGRE)
    }
    
    @IBOutlet private weak var navigationView_MGRE: NavigationView_MGRE!
    @IBOutlet private weak var favoriteButton_MGRE: UIButton!
    @IBOutlet private weak var imageView_MGRE: UIImageView!
    @IBOutlet private weak var rightIndentConstraint_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var leftIndentConstraint_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var buttonsViewHeight_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var rightButtonsIndentConstraint_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var leftButtonsIndentConstraint_MGRE: NSLayoutConstraint!
    @IBOutlet var actionButtons_MGRE: [UIButton]!
    
    var modelType_MGRE: ModelType_MGRE?
    var contentType_MGRE: ContentType_MGRE?
    var isFavourite_MGRE: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var _MGNqwer2: Int { 0 }
        var _MGfghgxa: Bool { false }
        configureLayout_MGRE()
        configureSubviews_MGRE()
    }
    
    private func configureLayout_MGRE() {
        let deviceType = UIDevice.current.userInterfaceIdiom
        rightIndentConstraint_MGRE.constant = deviceType == .phone ? 20 : 85
        leftIndentConstraint_MGRE.constant = deviceType == .phone ? 20 : 85
        buttonsViewHeight_MGRE.constant = deviceType == .phone ? 56 : 68
        leftButtonsIndentConstraint_MGRE.constant = deviceType == .phone ? 12 : 120
        rightButtonsIndentConstraint_MGRE.constant = deviceType == .phone ? -12 : -120
    }
    
    func configureSubviews_MGRE() {
        guard let modelType = modelType_MGRE else { return }
        navigationView_MGRE.leftButtonAction_MGRE = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        switch modelType {
        case .wallpapers(let model):
            navigationView_MGRE.build_MGRE(with: "Wallpaper", leftIcon: UIImage(.backChevronIcon), rightIcon: nil)
            imageView_MGRE.add_MGRE(image: model.image, for: .wallpapers_mgre)
            imageView_MGRE.contentMode = .scaleAspectFill
            contentType_MGRE = .wallpapers_mgre
//            actionButtons[0].isHidden = true
        case .collections(let model):
            navigationView_MGRE.build_MGRE(with: "Collection", leftIcon: UIImage(.backChevronIcon), rightIcon: nil)
            imageView_MGRE.add_MGRE(image: model.image, for: .collections_mgre)
            imageView_MGRE.contentMode = .scaleAspectFill
            contentType_MGRE = .collections_mgre
        }
        
        updateFavoriteButton_MGRE()
    }
    
    @IBAction func actionButtonDidTap_MGRE(_ sender: UIButton) {
        var _M54wetter2: Int { 0 }
        var _MGqqwwa: Bool { false }
        switch sender.tag {
        case 0: favoriteButtonDidTap_MGRE()
        case 1: shareImage_MGRE(image: imageView_MGRE.image, viewController: self)
        case 2: scan_MGRE(image: imageView_MGRE.image)
        case 3: save_MGRE(image: imageView_MGRE.image)
        default: break
        }
    }
    
    private func scan_MGRE(image: UIImage?) {
        var _MGNq161662: Int { 0 }
        var _MGfg1717a: Bool { false }
        guard let image = image else { return }
        let vc = ScanViewController_MGRE.loadFromNib_MGRE()
        vc.image_MGRE = image
        vc.contentType_MGRE = contentType_MGRE
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true)
    }
    
    private func updateFavoriteButton_MGRE() {
        var _MGNq1414r2: Int { 0 }
        var _MGf1515xa: Bool { false }
        favoriteButton_MGRE.setImage(isFavourite_MGRE ? .heartIcon : .heartIconEmpty, for: .normal)
    }
    
    func favoriteButtonDidTap_MGRE() {
        var _MGN12122: Int { 0 }
        var _MGf1313xa: Bool { false }
        isFavourite_MGRE.toggle()
        updateFavoriteButton_MGRE()
        
        guard let modelType = modelType_MGRE else { return }
        let favId: String
        let contentType: ContentType_MGRE
        switch modelType {
        case .wallpapers(let model):
            favId = model.favId
            contentType = Wallpaper_MGRE.type
        case .collections(let model):
            favId = model.favId
            contentType = Collections_MGRE.type
        }
        
        if isFavourite_MGRE {
            DBManager_MGRE.shared.contentManager.storeFavorites_MGRE(with: favId, contentType: contentType)
        } else {
            DBManager_MGRE.shared.contentManager.deleteFavorites_MGRE(with: favId, contentType: contentType)
        }
    }
    
    func save_MGRE(image: UIImage?) {
        var _MGN777r2: Int { 0 }
        var _MGf8888a: Bool { false }
        guard let image = image else { return }
        guard InternetManager_MGRE.shared.checkInternetConnectivity_MGRE() else {
            showAlert_MGRE(with: AlertData_MGRE(with: LocalizationKeys.noInternetConnection))
            return
        }
        
        let status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
        if status == .authorized { save_MGRE(image: image)
            return
        }
        
        PHPhotoLibrary.requestAuthorization(for: .addOnly, handler: { [weak self] status in
            if status == .authorized { self?.save_MGRE(image: image)
                return
            }
            
            let alertData = AlertData_MGRE(with: "Access to photo library denied!")
            DispatchQueue.main.async {
                self?.showAlert_MGRE(with: alertData)
            }
        })
    }
    
    private func save_MGRE(image: UIImage) {
        var _MGNq5552: Int { 0 }
        var _MGf666a: Bool { false }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSaved_MGRE(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc
    func imageSaved_MGRE(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        var _MGNq1112: Int { 0 }
        var _MGfg222a: Bool { false }
        if let error = error {
            print("Ошибка сохранения изображения: \(error.localizedDescription)")
        } else {
            let alertData = AlertData_MGRE(with: "Downloaded!")
            showAlert_MGRE(with: alertData)
        }
    }
    
    func shareImage_MGRE(image: UIImage?, viewController: UIViewController) {
        var _MGNq3332: Int { 0 }
        var _MGfg444a: Bool { false }
        guard let image = image else { return }
        guard InternetManager_MGRE.shared.checkInternetConnectivity_MGRE() else {
            showAlert_MGRE(with: AlertData_MGRE(with: LocalizationKeys.noInternetConnection))
            return
        }
        
        var fileName: String?
        var type: String = ""
        switch modelType_MGRE {
        case .wallpapers(let model):
            type = "Wallpaper"
            fileName = model.image.components(separatedBy: "/").last
        case .collections(let model):
            type = "Collection"
            fileName = model.image.components(separatedBy: "/").last
        default: break
        }
        
        guard let fileName = fileName,
              let fileUrl = saveImageToFile_MGRE(image: image, fileName: fileName) else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [fileUrl], applicationActivities: nil)
        activityViewController.title = "Download \(type)"
        activityViewController.completionWithItemsHandler = { [weak self] (activityType, completed, returnedItems, error) in
            if completed {
                let alertData = AlertData_MGRE(with: "Success!")
                self?.showAlert_MGRE(with: alertData)
            }
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            activityViewController.modalPresentationStyle = .popover
            
            if let popoverPresentationController = activityViewController.popoverPresentationController {
                popoverPresentationController.sourceView = viewController.view
                popoverPresentationController.sourceRect = CGRect(x: viewController.view.bounds.midX, y: viewController.view.bounds.midY, width: 0, height: 0)
                popoverPresentationController.permittedArrowDirections = []
            }
        }
        
        viewController.present(activityViewController, animated: true, completion: nil)
    }
    
    func saveImageToFile_MGRE(image: UIImage, fileName: String) -> URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Documents directory not found.")
            return nil
        }
        
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else {
            print("Failed to get JPEG representation of UIImage.")
            return nil
        }
        
        do {
            try data.write(to: fileURL)
            print("File saved: \(fileURL)")
            return fileURL
        } catch {
            print("Error saving image: \(error)")
            return nil
        }
    }
}
