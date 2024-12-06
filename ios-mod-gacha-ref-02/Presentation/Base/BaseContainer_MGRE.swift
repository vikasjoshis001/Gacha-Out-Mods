//
//  BaseContainer_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

class BaseContainer_MGRE: UIViewController {
    
    // MARK: - Properties
    private var menuViewController_MGRE: MenuViewController_MGRE!
    private var iPadMenuViewController_MGRE: IpadMenuViewController_MGRE!
    private var navController_MGRE: UINavigationController!
    private var dimmingView_MGRE: UIView!
    
    private var isMenuOpen_MGRE: Bool = false
    private var selectedMenu_MGRE: MenuItem_MGRE = .mods_MGRE
    
    private let deviceType = Helper.getDeviceType()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Content view controller
        let contentViewController = BaseViewController_MGRE.loadFromNib_MGRE()
        contentViewController.modelType_MGRE = .mods_mgre
        contentViewController.navTitle_MGRE = MenuItem_MGRE.mods_MGRE.rawValue
        contentViewController.toggleMenuAction_MGRE = { [weak self] in
            self?.toggleMenu_MGRE()
        }
        selectedMenu_MGRE = .mods_MGRE
        
        // Navigation controller
        navController_MGRE = UINavigationController(rootViewController: contentViewController)
        addChild(navController_MGRE)
        view.addSubview(navController_MGRE.view)
        navController_MGRE.didMove(toParent: self)
        
        // Dimming view
        dimmingView_MGRE = UIView(frame: view.bounds)
        dimmingView_MGRE.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmingView_MGRE.alpha = 0.0
        view.addSubview(dimmingView_MGRE)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapped_MGRE))
        dimmingView_MGRE.addGestureRecognizer(tap)
        
        // Menu view controller
        menuViewController_MGRE = MenuViewController_MGRE.loadFromNib_MGRE()
        menuViewController_MGRE.menuAction_MGRE = { [weak self] type in
            self?.selectMenu_MGRE(type)
        }
        addChild(menuViewController_MGRE)
        view.addSubview(menuViewController_MGRE.view)
        menuViewController_MGRE.didMove(toParent: self)
        view.bringSubviewToFront(menuViewController_MGRE.view)
        
        let menuWidth: CGFloat = view.bounds.width * 0.56
        menuViewController_MGRE.view.frame = CGRect(x: -menuWidth, 
                                                    y: 0, 
                                                    width: menuWidth,
                                                    height: view.bounds.height)
        UIHelper.applyBottomRightCornerRadius(to: menuViewController_MGRE.view, radius: 20.0)
        
        // Ipad menu view controller
        iPadMenuViewController_MGRE = IpadMenuViewController_MGRE.loadFromNib_MGRE()
        iPadMenuViewController_MGRE.menuAction_MGRE = { [weak self] type in
            self?.selectMenu_MGRE(type)
        }
        addChild(iPadMenuViewController_MGRE)
        view.addSubview(iPadMenuViewController_MGRE.view)
        iPadMenuViewController_MGRE.didMove(toParent: self)
        view.bringSubviewToFront(iPadMenuViewController_MGRE.view)
        
        let contentHeight = iPadMenuViewController_MGRE.getContentHeight()
        let maxHeight: CGFloat = view.bounds.height
        
        let iPadMenuWidth: CGFloat = 430
        let iPadMenuHeight: CGFloat = min(contentHeight, maxHeight)
        iPadMenuViewController_MGRE.view.frame = CGRect(
            x: (view.bounds.width - iPadMenuWidth) / 2,
            y: view.bounds.height,
            width: iPadMenuWidth,
            height: iPadMenuHeight
        )
        iPadMenuViewController_MGRE.view.layer.cornerRadius = 24
    }
    
    @objc
    private func dimmingViewTapped_MGRE(_ sender: UITapGestureRecognizer) {
        toggleMenu_MGRE()
    }
    
    func toggleMenu_MGRE() {
        if deviceType == .phone {
            let menuWidth: CGFloat = menuViewController_MGRE.view.bounds.width
            let shouldOpen = !isMenuOpen_MGRE
            UIView.animate(withDuration: 0.3, animations: {
                self.menuViewController_MGRE.view.frame.origin.x = shouldOpen ? 0 : -menuWidth
                self.dimmingView_MGRE.alpha = shouldOpen ? 1.0 : 0.0
                self.navController_MGRE.view.layer.shadowOpacity = shouldOpen ? 0.5 : 0.0
            })
            isMenuOpen_MGRE = shouldOpen
        } else {
            let shouldOpen = !isMenuOpen_MGRE
            UIView.animate(withDuration: 0.0, animations: {
                if shouldOpen {
                    self.iPadMenuViewController_MGRE.view.center = self.view.center
                } else {
                    self.iPadMenuViewController_MGRE.view.center = CGPoint(
                        x: self.view.center.x,
                        y: self.view.bounds.height + self.iPadMenuViewController_MGRE.view.bounds.height / 2
                    )
                }
                self.dimmingView_MGRE.alpha = shouldOpen ? 1.0 : 0.0
                self.navController_MGRE.view.layer.shadowOpacity = shouldOpen ? 0.5 : 0.0
            })
            isMenuOpen_MGRE = shouldOpen
        }
    }
    
    private func selectMenu_MGRE(_ item: MenuItem_MGRE) {
        guard item != selectedMenu_MGRE else { return }
        selectedMenu_MGRE = item
        switch item {
        case .mods_MGRE:
            let vc = BaseViewController_MGRE.loadFromNib_MGRE()
            vc.modelType_MGRE = .mods_mgre
            vc.navTitle_MGRE = item.rawValue
            vc.toggleMenuAction_MGRE = { [weak self] in self?.toggleMenu_MGRE() }
            switchToViewController(vc)
        case .wallpapers_MGRE:
            let vc = BaseViewController_MGRE.loadFromNib_MGRE()
            vc.modelType_MGRE = .wallpapers_mgre
            vc.navTitle_MGRE = item.rawValue
            vc.toggleMenuAction_MGRE = { [weak self] in self?.toggleMenu_MGRE() }
            switchToViewController(vc)
        case .characters_MGRE:
            let vc = BaseViewController_MGRE.loadFromNib_MGRE()
            vc.modelType_MGRE = .characters_mgre
            vc.navTitle_MGRE = item.rawValue
            vc.toggleMenuAction_MGRE = { [weak self] in self?.toggleMenu_MGRE() }
            switchToViewController(vc)
        case .outfitIdeas_MGRE:
            let vc = BaseViewController_MGRE.loadFromNib_MGRE()
            vc.modelType_MGRE = .outfitIdeas_mgre
            vc.navTitle_MGRE = item.rawValue
            vc.toggleMenuAction_MGRE = { [weak self] in self?.toggleMenu_MGRE() }
            switchToViewController(vc)
        case .collections_MGRE:
            let vc = BaseViewController_MGRE.loadFromNib_MGRE()
            vc.modelType_MGRE = .collections_mgre
            vc.navTitle_MGRE = item.rawValue
            vc.toggleMenuAction_MGRE = { [weak self] in self?.toggleMenu_MGRE() }
            switchToViewController(vc)
        case .editor_MGRE:
            let vc = CharacterListViewController_MGRE.loadFromNib_MGRE()
            vc.toggleMenuAction_MGRE = { [weak self] in self?.toggleMenu_MGRE() }
            switchToViewController(vc)
        case .favorites_MGRE:
            let vc = BaseViewController_MGRE.loadFromNib_MGRE()
            vc.isFavoriteMode_MGRE = true
            vc.modelType_MGRE = .mods_mgre
            vc.navTitle_MGRE = item.rawValue
            vc.toggleMenuAction_MGRE = { [weak self] in self?.toggleMenu_MGRE() }
            switchToViewController(vc)
        }
    }
    
    func switchToViewController(_ viewController: UIViewController) {
        UIView.animate(withDuration: 0.3, animations: {
            self.menuViewController_MGRE.view.frame.origin.x = -self.menuViewController_MGRE.view.bounds.width
            self.iPadMenuViewController_MGRE.view.frame.origin.x = -self.iPadMenuViewController_MGRE.view.bounds.width
            self.dimmingView_MGRE.alpha = 0.0
        }) { _ in
            self.navController_MGRE.viewControllers = [viewController]
            self.isMenuOpen_MGRE = false
            self.navController_MGRE.view.layer.shadowOpacity = 0.0
        }
    }
}
