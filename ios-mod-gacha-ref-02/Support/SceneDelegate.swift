//
//  SceneDelegate.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    static weak var shared: SceneDelegate?
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
 
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        Self.shared = self
        
        let window = UIWindow(windowScene: windowScene)
        window.overrideUserInterfaceStyle = .light
        self.window = window
        
        let baseContainer = SplashViewController_MGRE()
        let navigationController = UINavigationController(rootViewController: baseContainer)
        navigationController.modalPresentationStyle = .fullScreen
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

}
