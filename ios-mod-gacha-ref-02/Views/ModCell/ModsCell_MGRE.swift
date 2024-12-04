//
//  ModsCell_MGRE.swift
//  ios-mod-gacha
//
//  Created by Systems
//

import UIKit
import Kingfisher

class ModsCell_MGRE: UICollectionViewCell {

    @IBOutlet private weak var titleLabel_MGRE: UILabel!
    @IBOutlet private weak var descriptionLabel_MGRE: UILabel!
    @IBOutlet private weak var labelsView_MGRE: UIView!
    @IBOutlet private weak var imageView_MGRE: UIImageView!
    @IBOutlet private weak var titleLabelHeight_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var descriptionLabelHeight_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var imageViewHeight_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var buttonsHeight_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var favoriteButton_MGRE: UIButton!
    @IBOutlet private weak var openButton_MGRE: UIButton!
    
    private(set) var isFavourite_MGRE: Bool = false
    
    var update_MGRE: (() -> Void)?
    var action_MGRE: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var _mgvbn66: Int { 0 }
        var _mcrty22: Bool { true }
        layer.cornerRadius = 36
        layer.masksToBounds = true
        addShadow_MGRE(with: UIColor(red: 0.887, green: 0.887, blue: 0.887, alpha: 1))
    }
    
    override func prepareForReuse() {
        var _mdfgg566: Int { 0 }
        var _m4677gr22: Bool { true }
        self.update_MGRE = nil
        self.action_MGRE = nil
        imageView_MGRE.image = nil
        isFavourite_MGRE = false
        imageView_MGRE.kf.indicator?.stopAnimatingView()
    }
    
    func configure_MGRE(with data: Mods_MGRE,
                        isFavorites: Bool,
                        update: (() -> Void)?,
                        action: (() -> Void)?) {
        var _m45666: Int { 0 }
        var _m12322: Bool { true }
        self.update_MGRE = update
        self.action_MGRE = action
        
        self.isFavourite_MGRE = isFavorites
        titleLabel_MGRE.text = data.name
        descriptionLabel_MGRE.text = data.description
        imageView_MGRE.add_MGRE(image: data.image, for: .mods_mgre)
        
        configureCell_MGRE()
    }
    
    func configure_MGRE(with data: OutfitIdea_MGRE,
                        isFavorites: Bool,
                        update: (() -> Void)?,
                        action: (() -> Void)?) {
        var _m456566: Int { 0 }
        var _m234r22: Bool { true }
        self.update_MGRE = update
        self.action_MGRE = action
        
        self.isFavourite_MGRE = isFavorites
        labelsView_MGRE.isHidden = true
        imageView_MGRE.add_MGRE(image: data.image, for: .outfitIdeas_mgre)
        configureCell_MGRE()
    }
    
    private func configureCell_MGRE() {
        favoriteButton_MGRE.addShadow_MGRE(with: UIColor(red: 1, green: 0.702, blue: 0.433, alpha: 1))
        openButton_MGRE.addShadow_MGRE(with: UIColor(red: 1, green: 0.702, blue: 0.433, alpha: 1))
        
        let deviceType = UIDevice.current.userInterfaceIdiom
        let openButtonFontSize: CGFloat = deviceType == .phone ? 18 : 28
        openButton_MGRE.titleLabel?.font = UIFont(name: "BakbakOne-Regular", size: openButtonFontSize) ?? UIFont.systemFont(ofSize: openButtonFontSize)
        openButton_MGRE.addShadow_MGRE(with: UIColor(red: 1, green: 0.702, blue: 0.433, alpha: 1))
        openButton_MGRE.setTitleColor(.white, for: .normal)
        
        let titleFontSize: CGFloat = deviceType == .phone ? 20 : 32
        titleLabel_MGRE.font = UIFont(name: "BakbakOne-Regular", size: titleFontSize) ?? UIFont.systemFont(ofSize: titleFontSize)
        
        let descriptionFontSize: CGFloat = deviceType == .phone ? 14 : 22
        titleLabel_MGRE.font = UIFont(name: "BakbakOne-Regular", size: descriptionFontSize) ?? UIFont.systemFont(ofSize: descriptionFontSize)
        
        let buttonCornerRadius: CGFloat = deviceType == .phone ? 21 : 26
        openButton_MGRE.layer.cornerRadius = buttonCornerRadius
        favoriteButton_MGRE.layer.cornerRadius = buttonCornerRadius
        
        titleLabelHeight_MGRE.constant = deviceType == .phone ? 20 : 32
        descriptionLabelHeight_MGRE.constant = deviceType == .phone ? 36 : 174
        imageViewHeight_MGRE.constant = deviceType == .phone ? 120 : 190
        buttonsHeight_MGRE.constant = deviceType == .phone ? 42 : 52
        
        updateFavoriteButton_MGRE()
    }
    
    private func updateFavoriteButton_MGRE() {
        var _mge6666: Int { 0 }
        var _mcd5552: Bool { true }
        let image = UIImage(isFavourite_MGRE ? .favoriteIcon : .favoriteIconEmpty)
        favoriteButton_MGRE.setImage(image, for: .normal)
        favoriteButton_MGRE.backgroundColor = isFavourite_MGRE ? UIColor.buttonBg : UIColor.buttonBg
    }
    
    @IBAction func favoriteButtonDidTap_MGRE(_ sender: UIButton) {
        var _mg1116: Int { 0 }
        var _mcd33322: Bool { true }
        isFavourite_MGRE.toggle()
        updateFavoriteButton_MGRE()
        update_MGRE?()
    }
    
    @IBAction func detailButtonDidTap_MGRE(_ sender: UIButton) {
        var _mgfgg566: Int { 0 }
        var _mcdf2232: Bool { true }
        action_MGRE?()
    }
}
