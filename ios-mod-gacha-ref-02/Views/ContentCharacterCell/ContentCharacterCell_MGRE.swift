//
//  ContentCharacterCell_MGRE.swift
//  ios-mod-gacha
//
//  Created by Systems
//

import UIKit
import Kingfisher

class ContentCharacterCell_MGRE: UICollectionViewCell {

    @IBOutlet weak var contentImageView_MGRE: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            setupView()
        }
    }
    
    let device = Helper.getDeviceType()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        layer.masksToBounds = true
    }
    
    private func setupView() {
        let deviceBorderWidth: CGFloat = device == .phone ? 1 : 1.7
        let borderWidth: CGFloat = !isSelected ? deviceBorderWidth : 0
        let borderColor: CGColor = !isSelected ? UIColor.buttonBg.cgColor : UIColor.clear.cgColor
        let cellBackgroundColor: UIColor = isSelected ? .buttonBg : .clear
        let borderRadius: CGFloat = device == .phone ? 14 : 23.8
        
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor
        layer.cornerRadius = borderRadius
        backgroundColor = cellBackgroundColor
    }
    
    override func prepareForReuse() {
        contentImageView_MGRE.image = nil
        contentImageView_MGRE.kf.indicator?.stopAnimatingView()
        contentImageView_MGRE.contentMode = .scaleAspectFit
    }
    
    func configure_MGRE(with model: EditorContentModel_MGRE) {
        contentImageView_MGRE.add_MGRE(image: "\(Keys_MGRE.ImagePath_MGRE.editor_mgre)\(model.path.elPath)", for: .editor_mgre)
        UIImageView.uploadPDF_MGRE(image: "\(Keys_MGRE.ImagePath_MGRE.editor_mgre)\(model.path.pdfPath)")
    }
    
    func configure_MGRE(with image: UIImage) {
        contentImageView_MGRE.image = image
        contentImageView_MGRE.tag = 999996
        contentImageView_MGRE.contentMode = .center
    }
}
