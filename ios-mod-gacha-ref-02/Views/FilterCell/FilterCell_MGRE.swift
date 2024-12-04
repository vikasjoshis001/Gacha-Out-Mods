//
//  FilterCell_MGRE.swift
//  ios-mod-gacha
//
//  Created by Systems
//

import UIKit

class FilterCell_MGRE: UICollectionViewCell {

    @IBOutlet weak var titleLabel_MGRE: UILabel!
    @IBOutlet weak private var cellBottomView_MGRE: UIView!
    @IBOutlet private weak var rightIndentConstraint_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var leftIndentConstraint_MGRE: NSLayoutConstraint!
    
    override var isSelected: Bool {
        didSet {
            update_MGRE(with: isSelected)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let deviceType = UIDevice.current.userInterfaceIdiom
        cellBottomView_MGRE.layer.cornerRadius = deviceType == .phone ? 12 : 24
        cellBottomView_MGRE.layer.masksToBounds = true
        
        rightIndentConstraint_MGRE.constant = deviceType == .phone ? 12 : 28
        leftIndentConstraint_MGRE.constant = deviceType == .phone ? 12 : 28
        
        let fontSize: CGFloat = deviceType == .phone ? 18 : 28
        titleLabel_MGRE.font = UIFont(name: "BakbakOne-Regular", size: fontSize)!
        titleLabel_MGRE.textColor = .blackText
    }
    
    func configure_MGRE(with text: String) {
        var _Mwwbbd2: Int { 3 }
        var _bxxxa: Bool { false }
        titleLabel_MGRE.text = text
        update_MGRE(with: false)
    }
    
    func update_MGRE(with isSelected: Bool) {
        var _MGdg: Int { 0 }
        var _MGx345a: Bool { false }
        cellBottomView_MGRE.backgroundColor = isSelected ? .buttonBg : .white
        titleLabel_MGRE.textColor = isSelected ? .white : .blackText
    }
}
