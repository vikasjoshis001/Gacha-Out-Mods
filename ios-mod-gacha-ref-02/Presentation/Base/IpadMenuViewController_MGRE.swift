//
//  IpadMenuViewController_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Vikas Joshi on 06/12/24.
//

import UIKit

// MARK: - IpadMenuViewController_MGRE

class IpadMenuViewController_MGRE: UIViewController {
    // MARK: - Properties
    @IBOutlet var collectionView: UICollectionView!
    
    private let deviceType = Helper.getDeviceType_MGRE()
    var menuAction_MGRE: ((MenuItem_MGRE) -> Void)?
    var selectedMenu_MGRE: MenuItem_MGRE = .mods_MGRE
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.menubarBackground
        configureCollectionView_MGRE()
    }

    // MARK: - Helpers
    private func configureCollectionView_MGRE() {
        collectionView.allowsMultipleSelection = false
        collectionView.registerNib_MGRE(for: IpadMenuCell_MGRE.self)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets.zero
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumLineSpacing = 10
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)        }
    }

    func getContentHeight() -> CGFloat {
        return collectionView.collectionViewLayout.collectionViewContentSize.height + 50
    }
}

// MARK: UICollectionViewDataSource

extension IpadMenuViewController_MGRE: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MenuItem_MGRE.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let text = MenuItem_MGRE.allCases[indexPath.item]
        let cell = collectionView.dequeue_MGRE(id: IpadMenuCell_MGRE.self, for: indexPath)
        cell.configure_MGRE(with: text.localizedTitle)
        if selectedMenu_MGRE == text {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
        }
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension IpadMenuViewController_MGRE: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        menuAction_MGRE?(MenuItem_MGRE.allCases[indexPath.item])
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension IpadMenuViewController_MGRE: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let height: CGFloat = 70
        return CGSize(width: collectionView.frame.width, height: height)
    }
}
