//
//  UILabel+Extension_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

typealias UILabel_MGRE = UILabel
typealias UITextField_MGRE = UITextField

extension UILabel_MGRE {
    static func widthForLabel_MGRE(text: String, font: UIFont) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: 0))
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.width
    }
    
    func setLineHeight(_ lineHeight: CGFloat) {
        guard let text = text else { return }
            
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight - font.lineHeight
            
        let attributedString = NSAttributedString(
            string: text,
            attributes: [
                .paragraphStyle: paragraphStyle,
                .font: font ?? UIFont.systemFont(ofSize: 17)
            ]
        )
            
        attributedText = attributedString
    }
    
    func setLetterSpacing(_ spacing: CGFloat) {
        guard let text = text else { return }
            
        let attributedString = NSAttributedString(
            string: text,
            attributes: [
                .kern: spacing,
                .font: font ?? UIFont.systemFont(ofSize: 17)
            ]
        )
            
        attributedText = attributedString
    }
}

extension UITextField_MGRE {
    static func widthForLabel_MGRE(text: String, font: UIFont) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: 0))
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.width
    }
    
    func setLineHeight(_ lineHeight: CGFloat) {
            let text = self.text ?? ""
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.minimumLineHeight = lineHeight
            paragraphStyle.maximumLineHeight = lineHeight

            let attributedString = NSAttributedString(
                string: text,
                attributes: [
                    .paragraphStyle: paragraphStyle,
                    .baselineOffset: (lineHeight - (font?.lineHeight ?? 0)) / 4
                ]
            )

            self.attributedText = attributedString
        }
    
    func setLetterSpacing(_ spacing: CGFloat) {
        guard let text = text else { return }
            
        let attributedString = NSAttributedString(
            string: text,
            attributes: [
                .kern: spacing,
                .font: font ?? UIFont.systemFont(ofSize: 17)
            ]
        )
            
        attributedText = attributedString
    }
}

