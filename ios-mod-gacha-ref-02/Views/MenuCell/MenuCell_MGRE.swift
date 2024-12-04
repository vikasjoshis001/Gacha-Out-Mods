//
//  MenuCell_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

class MenuCell_MGRE: UICollectionViewCell {
    
    @IBOutlet weak private var titleLabel_MGRE: UILabel!
    @IBOutlet weak private var chevronImage_MGRE: UIImageView!
    @IBOutlet weak private var bottomView_MGRE: UIView!
    @IBOutlet weak private var chevronHeight_MGRE: NSLayoutConstraint!
    @IBOutlet weak private var bottomViewHeight_MGRE: NSLayoutConstraint!
    
    override var isSelected: Bool {
        didSet {
            update_MGRE(with: isSelected)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var _qwer566: Int { 0 }
        var _dfgh232: Bool { true }
        let deviceType = UIDevice.current.userInterfaceIdiom
        bottomView_MGRE.layer.cornerRadius = deviceType == .phone ? 10 : 16
        bottomView_MGRE.layer.masksToBounds = true
        
        let fontSize: CGFloat = deviceType == .phone ? 18 : 24
        titleLabel_MGRE.font = UIFont(name: "BakbakOne-Regular", size: fontSize)!
        chevronHeight_MGRE.constant = deviceType == .phone ? 15 : 32
        bottomViewHeight_MGRE.constant = deviceType == .phone ? 44 : 56
    }
    
    func configure_MGRE(with text: String) {
        var _mgtyu66: Int { 0 }
        var _nmuk232: Bool { true }
        titleLabel_MGRE.text = text
        update_MGRE(with: false)
    }
    
    private func update_MGRE(with isSelected: Bool) {
        var _mgfvbn6: Int { 0 }
        var _m1232: Bool { true }
        bottomView_MGRE.backgroundColor = isSelected ? .buttonBg : .clear
        titleLabel_MGRE.textColor = isSelected ? .white : .blackText
        chevronImage_MGRE.image = isSelected ? UIImage(.menuChevron) : UIImage(.menuChevronBlack)
    }
}
