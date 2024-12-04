//
//  UICollectionView+Extension_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

typealias UICollectionView_MGRE = UICollectionView

extension UICollectionView_MGRE {
    func registerAllNibs_MGRE() {
        registerNib_MGRE(for: ContentCell_MGRE.self)
        registerNib_MGRE(for: WallpaperCell_MGRE.self)
        registerNib_MGRE(for: ModsCell_MGRE.self)
    }
    
    func registerNib_MGRE(for cellClass: UICollectionViewCell.Type?) {
        guard let cellClass = cellClass else { return }
        register(cellClass.nib_MGRE, forCellWithReuseIdentifier: String(describing: cellClass))
    }
    
    func registerClass_MGRE(for cellClass: UICollectionViewCell.Type?) {
        guard let cellClass = cellClass else { return }
        register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass))
    }
    
    func dequeue_MGRE<T: UICollectionViewCell>(id: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.identifier_MGRE, for: indexPath) as? T else {
            return UICollectionViewCell() as! T
        }
        return cell
    }
}
