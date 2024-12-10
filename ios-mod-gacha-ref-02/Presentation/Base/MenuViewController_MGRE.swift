//
//  MenuViewController_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

class MenuViewController_MGRE: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    var menuAction_MGRE: ((MenuItem_MGRE) -> Void)?
    var selectedMenu_MGRE: MenuItem_MGRE = .mods_MGRE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.menubarBackground
        configureCollectionView_MGRE()
    }

    func configureCollectionView_MGRE() {
        collectionView.allowsMultipleSelection = false
        collectionView.registerNib_MGRE(for: MenuCell_MGRE.self)
        collectionView.backgroundColor = .clear
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumLineSpacing = 25
        }
    }
}

extension MenuViewController_MGRE: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MenuItem_MGRE.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let text = MenuItem_MGRE.allCases[indexPath.item]
        let cell = collectionView.dequeue_MGRE(id: MenuCell_MGRE.self, for: indexPath)
        cell.configure_MGRE(with: text.localizedTitle)
        if selectedMenu_MGRE == text {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
        }
        return cell
    }
}

extension MenuViewController_MGRE: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint("Debug: ", MenuItem_MGRE.allCases[indexPath.item])
        menuAction_MGRE?(MenuItem_MGRE.allCases[indexPath.item])
    }
}

extension MenuViewController_MGRE: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 38
        return CGSize(width: collectionView.frame.width, height: height)
    }
}
