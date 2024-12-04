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
            layer.borderWidth = isSelected ? 2 : 0
            layer.borderColor = isSelected ? UIColor.buttonBg.cgColor : UIColor.clear.cgColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 20
        layer.borderWidth = 0
        layer.borderColor = UIColor.clear.cgColor
        layer.masksToBounds = true
        backgroundColor = UIColor(red: 0.962, green: 0.962, blue: 0.962, alpha: 1)
    }
    
    override func prepareForReuse() {
        contentImageView_MGRE.image = nil
        contentImageView_MGRE.kf.indicator?.stopAnimatingView()
        contentImageView_MGRE.contentMode = .scaleAspectFit
    }
    
    func configure_MGRE(with model: EditorContentModel_MGRE) {
        contentImageView_MGRE.add_MGRE(image: model.path.elPath, for: .editor_mgre)
        UIImageView.uploadPDF_MGRE(image: model.path.pdfPath)
    }
    
    func configure_MGRE(with image: UIImage) {
        contentImageView_MGRE.image = image
        contentImageView_MGRE.tag = 999996
        contentImageView_MGRE.contentMode = .center
    }
}
