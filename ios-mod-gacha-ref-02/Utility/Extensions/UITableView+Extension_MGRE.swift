//
//  UITableView+Extension_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

typealias UITableView_MGRE = UITableView

extension UITableView_MGRE {
    func registerNib_MGRE(for cellClass: UITableViewCell.Type) {
        register(cellClass.nib_MGRE, forCellReuseIdentifier: cellClass.identifier_MGRE)
    }
    
    func registerClass_MGRE(for cellClass: UITableViewCell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.identifier_MGRE)
    }
}
