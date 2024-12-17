//
//  LayoutConfig_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

// MARK: - LayoutConfig_MGRE

struct LayoutConfig_MGRE {
    let itemWidth: CGFloat
    let itemHeight: CGFloat
    let columns: Int
    let horizontalSpacing: CGFloat
    let verticalSpacing: CGFloat
    let sectionInsets: UIEdgeInsets
    
    static let defaultPhoneInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    static let defaultPadInsets = UIEdgeInsets(top: 0, left: 85, bottom: 0, right: 85)
    
    static func getItemWidth(with columns: Int, horizontalSpacing: CGFloat, sectionInsets: UIEdgeInsets) -> CGFloat {
        let totalSpacing = CGFloat(columns - 1) * horizontalSpacing + sectionInsets.left + sectionInsets.right
        let width = (UIScreen.main.bounds.width - totalSpacing) / CGFloat(columns)
        return width
    }
}

typealias NSCollectionLayoutSection_MGRE = NSCollectionLayoutSection

extension NSCollectionLayoutSection_MGRE {
    static func generateLayout_MGRE(for modelType: ContentType_MGRE) -> NSCollectionLayoutSection {
        let config: LayoutConfig_MGRE
        let deviceType = UIDevice.current.userInterfaceIdiom
        switch (modelType, deviceType) {
        case (.mods_mgre, .phone):
            let itemWidth = LayoutConfig_MGRE.getItemWidth(with: 1,
                                                           horizontalSpacing: 0,
                                                           sectionInsets: LayoutConfig_MGRE.defaultPhoneInsets)
            config = LayoutConfig_MGRE(itemWidth: itemWidth,
                                       itemHeight: 269,
                                       columns: 1,
                                       horizontalSpacing: 0,
                                       verticalSpacing: 15,
                                       sectionInsets: LayoutConfig_MGRE.defaultPhoneInsets)
        case (.mods_mgre, .pad):
            let itemWidth = LayoutConfig_MGRE.getItemWidth(with: 1,
                                                           horizontalSpacing: 0,
                                                           sectionInsets: LayoutConfig_MGRE.defaultPadInsets)
            config = LayoutConfig_MGRE(itemWidth: itemWidth,
                                       itemHeight: 435,
                                       columns: 1,
                                       horizontalSpacing: 0,
                                       verticalSpacing: 25.5,
                                       sectionInsets: LayoutConfig_MGRE.defaultPadInsets)
        case (.outfitIdeas_mgre, .phone):
            let itemWidth = LayoutConfig_MGRE.getItemWidth(with: 1,
                                                           horizontalSpacing: 0,
                                                           sectionInsets: LayoutConfig_MGRE.defaultPhoneInsets)
            config = LayoutConfig_MGRE(itemWidth: itemWidth,
                                       itemHeight: 218,
                                       columns: 1,
                                       horizontalSpacing: 0,
                                       verticalSpacing: 15,
                                       sectionInsets: LayoutConfig_MGRE.defaultPhoneInsets)
        case (.outfitIdeas_mgre, .pad):
            let itemWidth = LayoutConfig_MGRE.getItemWidth(with: 1,
                                                           horizontalSpacing: 0,
                                                           sectionInsets: LayoutConfig_MGRE.defaultPadInsets)
            config = LayoutConfig_MGRE(itemWidth: itemWidth,
                                       itemHeight: 350,
                                       columns: 1,
                                       horizontalSpacing: 0,
                                       verticalSpacing: 25.5,
                                       sectionInsets: LayoutConfig_MGRE.defaultPadInsets)
        case (.wallpapers_mgre, .phone):
            config = LayoutConfig_MGRE(itemWidth: 143,
                                       itemHeight: 210,
                                       columns: 2,
                                       horizontalSpacing: 19,
                                       verticalSpacing: 14,
                                       sectionInsets: LayoutConfig_MGRE.defaultPhoneInsets)
        case (.wallpapers_mgre, .pad):
            config = LayoutConfig_MGRE(itemWidth: 243.1,
                                       itemHeight: 357,
                                       columns: 2,
                                       horizontalSpacing: 32.3,
                                       verticalSpacing: 23.8,
                                       sectionInsets: LayoutConfig_MGRE.defaultPadInsets)
        case (.characters_mgre, .phone):
            config = LayoutConfig_MGRE(itemWidth: 316,
                                       itemHeight: 210,
                                       columns: 1,
                                       horizontalSpacing: 0,
                                       verticalSpacing: 14,
                                       sectionInsets: LayoutConfig_MGRE.defaultPhoneInsets)
            
        case (.characters_mgre, .pad):
            config = LayoutConfig_MGRE(itemWidth: 538,
                                       itemHeight: 358,
                                       columns: 1,
                                       horizontalSpacing: 0,
                                       verticalSpacing: 23.8,
                                       sectionInsets: LayoutConfig_MGRE.defaultPadInsets)
        case (.collections_mgre, .phone):
            config = LayoutConfig_MGRE(itemWidth: 143,
                                       itemHeight: 210,
                                       columns: 2,
                                       horizontalSpacing: 19,
                                       verticalSpacing: 14,
                                       sectionInsets: LayoutConfig_MGRE.defaultPhoneInsets)
                
        case (.collections_mgre, .pad):
            config = LayoutConfig_MGRE(itemWidth: 243.1,
                                       itemHeight: 357,
                                       columns: 2,
                                       horizontalSpacing: 32.3,
                                       verticalSpacing: 23.8,
                                       sectionInsets: LayoutConfig_MGRE.defaultPadInsets)
        default:
            fatalError("Unsupported configuration")
        }
        
        return generateLayout_MGRE(using: config)
    }
    
    private static func generateLayout_MGRE(using config: LayoutConfig_MGRE) -> NSCollectionLayoutSection {
        let totalItemHeight = config.itemHeight + config.verticalSpacing
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(config.itemWidth),
                                              heightDimension: .absolute(totalItemHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                     leading: 0,
                                                     bottom: 0,
                                                     trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(totalItemHeight))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: config.columns)
        group.interItemSpacing = .fixed(config.horizontalSpacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: config.sectionInsets.top,
                                                        leading: config.sectionInsets.left,
                                                        bottom: config.sectionInsets.bottom,
                                                        trailing: config.sectionInsets.right)
        section.interGroupSpacing = config.verticalSpacing
        return section
    }
}
