//
//  OutfitIdeasCell_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Vikas Joshi on 16/12/24.
//

import UIKit

class OutfitIdeasCell_MGRE: UICollectionViewCell {
    static let identifier = "OutfitIdeasCell_MGRE"

    // MARK: - Properties

    private let verticalStackView_MGRE: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.layer.masksToBounds = true
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let imageView_MGRE: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .imageCardBackground
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let openButton_MGRE: UIButton = {
        let button = UIButton()
        button.setTitle(LocalizationKeys.open, for: .normal)
        button.backgroundColor = .buttonBg
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        return button
    }()
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.masksToBounds = true
        stackView.clipsToBounds = true
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        return label
    }()
        
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let favoriteButton_MGRE: UIButton = {
        let button = UIButton()
        button.backgroundColor = .buttonBg
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        return button
    }()
    
    private let buttonStackView_MGRE: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.layer.masksToBounds = true
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private(set) var isFavourite_MGRE: Bool = false
    private let device = Helper.getDeviceType()
    
    var update_MGRE: (() -> Void)?
    var action_MGRE: (() -> Void)?
    
    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }

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
        imageView_MGRE.image = nil
        isFavourite_MGRE = false
        imageView_MGRE.kf.indicator?.stopAnimatingView()
    }
    
    // MARK: - Actions

    @objc func favoriteButtonTapped_MGRE(_ sender: Any) {
        var _mg1116: Int { 0 }
        var _mcd33322: Bool { true }
        isFavourite_MGRE.toggle()
        updateFavoriteButton_MGRE()
        update_MGRE?()
    }
    
    @objc func detailButtonTapped_MGRE(_ sender: Any) {
        var _mgfgg566: Int { 0 }
        var _mcdf2232: Bool { true }
        action_MGRE?()
    }
    
    // MARK: - Helpers

    private func setupButtons() {
        favoriteButton_MGRE.addTarget(self, action: #selector(favoriteButtonTapped_MGRE), for: .touchUpInside)
        openButton_MGRE.addTarget(self, action: #selector(detailButtonTapped_MGRE), for: .touchUpInside)
    }
    
    func configure_MGRE(with data: OutfitIdea_MGRE,
                        isFavorites: Bool,
                        update: (() -> Void)?,
                        action: (() -> Void)?)
    {
        var _m45666: Int { 0 }
        var _m12322: Bool { true }
        update_MGRE = update
        action_MGRE = action
        
        labelStackView.isHidden = true
        
        isFavourite_MGRE = isFavorites
        imageView_MGRE.add_MGRE(image: "\(Keys_MGRE.ImagePath_MGRE.outfitIdeas_mgre)\(data.image)", for: .outfitIdeas_mgre)
        
        configureCell_MGRE()
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
        imageView_MGRE.add_MGRE(image: "\(Keys_MGRE.ImagePath_MGRE.mods_mgre)\(data.image)", for: .mods_mgre)
        
        configureCell_MGRE()
    }
        
    private func configureCell_MGRE() {
        // Adding subviews
        contentView.addSubview(verticalStackView_MGRE)
        
        verticalStackView_MGRE.addArrangedSubview(imageView_MGRE)
        verticalStackView_MGRE.addArrangedSubview(labelStackView)
        verticalStackView_MGRE.addArrangedSubview(buttonStackView_MGRE)
        
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(descriptionLabel)
        
        buttonStackView_MGRE.addArrangedSubview(openButton_MGRE)
        buttonStackView_MGRE.addArrangedSubview(favoriteButton_MGRE)
        
        // Configure stack view appearance
        let verticalStackViewInsets: CGFloat = device == .phone ? 8 : 15.3
        verticalStackView_MGRE.layer.cornerRadius = device == .phone ? 20 : 34
        verticalStackView_MGRE.backgroundColor = .cardBackground
        verticalStackView_MGRE.layoutMargins = UIEdgeInsets(top: verticalStackViewInsets,
                                                            left: verticalStackViewInsets,
                                                            bottom: verticalStackViewInsets,
                                                            right: verticalStackViewInsets)
        
        verticalStackView_MGRE.spacing = device == .phone ? 7 : 12
                
        // Configure image view
        let imageViewHeight: CGFloat = device == .phone ? 161 : 273.7
        imageView_MGRE.layer.cornerRadius = device == .phone ? 14 : 23.8
        
        // Configure buttons
        buttonStackView_MGRE.spacing = device == .phone ? 8 : 18
        let buttonHeight: CGFloat = device == .phone ? 38 : 64.6
        let buttonCornerRadius: CGFloat = device == .phone ? 14 : 23.8
        
        // Configure open button
        let openButtonTitleFontSize: CGFloat = device == .phone ? 20 : 34
        openButton_MGRE.titleLabel?.font = UIFont(name: StringConstants.ptSansRegular,
                                                  size: openButtonTitleFontSize)
        openButton_MGRE.layer.cornerRadius = buttonCornerRadius
        openButton_MGRE.setTitleColor(.black, for: .normal)
        
        favoriteButton_MGRE.layer.cornerRadius = buttonCornerRadius
        
        // Configure label stack view
        let labelStackViewSpacing: CGFloat = device == .phone ? 0 : 13.6
        labelStackView.spacing = labelStackViewSpacing
        
        // Configure title label
        let titleLabelFontSize: CGFloat = device == .phone ? 20 : 34
        titleLabel.font = UIFont(name: StringConstants.ptSansRegular, size: titleLabelFontSize)
        titleLabel.numberOfLines = 1
        titleLabel.textColor = .black
        titleLabel.setLineHeight(titleLabelFontSize)
        titleLabel.addHuggingProperties()

        
        // Configure description label
        let descriptionLabelFontSize: CGFloat = device == .phone ? 14 : 23.8
        let descriptionLabelLineHeight: CGFloat = device == .phone ? 14 : 30.82
        descriptionLabel.font = UIFont(name: StringConstants.ptSansRegular, size: descriptionLabelFontSize)
        descriptionLabel.textColor = .black
        descriptionLabel.setLineHeight(descriptionLabelLineHeight)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            // Vertical stack view constraints
            verticalStackView_MGRE.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            verticalStackView_MGRE.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            verticalStackView_MGRE.topAnchor.constraint(equalTo: contentView.topAnchor),
            verticalStackView_MGRE.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            

            // Image view height constraint
            imageView_MGRE.heightAnchor.constraint(equalToConstant: imageViewHeight),
                                    
            // Button constraints
            openButton_MGRE.heightAnchor.constraint(equalToConstant: buttonHeight),

            favoriteButton_MGRE.widthAnchor.constraint(equalTo: favoriteButton_MGRE.heightAnchor)
        ])
        
        updateFavoriteButton_MGRE()
    }

    private func updateFavoriteButton_MGRE() {
        var _mge6666: Int { 0 }
        var _mcd5552: Bool { true }
        let image = UIImage(named: isFavourite_MGRE ?
            Helper.deviceSpecificImage(image: StringConstants.Images.favFilledStar) :
            Helper.deviceSpecificImage(image: StringConstants.Images.favStar))
        
        favoriteButton_MGRE.setImage(image, for: .normal)
        favoriteButton_MGRE.backgroundColor = UIColor.buttonBg
    }
}
