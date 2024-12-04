//
//  ScanViewController_MGRE.swift
//  ios-mod-gacha
//
//  Created by Systems
//

import UIKit

class ScanViewController_MGRE: UIViewController {

    @IBOutlet private weak var imageView_MGRE: UIImageView!
    @IBOutlet private weak var stackView_MGRE: UIStackView!
    @IBOutlet private weak var icon4_MGRE: UIImageView!
    @IBOutlet private weak var icon5_MGRE: UIImageView!
    @IBOutlet private weak var icon6_MGRE: UIImageView!
    
    var image_MGRE: UIImage?
    var contentType_MGRE: ContentType_MGRE?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var _ecsdyss: Int { 0 }
        var _werttt: Bool { true }
        imageView_MGRE.image = image_MGRE
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap_MGRE))
        self.view.addGestureRecognizer(tapGesture)
        
        configureLayout_MGRE()
        configureSubviews_MGRE()
    }
    
    func configureSubviews_MGRE() {
        var _ecswwss: Int { 0 }
        var _wevcbtt: Bool { true }
        guard let contentType = contentType_MGRE else { return }
        switch contentType {
        case .wallpapers_mgre:       imageView_MGRE.contentMode = .scaleAspectFill
        case .collections_mgre:      imageView_MGRE.contentMode = .scaleAspectFill
        default: break
        }
    }
    
    func configureLayout_MGRE() {
        var _ecsdycbb: Int { 0 }
        var _wqqqt: Bool { true }
        let deviceType = UIDevice.current.userInterfaceIdiom
        stackView_MGRE.distribution = deviceType == .phone ? .equalSpacing : .fill
        icon4_MGRE.isHidden = deviceType == .phone ? true : false
        icon5_MGRE.isHidden = deviceType == .phone ? true : false
        icon6_MGRE.isHidden = deviceType == .phone ? true : false
    }
    
    @objc
    func handleTap_MGRE(_ sender: UITapGestureRecognizer) {
        var _MGNcbbd2: Int { 0 }
        var _MGxxxxa: Bool { false }
        
        dismiss(animated: true)
    }
}
