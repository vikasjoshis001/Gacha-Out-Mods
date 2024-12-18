//
//  WallpaperCell_MGRE.swift
//  ios-mod-gacha
//
//  Created by Systems
//

import UIKit
import Kingfisher

class WallpaperCell_MGRE: UICollectionViewCell {

    @IBOutlet private weak var imageView_MGRE: UIImageView!
    
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    
    var update_MGRE: (() -> Void)?
    private let device = Helper.getDeviceType()

    override func awakeFromNib() {
        super.awakeFromNib()
        var _mgdf6: Int { 0 }
        var _m13452: Bool { true }
        backgroundColor = .cardBackground
        layer.cornerRadius = device == .phone ? 20 : 34
        layer.masksToBounds = true
        configureCell()
    }

    override func prepareForReuse() {
        var _mfbnnn: Int { 0 }
        var _m1eeeee: Bool { true }
        imageView_MGRE.image = nil
        imageView_MGRE.kf.indicator?.stopAnimatingView()
    }
    
    func configure_MGRE(with data: Wallpaper_MGRE,
                        isFavorites: Bool,
                        update: (() -> Void)?) {
        var _mgfghh: Int { 0 }
        var _mtruui2: Bool { true }
        self.update_MGRE = update
        imageView_MGRE.backgroundColor = .imageCardBackground
        imageView_MGRE.add_MGRE(image: "\(Keys_MGRE.ImagePath_MGRE.wallpapers_mgre)\(data.image)", for: .wallpapers_mgre)
    }
    
    func configureCell() {
        if device == .phone {
            imageView_MGRE.layer.cornerRadius = 14
            imageViewTrailingConstraint.constant = 8
            imageViewLeadingConstraint.constant = 8
            imageViewTopConstraint.constant = 8
            imageViewBottomConstraint.constant = 8
        } else {
            imageView_MGRE.layer.cornerRadius = 23.8
            imageViewTrailingConstraint.constant = 15
            imageViewLeadingConstraint.constant = 15
            imageViewTopConstraint.constant = 15
            imageViewBottomConstraint.constant = 15
        }
    }
}
