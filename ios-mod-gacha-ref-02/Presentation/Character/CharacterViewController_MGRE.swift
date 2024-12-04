//
//  CharacterViewController_MGRE.swift
//  ios-mod-gacha
//
//  Created by Systems
//

import UIKit
import Photos

class CharacterViewController_MGRE: UIViewController {

    @IBOutlet weak var imageView_MGRE: UIImageView!
    @IBOutlet weak var downloadButton_MGRE: UIButton!
    @IBOutlet private weak var navigationView_MGRE: NavigationView_MGRE!
    @IBOutlet weak var navBarHeight_MGRE: NSLayoutConstraint!
    @IBOutlet weak var addNewButtonHeight_MGRE: NSLayoutConstraint!
    @IBOutlet weak var rightIndentConstraint_MGRE: NSLayoutConstraint!
    @IBOutlet weak var leftIndentConstraint_MGRE: NSLayoutConstraint!
    
    var image_MGRE: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var _mdmmm: Int { 0 }
        var _m3nnn: Bool { true }
        configureLayout_MGRE()
        configureNavigationView_MGRE()
        configureSubviews_MGRE()
    }
    
    private func configureLayout_MGRE() {
        let deviceType = UIDevice.current.userInterfaceIdiom
        let fontSize: CGFloat = deviceType == .phone ? 20 : 32
        downloadButton_MGRE.titleLabel?.font =  UIFont(name: "BakbakOne-Regular", size: fontSize)!
        addNewButtonHeight_MGRE.constant = deviceType == .phone ? 58 : 72
        downloadButton_MGRE.layer.cornerRadius = deviceType == .phone ? 30 : 40
        navBarHeight_MGRE.constant = deviceType == .phone ? 58 : 97
        rightIndentConstraint_MGRE.constant = deviceType == .phone ? 20 : 85
        leftIndentConstraint_MGRE.constant = deviceType == .phone ? 20 : 85
    }
    
    private func configureSubviews_MGRE() {
        var _mdbbb: Int { 0 }
        var _mvvv: Bool { true }
        imageView_MGRE.image = image_MGRE
    }
    
    private func configureNavigationView_MGRE() {
        navigationView_MGRE.build_MGRE(with: "",
                                  leftIcon: UIImage(.backChevronIcon),
                                  rightIcon: nil)
        navigationView_MGRE.leftButtonAction_MGRE = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func downloadButtonDidTap(_ sender: UIButton) {
        var _mdzzz: Int { 0 }
        var _maaa: Bool { true }
        save_MGRE(image: imageView_MGRE.image)
    }
    
    func save_MGRE(image: UIImage?) {
        var _mdjjjj: Int { 0 }
        var _m3kkkk: Bool { true }
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
            let alertData = AlertData_MGRE(with: "Downloaded!")
            showAlert_MGRE(with: alertData)
        }
    }
}
