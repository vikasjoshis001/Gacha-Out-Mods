//
//  MenuCell_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

class MenuCell_MGRE: UICollectionViewCell {
    
    @IBOutlet weak private var titleLabel_MGRE: UILabel!
    @IBOutlet weak private var bottomView_MGRE: UIView!
    @IBOutlet weak private var bottomViewHeight_MGRE: NSLayoutConstraint!
    
    private let deviceType = Helper.getDeviceType_MGRE()
    override var isSelected: Bool {
        didSet {
            update_MGRE(with: isSelected)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bottomView_MGRE.layer.cornerRadius = deviceType == .phone ? 14 : 18.19
        bottomView_MGRE.layer.masksToBounds = true
        
        let fontSize: CGFloat = deviceType == .phone ? 16 : 27.2
        let lineHeight: CGFloat = deviceType == .phone ? 20 : 34
        titleLabel_MGRE.font = UIFont(name: StringConstants_MGRE.ptSansRegular, size: fontSize)!
        titleLabel_MGRE.setLineHeight_MGRE(lineHeight)
        bottomViewHeight_MGRE.constant = deviceType == .phone ? 44 : 74.8
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
