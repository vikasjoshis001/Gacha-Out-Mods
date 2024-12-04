//
//  UIView+Extension_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

typealias UIView_MGRE = UIView

extension UIView_MGRE {
    func loadViewFromNib_MGRE() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        addSubview(view)
        view.scaleEqualSuperView_MGRE()
    }
    
    func scaleEqualSuperView_MGRE() {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([leadingAnchor.constraint(equalTo: superView.leadingAnchor),
                                     trailingAnchor.constraint(equalTo: superView.trailingAnchor),
                                     topAnchor.constraint(equalTo: superView.topAnchor),
                                     bottomAnchor.constraint(equalTo: superView.bottomAnchor)])
    }
    
    func customizeView_MGRE(with cornerRadius: CGFloat = 12,
                            borderWidth: CGFloat = 0,
                            borderColor: CGColor? = UIColor.white.cgColor) {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor
        clipsToBounds = true
    }
}

extension UIView_MGRE {
    func addShadow_MGRE(with shadowColor: UIColor,
                        shadowOpacity: Float = 1,
                        shadowRadius: CGFloat = 0,
                        shadowVerticalOffset: CGFloat = 3) {
        
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = CGSize(width: 0, height: shadowVerticalOffset)
        self.clipsToBounds = false
    }
}
