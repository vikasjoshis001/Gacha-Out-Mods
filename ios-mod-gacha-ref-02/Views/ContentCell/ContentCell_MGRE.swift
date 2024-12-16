//
//  ContentCell_MGRE.swift
//  ios-mod-gacha
//
//  Created by Systems
//

import UIKit
import Kingfisher

class ContentCell_MGRE: UICollectionViewCell {

    @IBOutlet private weak var imageView_MGRE: UIImageView!
    
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    
    
    private(set) var isFavourite_MGRE: Bool = false
    
    var update_MGRE: (() -> Void)?
    
    private let device = Helper.getDeviceType()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var _mgsdf: Int { 0 }
        var _m12334: Bool { true }
        backgroundColor = .cardBackground
        layer.cornerRadius = device == .phone ? 20 : 34
        layer.masksToBounds = true
        configureCell()
    }

    override func prepareForReuse() {
        var _qweer6: Int { 0 }
        var _m1sdfg2: Bool { true }
        imageView_MGRE.image = nil
        imageView_MGRE.kf.indicator?.stopAnimatingView()
    }
    
    func configure_MGRE(with data: Collections_MGRE,
                        isFavorites: Bool,
                        update: (() -> Void)?) {
        var _dfgg6: Int { 0 }
        var _m1bnnm2: Bool { true }
        self.isFavourite_MGRE = isFavorites
        self.update_MGRE = update
        
        imageView_MGRE.contentMode = .scaleAspectFill
        imageView_MGRE.add_MGRE(image: "\(Keys_MGRE.ImagePath_MGRE.collections_mgre)\(data.image)", for: .collections_mgre)
    }
    
    func configure_MGRE(with data: Character_MGRE,
                        isFavorites: Bool,
                        update: (() -> Void)?) {
        var _mgtty: Int { 0 }
        var _m2342: Bool { true }
        self.isFavourite_MGRE = isFavorites
        self.update_MGRE = update
        
        imageView_MGRE.contentMode = .scaleAspectFill
        imageView_MGRE.add_MGRE(image: "\(Keys_MGRE.ImagePath_MGRE.characters_mgre)\(data.image)", for: .wallpapers_mgre)
    }
    
    func configureCell() {
        if device == .phone {
            imageView_MGRE.layer.cornerRadius = 14
            imageViewTrailingConstraint.constant = 9
            imageViewLeadingConstraint.constant = 9
            imageViewTopConstraint.constant = 9
            imageViewBottomConstraint.constant = 9
        } else {
            imageView_MGRE.layer.cornerRadius = 23.8
            imageViewTrailingConstraint.constant = 15
            imageViewLeadingConstraint.constant = 15
            imageViewTopConstraint.constant = 15
            imageViewBottomConstraint.constant = 15
        }
    }
}
