//
//  NavigationView_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

class NavigationView_MGRE: UIView {
    
    @IBOutlet private weak var titleLabel_MGRE: UILabel!
    @IBOutlet private weak var titleView_MGRE: UIView!
    @IBOutlet private weak var leftButton_MGRE: UIButton!
    @IBOutlet private weak var rightButton_MGRE: UIButton!
    @IBOutlet private weak var undoButton_MGRE: UIButton!
    @IBOutlet private weak var undoButtonWidth_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var undoButtonBottomView_MGRE: UIView!
    @IBOutlet private weak var rightIndentConstraint_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var leftIndentConstraint_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var leftButtonHeight_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var rightButtonHeight_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var titleHeight_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var viewHeight_MGRE: NSLayoutConstraint!
    
    var leftButtonAction_MGRE: (()->())?
    var rightButtonAction_MGRE: (()->())?
    var undoAction_MGRE: (()->())?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib_MGRE()
        configureLayout_MGRE()
    }
    
    init() {
        super.init(frame: .zero)
        loadViewFromNib_MGRE()
        configureLayout_MGRE()
    }
    
    private func configureLayout_MGRE() {
        let deviceType = UIDevice.current.userInterfaceIdiom
                
        rightIndentConstraint_MGRE.constant = deviceType == .phone ? 41 : 85
        leftIndentConstraint_MGRE.constant = deviceType == .phone ? 41 : 85
        viewHeight_MGRE.constant = deviceType == .phone ? 47 : 97
        
        titleHeight_MGRE.constant = deviceType == .phone ? 47 : 52
        leftButtonHeight_MGRE.constant = deviceType == .phone ? 47 : 52
        rightButtonHeight_MGRE.constant = deviceType == .phone ? 47 : 52
        
        let titleFontSize: CGFloat = deviceType == .phone ? 30 : 40
        let lineHeight: CGFloat = deviceType == .phone ? 38.85 : 40
        titleLabel_MGRE.font = UIFont(name: StringConstants.ptSansRegular, size: titleFontSize) ?? UIFont.systemFont(ofSize: titleFontSize)
        titleLabel_MGRE.setLineHeight(lineHeight)
        undoButtonBottomView_MGRE.layer.cornerRadius = deviceType == .phone ? 21 : 26
        
        let fontSize: CGFloat = deviceType == .phone ? 18 : 24
        let font = UIFont(name: "BakbakOne-Regular", size: fontSize)!
        undoButton_MGRE.titleLabel?.font = font
        let width = UILabel.widthForLabel(text: "Reset changes", font: font)
        undoButtonWidth_MGRE.constant = width

        undoButtonBottomView_MGRE.addShadow_MGRE(with: UIColor(red: 1, green: 0.702, blue: 0.433, alpha: 1))
        
        titleView_MGRE.customizeView_MGRE(with: deviceType == .phone ? 0 : 0)
    }
    
    func build_MGRE(with title: String,
                    leftIcon: UIImage? = UIImage(named: StringConstants.Images.menu),
                    rightIcon: UIImage? = UIImage(named: StringConstants.Images.search),
                    isEditor: Bool = false) {
        titleLabel_MGRE.text = title
        titleLabel_MGRE.textColor = .blackText
        
        undoButton_MGRE.isHidden = isEditor ? false : true
        undoButtonBottomView_MGRE.isHidden = isEditor ? false : true
        titleView_MGRE.isHidden = isEditor ? true : false
        
        if title.isEmpty {
            titleView_MGRE.isHidden = true
        }
        
        titleView_MGRE.backgroundColor = .clear
        leftButton_MGRE.backgroundColor = .clear
        rightButton_MGRE.backgroundColor = .clear
        
        if let leftIcon = leftIcon {
            leftButton_MGRE.isHidden = false
            leftButton_MGRE.setImage(leftIcon, for: .normal)
        } else {
            leftButton_MGRE.isHidden = true
        }
        
        if let rightIcon = rightIcon {
            rightButton_MGRE.isHidden = false
            rightButton_MGRE.setImage(rightIcon, for: .normal)
        } else {
            rightButton_MGRE.isHidden = true
        }
    }
    
    @IBAction private func leftButtonTapped_MGRE(_ sender: UIButton) {
        leftButtonAction_MGRE?()
    }
    
    @IBAction private func rightButtonTapped_MGRE(_ sender: UIButton) {
        rightButtonAction_MGRE?()
    }
    
    @IBAction private func undoButtonTapped_MGRE(_ sender: UIButton) {
        undoAction_MGRE?()
    }
}

typealias UILabel_MGN = UILabel

extension UILabel_MGN {
    static func widthForLabel(text: String, font: UIFont) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: 0))
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.width
    }
}
