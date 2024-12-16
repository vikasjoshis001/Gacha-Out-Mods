//
//  FilterView_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

class FilterView_MGRE: UIView {
    
    @IBOutlet private weak var collectionView_MGRE: UICollectionView!
    @IBOutlet private weak var rightIndentConstraint_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var leftIndentConstraint_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var collectionViewHeight_MGRE: NSLayoutConstraint!
    
    var filters_MGRE: [Filter_MGRE] = []
    
    var activeFilter_MGRE: Filter_MGRE = .new_mgre
    var filtersAction_MGRE: ((Filter_MGRE) -> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib_MGRE()
        configureLayout_MGRE()
        configureCollectionView_MGRE()
    }
    
    init() {
        super.init(frame: .zero)
        loadViewFromNib_MGRE()
        configureLayout_MGRE()
        configureCollectionView_MGRE()
    }
    
    private func configureLayout_MGRE() {
        let deviceType = UIDevice.current.userInterfaceIdiom
        rightIndentConstraint_MGRE.constant = deviceType == .phone ? 27 : 157
        leftIndentConstraint_MGRE.constant = deviceType == .phone ? 24 : 157
        collectionViewHeight_MGRE.constant = deviceType == .phone ? 38 : 64.6
    }
    
    func configureCollectionView_MGRE() {
        collectionView_MGRE.allowsMultipleSelection = false
        collectionView_MGRE.registerNib_MGRE(for: FilterCell_MGRE.self)
    }
}

extension FilterView_MGRE: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters_MGRE.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue_MGRE(id: FilterCell_MGRE.self, for: indexPath)
        let filter = filters_MGRE[indexPath.item]
        let filterText = filter.localizedTitle
        if activeFilter_MGRE == filter,
           !(collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false) {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
        }
        cell.configure_MGRE(with: filterText)
        cell.update_MGRE(with: activeFilter_MGRE == filter)
        return cell
    }
}

extension FilterView_MGRE: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let filter = filters_MGRE[indexPath.item].rawValue
        let deviceType = UIDevice.current.userInterfaceIdiom
        let fontSize: CGFloat = deviceType == .phone ? 16 : 27.2
        let font = UIFont(name: StringConstants.ptSansRegular, size: fontSize)!
        let width = UILabel.widthForLabel_MGRE(text: filter, font: font)
        let height: CGFloat = deviceType == .phone ? 38 : 64.6
        let indent: CGFloat = deviceType == .phone ? 0 : 0
        return CGSize(width: width + indent, height: height)
    }
}

extension FilterView_MGRE: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filter = filters_MGRE[indexPath.item]
        activeFilter_MGRE = filter
        filtersAction_MGRE?(activeFilter_MGRE)
    }
}
