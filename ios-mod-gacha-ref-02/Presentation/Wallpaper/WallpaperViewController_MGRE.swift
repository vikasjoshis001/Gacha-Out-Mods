//
//  WallpaperViewController_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Vikas Joshi on 16/12/24.
//

import Photos
import UIKit

// MARK: - WallpaperViewController_MGRE

class WallpaperViewController_MGRE: UIViewController {
    // MARK: - Types

    enum ModelType_MGRE {
        case wallpapers(Wallpaper_MGRE)
        case collections(Collections_MGRE)
    }
    
    // MARK: - UI Components

    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.masksToBounds = true
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.masksToBounds = true
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private let leftButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .buttonBg
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let navigationView = NavigationView_MGRE()
    
    var modelType_MGRE: ModelType_MGRE?
    var contentType_MGRE: ContentType_MGRE?
    var isFavourite_MGRE: Bool = false
    let device = Helper.getDeviceType()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureLayout()
        configureSubviews()
    }
    
    // MARK: - Private Methods

    private func setupView() {
        view.backgroundColor = .appBackground
    }
    
    private func configureLayout() {
        setupViewHierarchy()
        setupConstraints()
        configureStackViews()
        configureButtons()
    }
    
    private func setupViewHierarchy() {
        view.addSubview(navigationView)
        view.addSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(imageView)
        verticalStackView.addArrangedSubview(buttonStackView)
        
        buttonStackView.addArrangedSubview(shareButton)
        buttonStackView.addArrangedSubview(leftButtonsStackView)
        
        leftButtonsStackView.addArrangedSubview(downloadButton)
        leftButtonsStackView.addArrangedSubview(favoriteButton)
    }
    
    private func configureStackViews() {
        navigationView.translatesAutoresizingMaskIntoConstraints = false

        let stackInsets = device == .phone ? 8.0 : 14.0
        verticalStackView.layoutMargins = UIEdgeInsets(top: stackInsets,
                                                       left: stackInsets,
                                                       bottom: stackInsets,
                                                       right: stackInsets)
        verticalStackView.layer.cornerRadius = device == .phone ? 20 : 34
        verticalStackView.spacing = 17
        verticalStackView.backgroundColor = .cardBackground
        
        leftButtonsStackView.spacing = 10
    }
    
    private func configureButtons() {
        imageView.layer.cornerRadius = device == .phone ? 14.0 : 23.8
        // Set Imaged
        downloadButton.setImage(UIImage(named: Helper.deviceSpecificImage(image: StringConstants.Images.download)), for: .normal)
        shareButton.setImage(UIImage(named: Helper.deviceSpecificImage(image: StringConstants.Images.share)), for: .normal)
        
        // Set Corner Radius
        let cornerRadius = device == .phone ? 14.0 : 23.8
        let buttons = [favoriteButton, downloadButton, shareButton]
        buttons.forEach { button in
            button.layer.cornerRadius = cornerRadius
        }

        // Set Actions
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        downloadButton.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
    }
        
    // MARK: - Helpers

    func configureSubviews() {
        guard let modelType = modelType_MGRE else { return }
        navigationView.leftButtonAction_MGRE = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        navigationView.rightButtonAction_MGRE = { [weak self] in
            self?.scan_MGRE()
        }
        let leftButton = UIImage(named: Helper.deviceSpecificImage(image: StringConstants.Images.back))
        let rightButton = UIImage(named: Helper.deviceSpecificImage(image: StringConstants.Images.fullScreen))

        switch modelType {
        case .wallpapers(let model):
            navigationView.build_MGRE(with: "Wallpaper", leftIcon: leftButton, rightIcon: rightButton)
            imageView.add_MGRE(image: "\(Keys_MGRE.ImagePath_MGRE.wallpapers_mgre)\(model.image)", for: .wallpapers_mgre)
            imageView.contentMode = .scaleAspectFill
            contentType_MGRE = .wallpapers_mgre
        case .collections(let model):
            navigationView.build_MGRE(with: "Collection", leftIcon: leftButton, rightIcon: rightButton)
            imageView.add_MGRE(image: "\(Keys_MGRE.ImagePath_MGRE.collections_mgre)\(model.image)", for: .collections_mgre)
            imageView.contentMode = .scaleAspectFill
            contentType_MGRE = .collections_mgre
        }
        
        updateFavoriteButton_MGRE()
    }
    
    private func scan_MGRE() {
        var _MGNq161662: Int { 0 }
        var _MGfg1717a: Bool { false }
        guard let image = imageView.image else { return }
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
        let favStar = UIImage(named: Helper.deviceSpecificImage(image: StringConstants.Images.favStar))
        let favFilledStar = UIImage(named: Helper.deviceSpecificImage(image: StringConstants.Images.favFilledStar))

        favoriteButton.setImage(isFavourite_MGRE ? favStar : favFilledStar, for: .normal)
    }
    
    // MARK: - Actions

    @objc func favoriteButtonTapped() {
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
    
    @objc func downloadButtonTapped() {
        var _MGN777r2: Int { 0 }
        var _MGf8888a: Bool { false }
        guard let image = imageView.image else { return }
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
    
    @objc func imageSaved_MGRE(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        var _MGNq1112: Int { 0 }
        var _MGfg222a: Bool { false }
        if let error = error {
            print("Ошибка сохранения изображения: \(error.localizedDescription)")
        } else {
            UIHelper.showReadyDialogue()
        }
    }
    
    @objc func shareButtonTapped() {
        var _MGNq3332: Int { 0 }
        var _MGfg444a: Bool { false }
        guard let image = imageView.image else { return }
        guard InternetManager_MGRE.shared.checkInternetConnectivity_MGRE() else {
            showAlert_MGRE(with: AlertData_MGRE(with: LocalizationKeys.noInternetConnection))
            return
        }
        
        var fileName: String?
        var type = ""
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
        activityViewController.completionWithItemsHandler = { [weak self] _, completed, _, _ in
            if completed {
                let alertData = AlertData_MGRE(with: "Success!")
                self?.showAlert_MGRE(with: alertData)
            }
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            activityViewController.modalPresentationStyle = .popover
                
            if let popoverPresentationController = activityViewController.popoverPresentationController {
                popoverPresentationController.sourceView = view
                popoverPresentationController.sourceRect = CGRect(x: view.bounds.midX,
                                                                  y: view.bounds.midY,
                                                                  width: 0,
                                                                  height: 0)
                popoverPresentationController.permittedArrowDirections = []
            }
        }
            
        present(activityViewController, animated: true)
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

// MARK: - Layout

private extension WallpaperViewController_MGRE {
    func setupConstraints() {
        let imageHeight = device == .phone ? 500.0 : 890.0
        let buttonSize = device == .phone ? 38.0 : 64.6
        let leadingAnchor = device == .phone ? 29.0 : 180.0
        
        NSLayoutConstraint.activate([
            // Navigation
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // Vertical Stack
            verticalStackView.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 6),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leadingAnchor),
            
            // Image
            imageView.heightAnchor.constraint(equalToConstant: imageHeight),
            
            // Buttons
            shareButton.heightAnchor.constraint(equalToConstant: buttonSize),
            shareButton.widthAnchor.constraint(equalTo: shareButton.heightAnchor),
            downloadButton.heightAnchor.constraint(equalToConstant: buttonSize),
            downloadButton.widthAnchor.constraint(equalTo: downloadButton.heightAnchor),
            favoriteButton.heightAnchor.constraint(equalToConstant: buttonSize),
            favoriteButton.widthAnchor.constraint(equalTo: favoriteButton.heightAnchor)
        ])
    }
}
