//
//  ModeDetailNew.swift
//  ios-mod-gacha-ref-02
//
//  Created by Vikas Joshi on 16/12/24.
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
        
    private let imageView_MGRE: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .imageCardBackground
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
        
    private let favoriteButton_MGRE: UIButton = {
        let button = UIButton()
        button.backgroundColor = .buttonBg
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    private let downloadButton_MGRE: UIButton = {
        let button = UIButton()
        button.backgroundColor = .buttonBg
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    private let titleLabel_MGRE: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private let descriptionLabel_MGRE: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private let verticalStackView_MGRE: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.masksToBounds = true
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private let spacerView_MGRE: UIView = {
        let view = UIView()
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return view
    }()
    
    private let navigationView_MGRE = NavigationView_MGRE()
    
    let device = Helper.getDeviceType_MGRE()
    var modelType_MGRE: ModelType_MGRE?
    var isFavourite_MGRE: Bool = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBackground
    
        favoriteButton_MGRE.addTarget(self, action: #selector(favoriteButtonTapped_MGRE), for: .touchUpInside)
        downloadButton_MGRE.addTarget(self, action: #selector(downloadButtonTapped_MGRE), for: .touchUpInside)
        
        setupViews_MGRE()
        configureSubviews_MGRE()
    }
    
    private func getImageContainerHeight_MGRE() -> CGFloat {
        guard let modelType = modelType_MGRE else { return 0 }
        switch modelType {
            case .mods_mgre:
                return device == .phone ? 276 : 469
            case .outfitIdeas_mgre:
                return device == .phone ? 444 : 754.8
            case .characters_mgre:
                return device == .phone ? 444 : 754.8
        }
    }
        
    private func setupViews_MGRE() {
        // config
        let verticalStackViewLeadingAnchor: CGFloat = device == .phone ? 29 : 180
        let imageContainerHeight: CGFloat = getImageContainerHeight_MGRE()
        let favButtonTrailingAnchor: CGFloat = device == .phone ? 5 : 8.5
        let favButtonHeight: CGFloat = device == .phone ? 38 : 64.6

        imageView_MGRE.layer.cornerRadius = device == .phone ? 14 : 23.8
        
        favoriteButton_MGRE.layer.cornerRadius = device == .phone ? 14 : 23.8
        favoriteButton_MGRE.setImage(UIImage(named: Helper.deviceSpecificImage_MGRE(image: StringConstants_MGRE.Images.favStar)), for: .normal)
        
        let downloadButtonFontSize: CGFloat = device == .phone ? 20 : 34
        downloadButton_MGRE.layer.cornerRadius = device == .phone ? 14 : 23.8
        downloadButton_MGRE.setTitle(LocalizationKeys.download, for: .normal)
        downloadButton_MGRE.titleLabel?.font = UIFont(name: StringConstants_MGRE.ptSansRegular, size: downloadButtonFontSize)
        downloadButton_MGRE.setTitleColor(.black, for: .normal)
        
        let titleLabelFontSize: CGFloat = device == .phone ? 20 : 34
        titleLabel_MGRE.font = UIFont(name: StringConstants_MGRE.ptSansRegular, size: titleLabelFontSize)
        titleLabel_MGRE.textColor = .black
        titleLabel_MGRE.setLineHeight_MGRE(titleLabelFontSize)
        
        let descriptionLabelFontSize: CGFloat = device == .phone ? 14 : 23.8
        let descriptionLabelLineHeight: CGFloat = device == .phone ? 14 : 30.82
        descriptionLabel_MGRE.font = UIFont(name: StringConstants_MGRE.ptSansRegular, size: descriptionLabelFontSize)
        descriptionLabel_MGRE.textColor = .black
        descriptionLabel_MGRE.setLineHeight_MGRE(descriptionLabelLineHeight)
        
        // Add views
        view.addSubview(navigationView_MGRE)
        view.addSubview(verticalStackView_MGRE)

        navigationView_MGRE.translatesAutoresizingMaskIntoConstraints = false
        
        let verticalStackViewInsets: CGFloat = device == .phone ? 8 : 14
        verticalStackView_MGRE.layer.cornerRadius = device == .phone ? 20 : 34
        verticalStackView_MGRE.backgroundColor = .cardBackground
        verticalStackView_MGRE.layoutMargins = UIEdgeInsets(top: verticalStackViewInsets,
                                                       left: verticalStackViewInsets,
                                                       bottom: verticalStackViewInsets,
                                                       right: verticalStackViewInsets)

        // Add image container
        let imageContainer = UIView()
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        imageContainer.addSubview(imageView_MGRE)
        imageContainer.addSubview(favoriteButton_MGRE)
                    
        // Add to stack view
        verticalStackView_MGRE.addArrangedSubview(imageContainer)
        verticalStackView_MGRE.addArrangedSubview(downloadButton_MGRE)
        verticalStackView_MGRE.addArrangedSubview(titleLabel_MGRE)
        verticalStackView_MGRE.addArrangedSubview(descriptionLabel_MGRE)
        verticalStackView_MGRE.addArrangedSubview(spacerView_MGRE)

        // Set constraints
        NSLayoutConstraint.activate([
            // Navigation View
            navigationView_MGRE.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView_MGRE.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView_MGRE.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // Stack view constraints
            verticalStackView_MGRE.topAnchor.constraint(equalTo: navigationView_MGRE.bottomAnchor, constant: 6),
            verticalStackView_MGRE.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: verticalStackViewLeadingAnchor),
            verticalStackView_MGRE.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -verticalStackViewLeadingAnchor),
            verticalStackView_MGRE.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(Helper.getBottomConstraint_MGRE())),
                
            // Image container constraints
            imageContainer.heightAnchor.constraint(equalToConstant: imageContainerHeight),
            
            // Image view constraints
            imageView_MGRE.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            imageView_MGRE.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            imageView_MGRE.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            imageView_MGRE.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor),
                
            // Favorite button constraints
            favoriteButton_MGRE.topAnchor.constraint(equalTo: imageView_MGRE.topAnchor, constant: favButtonTrailingAnchor),
            favoriteButton_MGRE.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: -favButtonTrailingAnchor),
            favoriteButton_MGRE.heightAnchor.constraint(equalToConstant: favButtonHeight),
            favoriteButton_MGRE.widthAnchor.constraint(equalToConstant: favButtonHeight),
                
            // Download button constraints
            downloadButton_MGRE.heightAnchor.constraint(equalToConstant: favButtonHeight)
        ])
    }
    
    func configureSubviews_MGRE() {
        guard let modelType = modelType_MGRE else { return }
        navigationView_MGRE.leftButtonAction_MGRE = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        let backIcon = Helper.deviceSpecificImage_MGRE(image: StringConstants_MGRE.Images.back)
        switch modelType {
        case .mods_mgre(let model):
                navigationView_MGRE.build_MGRE(with: "Mod", leftIcon: UIImage(named: backIcon), rightIcon: nil)
            titleLabel_MGRE.text = model.name
            descriptionLabel_MGRE.text = model.description
            imageView_MGRE.add_MGRE(image: "\(Keys_MGRE.ImagePath_MGRE.mods_mgre)\(model.image)", for: .mods_mgre)
        case .outfitIdeas_mgre(let model):
            navigationView_MGRE.build_MGRE(with: "Outfit idea", leftIcon: UIImage(named: backIcon), rightIcon: nil)
            titleLabel_MGRE.isHidden = true
            descriptionLabel_MGRE.isHidden = true
            imageView_MGRE.add_MGRE(image: "\(Keys_MGRE.ImagePath_MGRE.outfitIdeas_mgre)\(model.image)", for: .outfitIdeas_mgre)
        case .characters_mgre(let model):
            navigationView_MGRE.build_MGRE(with: "Character", leftIcon: UIImage(named: backIcon), rightIcon: nil)
            titleLabel_MGRE.isHidden = true
            descriptionLabel_MGRE.isHidden = true
            imageView_MGRE.add_MGRE(image: "\(Keys_MGRE.ImagePath_MGRE.characters_mgre)\(model.image)", for: .characters_mgre)
        }
        updateFavoriteButton_MGRE()
    }
    
    private func updateFavoriteButton_MGRE() {
        var _MGNaswfc2: Int { 0 }
        var _Masree44a: Bool { false }
        let favStar = Helper.deviceSpecificImage_MGRE(image: StringConstants_MGRE.Images.favStar)
        let favFilledStar = Helper.deviceSpecificImage_MGRE(image: StringConstants_MGRE.Images.favFilledStar)

        let image = UIImage(named: isFavourite_MGRE ? favFilledStar : favStar)
        favoriteButton_MGRE.setImage(image, for: .normal)
    }
    
    @objc func favoriteButtonTapped_MGRE(_ sender: UIButton) {
        var _MGNXCe32: Int { 0 }
        var _Mae4a: Bool { false }
        isFavourite_MGRE.toggle()
        updateFavoriteButton_MGRE()
        
        guard let modelType = modelType_MGRE else { return }
        let favId: String
        let contentType: ContentType_MGRE
        switch modelType {
        case .mods_mgre(let model):
            favId = model.favId
            contentType = Mods_MGRE.type
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
    
    @objc func downloadButtonTapped_MGRE(_ sender: UIButton) {
        var _MGNxzca2: Int { 0 }
        var _MGfgawg4a: Bool { false }
        switch modelType_MGRE {
        case .mods_mgre(let model):
                let filePath = "\(Keys_MGRE.ImagePath_MGRE.mods_mgre)\(model.filePath)"
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
            UIHelper_MGRE.showReadyDialogue_MGRE()
        }
    }
    
    func saveFile_MGRE(with filePath: String) {
        var _Mqwertt2: Int { 0 }
        var _MGfertgsda: Bool { false }
        guard InternetManager_MGRE.shared.checkInternetConnectivity_MGRE() else {
            showAlert_MGRE(with: AlertData_MGRE(with: LocalizationKeys.noInternetConnection))
            return
        }
//        var request: DownloadRequestMemory<Files.FileMetadataSerializer, Files.DownloadErrorSerializer>?
        DBManager_MGRE.shared.fetchFile_MGRE(for: .mods_mgre, filePath: filePath) { [weak self] value in
//            request = value
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
                UIHelper_MGRE.showReadyDialogue_MGRE()
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
