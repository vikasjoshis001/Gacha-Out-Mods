//
//  UITableViewCell+Extension_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

public protocol ReusableCell_MGRE {
    static var identifier_MGRE: String { get }
    static var nib_MGRE: UINib { get }
}

typealias UITableViewCell_MGRE = UITableViewCell

extension UITableViewCell_MGRE: ReusableCell_MGRE {
    public static var identifier_MGRE: String {
        return String(describing: self)
    }
    
    public static var nib_MGRE: UINib {
        return UINib(nibName: identifier_MGRE, bundle: Bundle.main)
    }
}
