//
//  DropDownCell_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

class DropDownCell_MGRE: UITableViewCell {
    
    @IBOutlet public weak var titleLabel_MGRE: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setup_MGRE()
    }
    
    private func setup_MGRE() {
        selectionStyle = .none
        let deviceType = UIDevice.current.userInterfaceIdiom
        let fontSize: CGFloat = deviceType == .phone ? 20 : 34
        titleLabel_MGRE.font = UIFont(name: StringConstants_MGRE.ptSansRegular, size: fontSize)!
        titleLabel_MGRE.setLineHeight_MGRE(fontSize)
    }
    
    public func buildCell_MGRE(with category: String, titleColor: UIColor = .white) {
        titleLabel_MGRE.text = category.capitalized
        titleLabel_MGRE.textColor = .black
    }
}
