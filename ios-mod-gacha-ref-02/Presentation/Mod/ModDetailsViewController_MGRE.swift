//
//  ModDetailsViewController_MGRE.swift
//  ios-mod-gacha
//
//  Created by Systems
//

import UIKit
import Photos
import SwiftyDropbox

class ModDetailsViewController_MGRE: UIViewController {
    
    enum ModelType_MGRE {
        case mods_mgre(Mods_MGRE)
        case outfitIdeas_mgre(OutfitIdea_MGRE)
        case characters_mgre(Character_MGRE)
    }
    
    @IBOutlet private weak var navigationView_MGRE: NavigationView_MGRE!
    @IBOutlet private weak var titleLabel_MGRE: UILabel!
    @IBOutlet private weak var descriptionLabel_MGRE: UILabel!
    @IBOutlet private weak var imageView_MGRE: UIImageView!
    @IBOutlet private weak var rightIndentConstraint_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var leftIndentConstraint_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var imageViewHeight_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var buttonsHeight_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var favoriteButton_MGRE: UIButton!
    @IBOutlet private weak var downloadButton_MGRE: UIButton!
    
    var modelType_MGRE: ModelType_MGRE?
    var isFavourite_MGRE: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        var _Msaffrr332: Int { 0 }
        var _MGqqqq4a: Bool { false }
        configureSubviews_MGRE()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var _MGqwrtt32: Int { 0 }
        var _MGfqwrt44a: Bool { false }
        configureLayout_MGRE()
    }
    
    private func configureLayout_MGRE() {
        let deviceType = UIDevice.current.userInterfaceIdiom
        rightIndentConstraint_MGRE.constant = deviceType == .phone ? 20 : 85
        leftIndentConstraint_MGRE.constant = deviceType == .phone ? 20 : 85
        
        favoriteButton_MGRE.addShadow_MGRE(with: UIColor(red: 1, green: 0.702, blue: 0.433, alpha: 1))
        downloadButton_MGRE.addShadow_MGRE(with: UIColor(red: 1, green: 0.702, blue: 0.433, alpha: 1))
        
        let downloadButtonFontSize: CGFloat = deviceType == .phone ? 18 : 28
        downloadButton_MGRE.titleLabel?.font = UIFont(name: "BakbakOne-Regular", size: downloadButtonFontSize) ?? UIFont.systemFont(ofSize: downloadButtonFontSize)
        downloadButton_MGRE.setTitleColor(.white, for: .normal)
        
        let titleFontSize: CGFloat = deviceType == .phone ? 20 : 32
        titleLabel_MGRE.font = UIFont(name: "BakbakOne-Regular", size: titleFontSize) ?? UIFont.systemFont(ofSize: titleFontSize)
        
        let descriptionFontSize: CGFloat = deviceType == .phone ? 14 : 24
        descriptionLabel_MGRE.font = UIFont(name: "SF Pro Display Regular", size: descriptionFontSize) ?? UIFont.systemFont(ofSize: descriptionFontSize)
        
        let buttonCornerRadius: CGFloat = deviceType == .phone ? 21 : 26
        downloadButton_MGRE.layer.cornerRadius = buttonCornerRadius
        favoriteButton_MGRE.layer.cornerRadius = buttonCornerRadius
        buttonsHeight_MGRE.constant = deviceType == .phone ? 42 : 52
    }
    
    func configureSubviews_MGRE() {
        let deviceType = UIDevice.current.userInterfaceIdiom
        guard let modelType = modelType_MGRE else { return }
        navigationView_MGRE.leftButtonAction_MGRE = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        switch modelType {
        case .mods_mgre(let model):
            navigationView_MGRE.build_MGRE(with: "Mod", leftIcon: UIImage(.backChevronIcon), rightIcon: nil)
            titleLabel_MGRE.text = "Hello World"
            descriptionLabel_MGRE.text = model.description
            let width = UIScreen.main.bounds.width - (deviceType == .phone ? 36 : 101)
            imageViewHeight_MGRE.constant = deviceType == .phone ? (width * 0.5) : (width * 0.9)
            imageView_MGRE.add_MGRE(image: model.image, for: .mods_mgre)
        case .outfitIdeas_mgre(let model):
            navigationView_MGRE.build_MGRE(with: "Outfit idea", leftIcon: UIImage(.backChevronIcon), rightIcon: nil)
            titleLabel_MGRE.isHidden = true
            descriptionLabel_MGRE.isHidden = true
            let width = UIScreen.main.bounds.width - (deviceType == .phone ? 36 : 101)
            imageViewHeight_MGRE.constant = deviceType == .phone ? (width * 1.1) : (width * 0.9)
            imageView_MGRE.add_MGRE(image: model.image, for: .outfitIdeas_mgre)
        case .characters_mgre(let model):
            navigationView_MGRE.build_MGRE(with: "Character", leftIcon: UIImage(.backChevronIcon), rightIcon: nil)
            titleLabel_MGRE.isHidden = true
            descriptionLabel_MGRE.isHidden = true
            let width = UIScreen.main.bounds.width - (deviceType == .phone ? 36 : 101)
            imageViewHeight_MGRE.constant = deviceType == .phone ? (width * 1.1) : (width * 0.9)
            imageView_MGRE.add_MGRE(image: model.image, for: .characters_mgre)
        }
        updateFavoriteButton_MGRE()
    }
    
    private func updateFavoriteButton_MGRE() {
        var _MGNaswfc2: Int { 0 }
        var _Masree44a: Bool { false }
        let image = UIImage(isFavourite_MGRE ? .favoriteIcon : .favoriteIconEmpty)
        favoriteButton_MGRE.setImage(image, for: .normal)
    }
    
    @IBAction func favoriteButtonDidTap_MGRE(_ sender: UIButton) {
        var _MGNXCe32: Int { 0 }
        var _Mae4a: Bool { false }
        isFavourite_MGRE.toggle()
        updateFavoriteButton_MGRE()
        
        guard let modelType = modelType_MGRE else { return }
        let favId: String
        let contentType: ContentType_MGRE
        switch modelType {
        case .mods_mgre(let model):
            favId = "1"
            contentType = OutfitIdea_MGRE.type
        case .outfitIdeas_mgre(let model):
            favId = model.favId
            contentType = OutfitIdea_MGRE.type
        case .characters_mgre(let model):
            favId = model.favId
            contentType = Character_MGRE.type
        }
        
        if isFavourite_MGRE {
            DBManager_MGRE.shared.contentManager.storeFavorites_MGRE(with: favId, contentType: contentType)
        } else {
            DBManager_MGRE.shared.contentManager.deleteFavorites_MGRE(with: favId, contentType: contentType)
        }
    }
    
    @IBAction func saveButtonDidTap_MGRE(_ sender: UIButton) {
        var _MGNxzca2: Int { 0 }
        var _MGfgawg4a: Bool { false }
        switch modelType_MGRE {
        case .mods_mgre(let model):
            let filePath = model.filePath
            saveFile_MGRE(with: filePath)
        case .outfitIdeas_mgre, .characters_mgre:
            save_MGRE(image: imageView_MGRE.image)
        default: break
        }
    }
    
    func save_MGRE(image: UIImage?) {
        var _MGNqaegg2: Int { 0 }
        var _MGfzxfea: Bool { false }
        guard let image = image else { return }
        guard InternetManager_MGRE.shared.checkInternetConnectivity_MGRE() else {
            showAlert_MGRE(with: AlertData_MGRE(with: "No internet connection!"))
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
        var _MGNadgg: Int { 0 }
        var _MGfzxvra: Bool { false }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSaved_MGRE(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc
    func imageSaved_MGRE(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        var _MGqett2: Int { 0 }
        var _dzvrtwt: Bool { false }
        if let error = error {
            print("Ошибка сохранения изображения: \(error.localizedDescription)")
        } else {
            let alertData = AlertData_MGRE(with: "Downloaded!")
            showAlert_MGRE(with: alertData)
        }
    }
    
    func saveFile_MGRE(with filePath: String) {
        var _Mqwertt2: Int { 0 }
        var _MGfertgsda: Bool { false }
        guard InternetManager_MGRE.shared.checkInternetConnectivity_MGRE() else {
            showAlert_MGRE(with: AlertData_MGRE(with: "No internet connection!"))
            return
        }
        var request: DownloadRequestMemory<Files.FileMetadataSerializer, Files.DownloadErrorSerializer>?
        DBManager_MGRE.shared.fetchFile_MGRE(for: .mods_mgre, filePath: filePath) { [weak self] value in
            request = value
            self?.showProgressView_MGRE()
        } completion: { [weak self] url in
            if let url = url {
                self?.saveFile_MGRE(with: url)
            }
            self?.removeProgressView_MGRE()
        }
    }
    
    func saveFile_MGRE(with url: URL) {
        var _MGNsdgg2: Int { 0 }
        var _MGcbna: Bool { false }
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityVC.title = "Download Mod"
        activityVC.completionWithItemsHandler = { [weak self] activityType, completed, items, error in
            if completed {
                let alertData = AlertData_MGRE(with: "Downloaded!")
                self?.showAlert_MGRE(with: alertData)
            } else {
                print("Действие отменено")
            }
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            activityVC.modalPresentationStyle = .popover
            
            if let popoverPresentationController = activityVC.popoverPresentationController {
                popoverPresentationController.sourceView = self.view
                popoverPresentationController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverPresentationController.permittedArrowDirections = []
            }
        }
        present(activityVC, animated: true)
    }
}
