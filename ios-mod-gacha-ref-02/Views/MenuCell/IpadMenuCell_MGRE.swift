//
//  IpadMenuCell_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

class IpadMenuCell_MGRE: UICollectionViewCell {
    
    @IBOutlet weak var bottomView_MGRE: UIView!
    @IBOutlet weak var titleLabel_MGRE: UILabel!
    
    override var isSelected: Bool {
        didSet {
            update_MGRE(with: isSelected)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bottomView_MGRE.layer.cornerRadius = 18.19
        bottomView_MGRE.layer.masksToBounds = true
                
        let fontSize: CGFloat = 27.2
        let lineHeight: CGFloat = 34
        titleLabel_MGRE.font = UIFont(name: StringConstants_MGRE.ptSansRegular, size: fontSize)!
        titleLabel_MGRE.setLineHeight_MGRE(lineHeight)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let horizontalPadding: CGFloat = 10
        bottomView_MGRE.frame = contentView.bounds.insetBy(dx: horizontalPadding, dy: 0)
        contentView.frame = bounds
        contentView.clipsToBounds = true
    }
    
    func configure_MGRE(with text: String) {
        titleLabel_MGRE.text = text
        update_MGRE(with: false)
    }
    
    private func update_MGRE(with isSelected: Bool) {
        bottomView_MGRE.backgroundColor = isSelected ? .buttonBg : .clear
        titleLabel_MGRE.textColor = .blackText
    }
}
