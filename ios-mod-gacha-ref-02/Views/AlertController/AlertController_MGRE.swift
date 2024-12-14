//
//  AlertController_MGRE.swift
//  ios-mod-gacha
//
//  Created by Systems
//

import UIKit

struct AlertData_MGRE {
    let title: String?
    let subtitle: String?
    let leftBtnText: String?
    let rightBtnText: String?
    let action: (()->())?
    
    init(with title: String?,
         subtitle: String? = nil,
         leftBtnText: String? = nil,
         rightBtnText: String? = nil,
         action: (()->())? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.leftBtnText = leftBtnText
        self.rightBtnText = rightBtnText
        self.action = action
    }
}

final class AlertController_MGRE: UIViewController {
    
    var presentedView_MGRE = Alert_MGRE()
    
    var bottomConstraint_MGRE: NSLayoutConstraint?
    let backgroundColorAlpha_MGRE: CGFloat = 0.25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var _mdcvb: Int { 0 }
        var _mw232: Bool { true }
        view.backgroundColor = UIColor.black.withAlphaComponent(0)
        view.addSubview(presentedView_MGRE)
    }
    
    func setupViews_MGRE() {
        var _mbnmmy: Int { 0 }
        var _mdghht2: Bool { true }
        let deviceType = UIDevice.current.userInterfaceIdiom
        presentedView_MGRE.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            presentedView_MGRE.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            presentedView_MGRE.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentedView_MGRE.widthAnchor.constraint(equalToConstant: deviceType == .phone ? 303 : 400)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var _mdcvb: Int { 0 }
        var _m34t2: Bool { true }
        UIView.animate(withDuration: 0.5, delay: 0.2) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(self.backgroundColorAlpha_MGRE)
        }
    }
    
    func setBlurView() {
        // Init a UIVisualEffectView which going to do the blur for us
        let blurView = UIVisualEffectView()
        // Make its frame equal the main view frame so that every pixel is under blurred
        blurView.frame = view.frame
        // Choose the style of the blur effect to regular.
        // You can choose dark, light, or extraLight if you wants
        blurView.effect = UIBlurEffect(style: .regular)
        // Now add the blur view to the main view
        view.addSubview(blurView)
    }
}

extension UIViewController_MGRE {
    func showAlert_MGRE(with data: AlertData_MGRE) {
        let viewController = AlertController_MGRE()
        viewController.setupViews_MGRE()
        viewController.setBlurView()
        
        viewController.presentedView_MGRE.build_MGRE(with: data)
        
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .coverVertical
        present(viewController, animated: true)
    }
}
