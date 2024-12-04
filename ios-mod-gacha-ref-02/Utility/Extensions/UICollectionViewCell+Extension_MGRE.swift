//
//  UICollectionViewCell+Extension_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

typealias UICollectionViewCell_MGRE = UICollectionViewCell

extension UICollectionViewCell_MGRE {
    static var identifier_MGRE: String {
        return String(describing: self)
    }
    
    static var nib_MGRE: UINib {
        return UINib(nibName: identifier_MGRE, bundle: Bundle.main)
    }
}

extension UICollectionViewCell_MGRE {
    var collectionView_MGRE: UICollectionView? {
        return self.next_MGRE(of: UICollectionView.self)
    }
    
    var indexPath_MGRE: IndexPath? {
        return self.collectionView_MGRE?.indexPath(for: self)
    }
}
