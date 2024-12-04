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
        rightIndentConstraint_MGRE.constant = deviceType == .phone ? 20 : 85
        leftIndentConstraint_MGRE.constant = deviceType == .phone ? 20 : 85
        viewHeight_MGRE.constant = deviceType == .phone ? 58 : 97
        
        titleHeight_MGRE.constant = deviceType == .phone ? 42 : 52
        leftButtonHeight_MGRE.constant = deviceType == .phone ? 42 : 52
        rightButtonHeight_MGRE.constant = deviceType == .phone ? 42 : 52
        
        let titleFontSize: CGFloat = deviceType == .phone ? 22 : 40
        titleLabel_MGRE.font = UIFont(name: "BakbakOne-Regular", size: titleFontSize) ?? UIFont.systemFont(ofSize: titleFontSize)
        leftButton_MGRE.layer.cornerRadius = deviceType == .phone ? 21 : 26
        rightButton_MGRE.layer.cornerRadius = deviceType == .phone ? 21 : 26
        undoButtonBottomView_MGRE.layer.cornerRadius = deviceType == .phone ? 21 : 26
        
        let fontSize: CGFloat = deviceType == .phone ? 18 : 24
        let font = UIFont(name: "BakbakOne-Regular", size: fontSize)!
        undoButton_MGRE.titleLabel?.font = font
        let width = UILabel.widthForLabel(text: "Reset changes", font: font)
        undoButtonWidth_MGRE.constant = width
        
        leftButton_MGRE.addShadow_MGRE(with: UIColor(red: 0.887, green: 0.887, blue: 0.887, alpha: 1))
        rightButton_MGRE.addShadow_MGRE(with: UIColor(red: 0.887, green: 0.887, blue: 0.887, alpha: 1))
        undoButtonBottomView_MGRE.addShadow_MGRE(with: UIColor(red: 1, green: 0.702, blue: 0.433, alpha: 1))
        
        titleView_MGRE.customizeView_MGRE(with: deviceType == .phone ? 21 : 26)
        titleView_MGRE.addShadow_MGRE(with: UIColor(red: 0.887, green: 0.887, blue: 0.887, alpha: 1))
    }
    
    func build_MGRE(with title: String,
                    leftIcon: UIImage? = UIImage(.menuIcon),
                    rightIcon: UIImage? = UIImage(.searchIcon), 
                    isEditor: Bool = false) {
        titleLabel_MGRE.text = title
        titleLabel_MGRE.textColor = .blackText
        
        undoButton_MGRE.isHidden = isEditor ? false : true
        undoButtonBottomView_MGRE.isHidden = isEditor ? false : true
        titleView_MGRE.isHidden = isEditor ? true : false
        
        if title.isEmpty {
            titleView_MGRE.isHidden = true
        }
        
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
