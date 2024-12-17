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
        
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
        
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .buttonBg
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .buttonBg
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private let verticalStackView: UIStackView = {
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
    
    private let spacerView: UIView = {
        let view = UIView()
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return view
    }()
    
    private let navigationView_MGRE = NavigationView_MGRE()
    
    let device = Helper.getDeviceType()
    var modelType_MGRE: ModelType_MGRE?
    var isFavourite_MGRE: Bool = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBackground
    
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        downloadButton.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
        
        setupViews()
        configureSubviews_MGRE()
    }
    
    private func getImageContainerHeight() -> CGFloat {
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
        
    private func setupViews() {
        // config
        let verticalStackViewLeadingAnchor: CGFloat = device == .phone ? 29 : 180
        let imageContainerHeight: CGFloat = getImageContainerHeight()
        let favButtonTrailingAnchor: CGFloat = device == .phone ? 5 : 8.5
        let favButtonHeight: CGFloat = device == .phone ? 38 : 64.6

        imageView.layer.cornerRadius = device == .phone ? 14 : 23.8
        
        favoriteButton.layer.cornerRadius = device == .phone ? 14 : 23.8
        favoriteButton.setImage(UIImage(named: Helper.deviceSpecificImage(image: StringConstants.Images.favStar)), for: .normal)
        
        let downloadButtonFontSize: CGFloat = device == .phone ? 20 : 34
        downloadButton.layer.cornerRadius = device == .phone ? 14 : 23.8
        downloadButton.setTitle(LocalizationKeys.download, for: .normal)
        downloadButton.titleLabel?.font = UIFont(name: StringConstants.ptSansRegular, size: downloadButtonFontSize)
        downloadButton.setTitleColor(.black, for: .normal)
        
        let titleLabelFontSize: CGFloat = device == .phone ? 20 : 34
        titleLabel.font = UIFont(name: StringConstants.ptSansRegular, size: titleLabelFontSize)
        titleLabel.textColor = .black
        titleLabel.setLineHeight(titleLabelFontSize)
        
        let descriptionLabelFontSize: CGFloat = device == .phone ? 14 : 23.8
        let descriptionLabelLineHeight: CGFloat = device == .phone ? 14 : 30.82
        descriptionLabel.font = UIFont(name: StringConstants.ptSansRegular, size: descriptionLabelFontSize)
        descriptionLabel.textColor = .black
        descriptionLabel.setLineHeight(descriptionLabelLineHeight)
        
        // Add views
        view.addSubview(navigationView_MGRE)
        view.addSubview(verticalStackView)

        navigationView_MGRE.translatesAutoresizingMaskIntoConstraints = false
        
        let verticalStackViewInsets: CGFloat = device == .phone ? 8 : 14
        verticalStackView.layer.cornerRadius = device == .phone ? 20 : 34
        verticalStackView.backgroundColor = .cardBackground
        verticalStackView.layoutMargins = UIEdgeInsets(top: verticalStackViewInsets,
                                                       left: verticalStackViewInsets,
                                                       bottom: verticalStackViewInsets,
                                                       right: verticalStackViewInsets)

        // Add image container
        let imageContainer = UIView()
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        imageContainer.addSubview(imageView)
        imageContainer.addSubview(favoriteButton)
                    
        // Add to stack view
        verticalStackView.addArrangedSubview(imageContainer)
        verticalStackView.addArrangedSubview(downloadButton)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(descriptionLabel)
        verticalStackView.addArrangedSubview(spacerView)

        // Set constraints
        NSLayoutConstraint.activate([
            // Navigation View
            navigationView_MGRE.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView_MGRE.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView_MGRE.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // Stack view constraints
            verticalStackView.topAnchor.constraint(equalTo: navigationView_MGRE.bottomAnchor, constant: 6),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: verticalStackViewLeadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -verticalStackViewLeadingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(Helper.getBottomConstraint())),
                
            // Image container constraints
            imageContainer.heightAnchor.constraint(equalToConstant: imageContainerHeight),
            
            // Image view constraints
            imageView.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor),
                
            // Favorite button constraints
            favoriteButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: favButtonTrailingAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: -favButtonTrailingAnchor),
            favoriteButton.heightAnchor.constraint(equalToConstant: favButtonHeight),
            favoriteButton.widthAnchor.constraint(equalToConstant: favButtonHeight),
                
            // Download button constraints
            downloadButton.heightAnchor.constraint(equalToConstant: favButtonHeight)
        ])
    }
    
    func configureSubviews_MGRE() {
        guard let modelType = modelType_MGRE else { return }
        navigationView_MGRE.leftButtonAction_MGRE = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        let backIcon = Helper.deviceSpecificImage(image: StringConstants.Images.back)
        switch modelType {
        case .mods_mgre(let model):
                navigationView_MGRE.build_MGRE(with: "Mod", leftIcon: UIImage(named: backIcon), rightIcon: nil)
            titleLabel.text = model.name
            descriptionLabel.text = model.description
            imageView.add_MGRE(image: "\(Keys_MGRE.ImagePath_MGRE.mods_mgre)\(model.image)", for: .mods_mgre)
        case .outfitIdeas_mgre(let model):
            navigationView_MGRE.build_MGRE(with: "Outfit idea", leftIcon: UIImage(named: backIcon), rightIcon: nil)
            titleLabel.isHidden = true
            descriptionLabel.isHidden = true
            imageView.add_MGRE(image: "\(Keys_MGRE.ImagePath_MGRE.outfitIdeas_mgre)\(model.image)", for: .outfitIdeas_mgre)
        case .characters_mgre(let model):
            navigationView_MGRE.build_MGRE(with: "Character", leftIcon: UIImage(named: backIcon), rightIcon: nil)
            titleLabel.isHidden = true
            descriptionLabel.isHidden = true
            imageView.add_MGRE(image: "\(Keys_MGRE.ImagePath_MGRE.characters_mgre)\(model.image)", for: .characters_mgre)
        }
        updateFavoriteButton_MGRE()
    }
    
    private func updateFavoriteButton_MGRE() {
        var _MGNaswfc2: Int { 0 }
        var _Masree44a: Bool { false }
        let favStar = Helper.deviceSpecificImage(image: StringConstants.Images.favStar)
        let favFilledStar = Helper.deviceSpecificImage(image: StringConstants.Images.favFilledStar)

        let image = UIImage(named: isFavourite_MGRE ? favFilledStar : favStar)
        favoriteButton.setImage(image, for: .normal)
    }
    
    @objc func favoriteButtonTapped(_ sender: UIButton) {
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
    
    @objc func downloadButtonTapped(_ sender: UIButton) {
        var _MGNxzca2: Int { 0 }
        var _MGfgawg4a: Bool { false }
        switch modelType_MGRE {
        case .mods_mgre(let model):
                let filePath = "\(Keys_MGRE.ImagePath_MGRE.mods_mgre)\(model.filePath)"
            saveFile_MGRE(with: filePath)
        case .outfitIdeas_mgre, .characters_mgre:
            save_MGRE(image: imageView.image)
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
            let alertData = AlertData_MGRE(with: "Downloaded!")
            showAlert_MGRE(with: alertData)
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
