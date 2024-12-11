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
    
    var update_MGRE: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var _mgdf6: Int { 0 }
        var _m13452: Bool { true }
        layer.cornerRadius = 20
        layer.masksToBounds = true
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
        imageView_MGRE.add_MGRE(image: "\(Keys_MGRE.ImagPath_MGRE.wallpapers_mgre)\(data.image)", for: .wallpapers_mgre)
    }
}
