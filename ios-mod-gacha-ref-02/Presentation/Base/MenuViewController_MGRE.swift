//
//  MenuViewController_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

class MenuViewController_MGRE: UIViewController {

    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var rightIndentConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leftIndentConstraint: NSLayoutConstraint!
    
    var menuAction_MGRE: ((MenuItem_MGRE) -> Void)?
    var selectedMenu_MGRE: MenuItem_MGRE = .mods_MGRE
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureLayout_MGRE()
        configureCollectionView_MGRE()
    }

    private func configureLayout_MGRE() {
        let deviceType = UIDevice.current.userInterfaceIdiom
        rightIndentConstraint.constant = deviceType == .phone ? 20 : 85
        leftIndentConstraint.constant = deviceType == .phone ? 20 : 85
        
        let fontSize: CGFloat = deviceType == .phone ? 22 : 32
        titleLabel.font = UIFont(name: "BakbakOne-Regular", size: fontSize)!
    }

    func configureCollectionView_MGRE() {
        collectionView.allowsMultipleSelection = false
        collectionView.registerNib_MGRE(for: MenuCell_MGRE.self)
        let deviceType = UIDevice.current.userInterfaceIdiom
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumLineSpacing = deviceType == .phone ? 24 : 32
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
        cell.configure_MGRE(with: text.rawValue)
        if selectedMenu_MGRE == text {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
        }
        return cell
    }
}

extension MenuViewController_MGRE: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        menuAction_MGRE?(MenuItem_MGRE.allCases[indexPath.item])
    }
}

extension MenuViewController_MGRE: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let deviceType = UIDevice.current.userInterfaceIdiom
        let height: CGFloat = deviceType == .phone ? 44 : 56
        return CGSize(width: collectionView.frame.width, height: height)
    }
}
