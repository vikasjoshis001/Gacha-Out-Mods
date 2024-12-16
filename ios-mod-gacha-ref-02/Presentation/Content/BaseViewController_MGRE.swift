//
//  BaseViewController_MS.swift
//  ios-mod-gacha
//
//  Created by Systems
//

import UIKit
import SwiftUI

// MARK: - Filter_MGRE

enum Filter_MGRE: String {
    case all_mgre, new_mgre, favourites_mgre, top_mgre
    case mods_mgre, outfitIdea_mgre, characters_mgre, collections_mgre, wallpapers_mgre
}

extension Filter_MGRE {
    var localizedTitle: String {
        switch self {
        case .wallpapers_mgre:
            return LocalizationKeys.wallpapers_MGRE
        case .mods_mgre:
            return LocalizationKeys.mods_MGRE
        case .characters_mgre:
            return LocalizationKeys.characters_MGRE
        case .collections_mgre:
            return LocalizationKeys.collections_MGRE
        case .outfitIdea_mgre:
            return LocalizationKeys.outfitIdeas_MGRE
        case .all_mgre:
            return LocalizationKeys.all_MGRE
        case .new_mgre:
            return LocalizationKeys.new_MGRE
        case .favourites_mgre:
            return LocalizationKeys.favorites_MGRE
        case .top_mgre:
            return LocalizationKeys.top_MGRE
        }
    }
}

// MARK: - BaseViewController_MGRE

class BaseViewController_MGRE: UIViewController, UICollectionViewDelegate {
    enum UnifiedModel_MGRE: Hashable {
        case mods_mgre(Mods_MGRE)
        case wallpaper_mgre(Wallpaper_MGRE)
        case characters_mgre(Character_MGRE)
        case outfitIdea_mgre(OutfitIdea_MGRE)
        case collections_mgre(Collections_MGRE)
    }
    
    typealias DataSource_MGRE = UICollectionViewDiffableDataSource<Int, UnifiedModel_MGRE>
    typealias Snapshot_MGRE = NSDiffableDataSourceSnapshot<Int, UnifiedModel_MGRE>
    
    @IBOutlet private weak var collectionView_MGRE: UICollectionView!
    @IBOutlet private weak var emptyLabel_MGRE: UILabel!
    @IBOutlet private weak var navigationView_MGRE: NavigationView_MGRE!
    @IBOutlet private weak var searchBar_MGRE: SearchBar_MGRE!
    @IBOutlet private weak var filterView_MGRE: FilterView_MGRE!
    @IBOutlet weak var rightIdentationCollectionView: NSLayoutConstraint!
    @IBOutlet weak var leftIdentationCollectionView: NSLayoutConstraint!
    
    private var dropbox_MGRE: DBManager_MGRE { .shared }
    private var dataSource_MGRE: DataSource_MGRE?
    
    var isFavoriteMode_MGRE = false
    var modelType_MGRE: ContentType_MGRE = .mods_mgre
    var navTitle_MGRE = ""
    var allData_MGRE: [any ModelProtocol_MGRE] = []
    var data_MGRE: [any ModelProtocol_MGRE] = []
    var favorites_MGRE: [String] = []
    
    var filters_MGRE: [Filter_MGRE] {
        if isFavoriteMode_MGRE {
            return [.mods_mgre, .outfitIdea_mgre, .characters_mgre, .collections_mgre, .wallpapers_mgre]
        } else {
            return [.all_mgre, .new_mgre, .favourites_mgre, .top_mgre]
        }
    }

    var activeFilter_MGRE: Filter_MGRE = .all_mgre
    var searchText_MGRE: String?
    var isPushed_MGRE = false
    
    var toggleMenuAction_MGRE: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var _MGNasasgg2: Int { 0 }
        var _MGfhgha: Bool { false }
        view.backgroundColor = .appBackground
        configureSubviews_MGRE()
        configureDataSource_MGRE()
        loadFavorites_MGRE()
        loadContent_MGRE()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        isPushed_MGRE = false
        loadFavorites_MGRE()
        updateFavouritesFilters_MGRE()
        collectionView_MGRE.reloadData()
    }
    
    func configureSubviews_MGRE() {
        let deviceType = UIDevice.current.userInterfaceIdiom
        let fontSize: CGFloat = deviceType == .phone ? 20 : 32
        emptyLabel_MGRE.font = UIFont(name: "BakbakOne-Regular", size: fontSize)!

        configureNavigationView_MGRE()
        configureCollectionView_MGRE()
        configureSearchView_MGRE()
        configureFilterView_MGRE()
    }
    
    func configureNavigationView_MGRE() {
        if modelType_MGRE == .wallpapers_mgre ||
            modelType_MGRE == .collections_mgre ||
            modelType_MGRE == .characters_mgre
        {
            navigationView_MGRE.build_MGRE(with: navTitle_MGRE, rightIcon: nil)
        } else {
            navigationView_MGRE.build_MGRE(with: navTitle_MGRE)
        }
        navigationView_MGRE.leftButtonAction_MGRE = { [weak self] in
            self?.toggleMenuAction_MGRE?()
        }
        navigationView_MGRE.rightButtonAction_MGRE = { [weak self] in
            self?.searchBar_MGRE.isHidden = false
            self?.navigationView_MGRE.isHidden = true
            self?.searchBar_MGRE.searchTextField_MGRE.becomeFirstResponder()
        }
    }
    
    func configureFilterView_MGRE() {
        filterView_MGRE.filters_MGRE = filters_MGRE
        if isFavoriteMode_MGRE {
            filterView_MGRE.activeFilter_MGRE = .mods_mgre
            activeFilter_MGRE = .mods_mgre
        }
        filterView_MGRE.filtersAction_MGRE = { [weak self] filter in
            guard let self = self else { return }
            if self.isFavoriteMode_MGRE {
                switch filter {
                case .mods_mgre: self.modelType_MGRE = .mods_mgre
                case .outfitIdea_mgre: self.modelType_MGRE = .outfitIdeas_mgre
                case .characters_mgre: self.modelType_MGRE = .characters_mgre
                case .collections_mgre: self.modelType_MGRE = .collections_mgre
                case .wallpapers_mgre: self.modelType_MGRE = .wallpapers_mgre
                default: break
                }
                self.configureNavigationView_MGRE()
                self.configureCollectionView_MGRE()
                self.activeFilter_MGRE = filter
                self.loadFavorites_MGRE()
                self.loadContent_MGRE()
            } else {
                self.activeFilter_MGRE = filter
                self.applyFilters_MGRE()
                self.applySnapshot_MGRE(for: modelType_MGRE)
            }
        }
    }
    
    func configureSearchView_MGRE() {
        hideKeyboardWhenTappedAround_MGRE()
        searchBar_MGRE.isHidden = true
        searchBar_MGRE.textDidChange_MGRE = { [weak self] text in
            guard let self else { return }
            self.searchText_MGRE = text
            var results: [String] = []
            if let text = text, !text.isEmpty {
                results = data_MGRE
                    .filter { $0.searchText?.localizedCaseInsensitiveContains(text) ?? false }
                    .prefix(5)
                    .map { $0.searchText ?? "" }
            }
            self.searchBar_MGRE.updateResultView_MGRE(with: results)
            self.applyFilters_MGRE()
            self.applySnapshot_MGRE(for: modelType_MGRE)
        }
        searchBar_MGRE.dismiss_MGRE = { [weak self] in
            guard let self else { return }
            self.searchBar_MGRE.isHidden = true
            self.navigationView_MGRE.isHidden = false
            self.searchText_MGRE = nil
            self.applyFilters_MGRE()
            self.applySnapshot_MGRE(for: self.modelType_MGRE)
        }
    }
    
    func configureCollectionView_MGRE() {
        let deviceType = UIDevice.current.userInterfaceIdiom

        var rightConstraint: CGFloat = deviceType == .phone ? 0 : 90
        var leftConstraint: CGFloat = deviceType == .phone ? 0 : 90
    
        if modelType_MGRE == .mods_mgre || modelType_MGRE == .outfitIdeas_mgre {
            rightConstraint += 20
            leftConstraint += 20
        } else {
            rightConstraint += 0
            leftConstraint += 0
        }
        
        rightIdentationCollectionView.constant = rightConstraint
        leftIdentationCollectionView.constant = leftConstraint
        
        collectionView_MGRE.showsVerticalScrollIndicator = false
        collectionView_MGRE.showsHorizontalScrollIndicator = false
        collectionView_MGRE.keyboardDismissMode = .interactive
        collectionView_MGRE.collectionViewLayout = UICollectionViewCompositionalLayout(section: generateSectionLayout_MGRE())
        collectionView_MGRE.registerAllNibs_MGRE()
        collectionView_MGRE.registerWithoutXib_MGRE()
        collectionView_MGRE.delegate = self
    }
    
    func generateSectionLayout_MGRE() -> NSCollectionLayoutSection {
        NSCollectionLayoutSection.generateLayout_MGRE(for: modelType_MGRE)
    }
    
    func configureDataSource_MGRE() {
        dataSource_MGRE = DataSource_MGRE(collectionView: collectionView_MGRE) { [weak self] collectionView, indexPath, unifiedModel in
            guard let self, let cellClass = modelType_MGRE.cellClass_MGRE else { return UICollectionViewCell() }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellClass.identifier_MGRE, for: indexPath)
            
            let model: any ModelProtocol_MGRE
            switch unifiedModel {
            case .mods_mgre(let value): model = value
            case .wallpaper_mgre(let value): model = value
            case .characters_mgre(let value): model = value
            case .outfitIdea_mgre(let value): model = value
            case .collections_mgre(let value): model = value
            }
            
            let isFavorites = favorites_MGRE.contains(model.favId)
            model.configureCell_MGRE(cell, isFavorites: isFavorites) { [weak self] in
                self?.updateFavorites_MGRE(with: model.favId)
            } action: { [weak self] in
                self?.pushTo_MGRE(contentType: self?.modelType_MGRE ?? .mods_mgre, index: indexPath.item)
            }
            return cell
        }
    }
    
    func updateFavorites_MGRE(with favId: String) {
        if let index = favorites_MGRE.firstIndex(of: favId) {
            favorites_MGRE.remove(at: index)
            dropbox_MGRE.contentManager.deleteFavorites_MGRE(with: favId, contentType: modelType_MGRE)
        } else {
            favorites_MGRE.append(favId)
            dropbox_MGRE.contentManager.storeFavorites_MGRE(with: favId, contentType: modelType_MGRE)
        }
        updateFavouritesFilters_MGRE()
    }
    
    func updateFavouritesFilters_MGRE() {
        if activeFilter_MGRE == .favourites_mgre || isFavoriteMode_MGRE {
            applyFilters_MGRE()
            applySnapshot_MGRE(for: modelType_MGRE)
        }
    }
    
    func applySnapshot_MGRE(for contentType: ContentType_MGRE) {
        let deviceType = UIDevice.current.userInterfaceIdiom
        var snapshot = Snapshot_MGRE()
        snapshot.appendSections([.zero])

        if data_MGRE.isEmpty {
            emptyLabel_MGRE.isHidden = false
            if let searchText = searchText_MGRE, !searchText.isEmpty {
                emptyLabel_MGRE.text = "the search has no any results"
            } else {
                emptyLabel_MGRE.text = "You don’t have characters"
            }
        } else {
            emptyLabel_MGRE.isHidden = true
        }
        
        let emptyLabelFontSize: CGFloat = deviceType == .phone ? 19.1 : 32.48
        let emptyLabelLineHeight: CGFloat = deviceType == .phone ? 23.88 : 40.6

        emptyLabel_MGRE.font = UIFont(name: StringConstants.ptSansRegular, size: emptyLabelFontSize)
        emptyLabel_MGRE.setLineHeight(emptyLabelLineHeight)
        
        switch contentType {
        case .mods_mgre: snapshot.appendItems(data_MGRE.map { .mods_mgre($0 as! Mods_MGRE) })
        case .outfitIdeas_mgre: snapshot.appendItems(data_MGRE.map { .outfitIdea_mgre($0 as! OutfitIdea_MGRE) })
        case .characters_mgre: snapshot.appendItems(data_MGRE.map { .characters_mgre($0 as! Character_MGRE) })
        case .collections_mgre: snapshot.appendItems(data_MGRE.map { .collections_mgre($0 as! Collections_MGRE) })
        case .wallpapers_mgre: snapshot.appendItems(data_MGRE.map { .wallpaper_mgre($0 as! Wallpaper_MGRE) })
        default: break
        }
        
        DispatchQueue.main.async {
            self.dataSource_MGRE?.apply(snapshot, animatingDifferences: false)
            self.collectionView_MGRE.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard modelType_MGRE != .mods_mgre && modelType_MGRE != .outfitIdeas_mgre else { return }
        pushTo_MGRE(contentType: modelType_MGRE, index: indexPath.item)
    }
    
    private func pushTo_MGRE(contentType: ContentType_MGRE, index: Int) {
        guard data_MGRE.indices.contains(index), !isPushed_MGRE else { return }
        let vc: UIViewController
        isPushed_MGRE = true
        switch contentType {
        case .mods_mgre:
            guard let model = data_MGRE[index] as? Mods_MGRE else { return }
            let isFavorites = favorites_MGRE.contains(model.favId)
            let modDetailsVC = ModDetailsViewController_MGRE()
            modDetailsVC.isFavourite_MGRE = isFavorites
            modDetailsVC.modelType_MGRE = .mods_mgre(model)
            vc = modDetailsVC
        case .wallpapers_mgre:
            guard let model = data_MGRE[index] as? Wallpaper_MGRE else { return }
            let isFavorites = favorites_MGRE.contains(model.favId)
            let wallpaperVC = WallpaperViewController_MGRE.loadFromNib_MGRE()
            wallpaperVC.isFavourite_MGRE = isFavorites
            wallpaperVC.modelType_MGRE = .wallpapers(model)
            vc = wallpaperVC
        case .characters_mgre:
            guard let model = data_MGRE[index] as? Character_MGRE else { return }
            let isFavorites = favorites_MGRE.contains(model.favId)
            let charactersVC = ModDetailsViewController_MGRE()
            charactersVC.isFavourite_MGRE = isFavorites
            charactersVC.modelType_MGRE = .characters_mgre(model)
            vc = charactersVC
        case .outfitIdeas_mgre:
            guard let model = data_MGRE[index] as? OutfitIdea_MGRE else { return }
            let isFavorites = favorites_MGRE.contains(model.favId)
            let modDetailsVC = ModDetailsViewController_MGRE()
            modDetailsVC.isFavourite_MGRE = isFavorites
            modDetailsVC.modelType_MGRE = .outfitIdeas_mgre(model)
            vc = modDetailsVC
        case .collections_mgre:
            guard let model = data_MGRE[index] as? Collections_MGRE else { return }
            let isFavorites = favorites_MGRE.contains(model.favId)
            let collectionsVC = WallpaperViewController_MGRE.loadFromNib_MGRE()
            collectionsVC.isFavourite_MGRE = isFavorites
            collectionsVC.modelType_MGRE = .collections(model)
            vc = collectionsVC
        default: vc = UIViewController()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func applyFilters_MGRE() {
        var data = allData_MGRE
        if let searchText = searchText_MGRE, !searchText.isEmpty {
            data = data.filter { $0.searchText?.localizedCaseInsensitiveContains(searchText) ?? false }
        }
        
        data = data.filter { model in
            switch activeFilter_MGRE {
            case .all_mgre: return true
            case .favourites_mgre: return favorites_MGRE.contains(model.favId)
            case .new_mgre: return model.new == true
            case .top_mgre: return model.top == true
            default: return favorites_MGRE.contains(model.favId)
            }
        }
        
        data_MGRE = data
    }
}

extension BaseViewController_MGRE {
    func loadContent_MGRE() {
        var _MGNsdzzzg2: Int { 0 }
        var _MGcccc: Bool { false }
        let type = modelType_MGRE
        dropbox_MGRE.fetchContent_MGRE(for: type,
                                       isFavoriteMode: isFavoriteMode_MGRE,
                                       vc: self) { [weak self] (data: [ModelProtocol_MGRE]) in
            DispatchQueue.main.async {
                self?.removeProgressView_MGRE()
                self?.allData_MGRE = data
                self?.applyFilters_MGRE()
                self?.applySnapshot_MGRE(for: type)
            }
        }
    }
    
    func loadFavorites_MGRE() {
        var _MGNrttg2: Int { 0 }
        var _MGcbdfdfda: Bool { false }
        favorites_MGRE = dropbox_MGRE.contentManager.fetchFavorites_MGRE(contentType: modelType_MGRE)
    }
}
