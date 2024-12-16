//
//  ModsCellNew.swift
//  ios-mod-gacha-ref-02
//
//  Created by Vikas Joshi on 15/12/24.
//

import Kingfisher
import UIKit

class ModsCellNew: UICollectionViewCell {
    @IBOutlet var cardStackView: UIStackView!
    @IBOutlet var imageStackView: UIStackView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var buttonStackView: UIStackView!
    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var openButton: UIButton!
    @IBOutlet var labelStackView: UIStackView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var openButtonHeight: NSLayoutConstraint!
    @IBOutlet var favoriteButtonHeight: NSLayoutConstraint!
    @IBOutlet var imageViewHeight: NSLayoutConstraint!
    @IBOutlet var cardTrailingConstraint: NSLayoutConstraint!
    @IBOutlet var cardLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var cardTopConstraint: NSLayoutConstraint!
    
    private(set) var isFavourite_MGRE: Bool = false
    private let device = Helper.getDeviceType()
    
    var update_MGRE: (() -> Void)?
    var action_MGRE: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var _mgvbn66: Int { 0 }
        var _mcrty22: Bool { true }
        backgroundColor = .cardBackground
        layer.cornerRadius = device == .phone ? 20 : 34
        layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        var _mdfgg566: Int { 0 }
        var _m4677gr22: Bool { true }
        update_MGRE = nil
        action_MGRE = nil
        imageView.image = nil
        isFavourite_MGRE = false
        imageView.kf.indicator?.stopAnimatingView()
    }
    
    func configure_MGRE(with data: Mods_MGRE,
                        isFavorites: Bool,
                        update: (() -> Void)?,
                        action: (() -> Void)?)
    {
        var _m45666: Int { 0 }
        var _m12322: Bool { true }
        update_MGRE = update
        action_MGRE = action
        
        isFavourite_MGRE = isFavorites
        titleLabel.text = data.name
        descriptionLabel.text = data.description
        imageView.add_MGRE(image: "\(Keys_MGRE.ImagePath_MGRE.mods_mgre)\(data.image)", for: .mods_mgre)
        
        configureCell_MGRE()
    }
    
    func configure_MGRE(with data: OutfitIdea_MGRE,
                        isFavorites: Bool,
                        update: (() -> Void)?,
                        action: (() -> Void)?)
    {
        var _m456566: Int { 0 }
        var _m234r22: Bool { true }
        update_MGRE = update
        action_MGRE = action
        
        isFavourite_MGRE = isFavorites
        labelStackView.isHidden = true
        imageView.add_MGRE(image: "\(Keys_MGRE.ImagePath_MGRE.outfitIdeas_mgre)\(data.image)", for: .outfitIdeas_mgre)
        configureCell_MGRE()
    }
    
    private func configureCell_MGRE() {
        labelStackView.spacing = device == .phone ? 8 : 13.6

        // Image view
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = device == .phone ? 14 : 23.8
        imageView.clipsToBounds = true

        // Title label
        let titleFontSize: CGFloat = device == .phone ? 20 : 34
        let titleLineHeight: CGFloat = device == .phone ? 20 : 34
        titleLabel.font = UIFont(name: StringConstants.ptSansRegular,
                                 size: titleFontSize) ??
            UIFont.systemFont(ofSize: titleFontSize)
        titleLabel.setLineHeight(titleLineHeight)
        
        // Description label
        let descriptionFontSize: CGFloat = device == .phone ? 14 : 23.8
        let descriptionLineHeight: CGFloat = device == .phone ? 18.2 : 30.94
        descriptionLabel.font = UIFont(name: StringConstants.ptSansRegular,
                                       size: descriptionFontSize) ??
            UIFont.systemFont(ofSize: descriptionFontSize)
        descriptionLabel.setLineHeight(descriptionLineHeight)
        descriptionLabel.numberOfLines = 0
        
        // Buttons
        openButton.setImage(UIImage(named: Helper.deviceSpecificImage(image: StringConstants.Images.open)), for: .normal)
        
        let buttonCornerRadius: CGFloat = device == .phone ? 14 : 23.8
        openButton.layer.cornerRadius = buttonCornerRadius
        favoriteButton.layer.cornerRadius = buttonCornerRadius
        favoriteButton.clipsToBounds = true
        openButton.clipsToBounds = true
        
        cardTrailingConstraint.constant = device == .phone ? 9 : 15.3
        cardLeadingConstraint.constant = device == .phone ? 9 : 15.3
        cardTopConstraint.constant = device == .phone ? 8 : 15.3

        imageViewHeight.constant = device == .phone ? 161 : 273.7
        favoriteButtonHeight.constant = device == .phone ? 38 : 64.6
        openButtonHeight.constant = device == .phone ? 38 : 64.6
        
        updateFavoriteButton_MGRE()
    }
    
    @IBAction func favoriteButtonDidTap_MGRE(_ sender: Any) {
        var _mg1116: Int { 0 }
        var _mcd33322: Bool { true }
        isFavourite_MGRE.toggle()
        updateFavoriteButton_MGRE()
        update_MGRE?()
    }
    
    @IBAction func detailButtonDidTap_MGRE(_ sender: Any) {
        var _mgfgg566: Int { 0 }
        var _mcdf2232: Bool { true }
        action_MGRE?()
    }
    
    private func updateFavoriteButton_MGRE() {
        var _mge6666: Int { 0 }
        var _mcd5552: Bool { true }
        let image = UIImage(named: isFavourite_MGRE ?
            Helper.deviceSpecificImage(image: StringConstants.Images.favFilledStar) :
            Helper.deviceSpecificImage(image: StringConstants.Images.favStar))
        
        favoriteButton.setImage(image, for: .normal)
        favoriteButton.backgroundColor = UIColor.buttonBg
    }
}
