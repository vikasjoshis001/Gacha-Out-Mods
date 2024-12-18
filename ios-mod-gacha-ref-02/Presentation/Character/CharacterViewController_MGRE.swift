//
//  CharacterViewController_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Vikas Joshi on 18/12/24.
//

import Photos
import UIKit

class CharacterViewController_MGRE: UIViewController {
    private let backgroundImageView_MGRE: UIImageView = {
        let backgroundImageView = UIImageView(image: UIImage(named: Helper.deviceSpecificImage(image: StringConstants.Images.editorBackground)))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.isUserInteractionEnabled = true
        return backgroundImageView
    }()
    
    var characterImageView_MGRE: UIImageView = {
        let characterImageView_MGRE = UIImageView()
        characterImageView_MGRE.contentMode = .scaleAspectFill
        characterImageView_MGRE.translatesAutoresizingMaskIntoConstraints = false
        characterImageView_MGRE.isUserInteractionEnabled = true // Enable user interaction
        return characterImageView_MGRE
    }()

    private let downloadButton_MGRE = CharacterViewController_MGRE.makeActionButton_MGRE(title: LocalizationKeys.download)

    let navigationView_MGRE = NavigationView_MGRE()
    var toggleMenuAction_MGRE: (() -> Void)?
    private let device = Helper.getDeviceType()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewHierarchy_MGRE()
        configureLayout_MGRE()
        configureView_MGRE()
        configureNavigationView_MGRE()
    }

    private static func makeActionButton_MGRE(image: String? = nil, title: String? = nil) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .buttonBg
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        if let image = image {
            button.setImage(UIImage(named: Helper.deviceSpecificImage(image: image)), for: .normal)
        } else if let title = title {
            button.setTitle(title, for: .normal)
        }
        return button
    }
    
    private func setupViewHierarchy_MGRE() {
        view.addSubview(backgroundImageView_MGRE)
        
        backgroundImageView_MGRE.addSubview(navigationView_MGRE)
        backgroundImageView_MGRE.addSubview(characterImageView_MGRE)
        backgroundImageView_MGRE.addSubview(downloadButton_MGRE)
    }
    
    private func configureView_MGRE() {
        downloadButton_MGRE.addTarget(self, action: #selector(downloadButtonDidTapped_MGRE(_:)), for: .touchUpInside)
        
        let downloadButtonFontSize: CGFloat = device == .phone ? 20 : 34
        let downloadButtonCornerRadius: CGFloat = device == .phone ? 14 : 23.8

        downloadButton_MGRE.titleLabel?.font = UIFont(name: StringConstants.ptSansRegular, size: downloadButtonFontSize)
        downloadButton_MGRE.setTitleColor(.black, for: .normal)
        downloadButton_MGRE.layer.cornerRadius = downloadButtonCornerRadius
    }
    
    private func configureLayout_MGRE() {
        let characterImageViewHeight: CGFloat = device == .phone ? 531 : 918
        let characterImageViewWidth: CGFloat = device == .phone ? 309 : 535.5
        
        let downloadButtonHeight: CGFloat = device == .phone ? 38 : 64.6
        let downloadButtonWidth: CGFloat = device == .phone ? 224 : 380
        
        let bottomInset = Helper.getBottomInset()
        let iphoneBottomConstraints: CGFloat = bottomInset == 0 ? 34 : 0
        let downloadButtonBottom: CGFloat = device == .phone ? -iphoneBottomConstraints : -40
        
        navigationView_MGRE.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            backgroundImageView_MGRE.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView_MGRE.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView_MGRE.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView_MGRE.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
            navigationView_MGRE.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView_MGRE.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView_MGRE.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            characterImageView_MGRE.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterImageView_MGRE.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            characterImageView_MGRE.heightAnchor.constraint(equalToConstant: characterImageViewHeight),
            characterImageView_MGRE.widthAnchor.constraint(equalToConstant: characterImageViewWidth),
                
            // Left and right buttons size
            downloadButton_MGRE.heightAnchor.constraint(equalToConstant: downloadButtonHeight),
            downloadButton_MGRE.widthAnchor.constraint(equalToConstant: downloadButtonWidth),
            downloadButton_MGRE.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton_MGRE.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: downloadButtonBottom)
        ])
    }
    
    private func configureNavigationView_MGRE() {
        navigationView_MGRE.build_MGRE(with: "Editor",
                                  leftIcon: UIImage(.backChevronIcon),
                                  rightIcon: nil)
        navigationView_MGRE.leftButtonAction_MGRE = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
//        navigationView.build_MGRE(with: "Editor", rightIcon: nil)
//        navigationView.leftButtonAction_MGRE = { [weak self] in
//            self?.toggleMenuAction_MGRE?()
//        }
    }
    
    @objc func downloadButtonDidTapped_MGRE(_ sender: UIButton) {
        var _mdzzz: Int { 0 }
        var _maaa: Bool { true }
        save_MGRE(image: characterImageView_MGRE.image)
    }
    
    func save_MGRE(image: UIImage?) {
        var _mdjjjj: Int { 0 }
        var _m3kkkk: Bool { true }
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
        var _mdggg: Int { 0 }
        var _mhhh: Bool { true }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSaved_MGRE(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc
    func imageSaved_MGRE(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        var _mssss: Int { 0 }
        var _m3fff: Bool { true }
        if let error = error {
            print("Ошибка сохранения изображения: \(error.localizedDescription)")
        } else {
            UIHelper.showReadyDialogue()
        }
    }
}
