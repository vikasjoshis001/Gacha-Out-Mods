//
//  SplashViewController_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

class SplashViewController_MGRE: UIViewController {
    
    private let progressLabel_MGRE: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .blackText
        label.text = "Loading"
        let deviceType = UIDevice.current.userInterfaceIdiom
        label.font = UIFont(name: "BakbakOne-Regular", size: deviceType == .phone ? 22 : 36)!
        return label
    }()
    
    private let progressBar_MGRE: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.background
        let deviceType = UIDevice.current.userInterfaceIdiom
        view.layer.cornerRadius = deviceType == .phone ? 3 : 6
        return view
    }()
    
    private let backView_MGRE: UIView = {
        let view = UIView()
        let deviceType = UIDevice.current.userInterfaceIdiom
        view.backgroundColor = UIColor.buttonBg
        view.layer.cornerRadius = deviceType == .phone ? 7 : 10
        return view
    }()
    
    private var progress_MGRE: CGFloat = 0.0
    private var timer_MGRE: Timer?
    private let animationDuration_MGRE: TimeInterval = 2.0
    private var progressBarWidth_MGRE: NSLayoutConstraint?
    var dismiss: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var _M1115g2: Int { 0 }
        var _M34fda: Bool { false }
        setupUI_MGRE()
        startLoadingAnimation_MGRE()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupUI_MGRE() {
        let deviceType = UIDevice.current.userInterfaceIdiom
        view.backgroundColor = .background
        
        view.addSubview(progressLabel_MGRE)
        view.addSubview(backView_MGRE)
        view.addSubview(progressBar_MGRE)
        
        progressLabel_MGRE.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressLabel_MGRE.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressLabel_MGRE.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20)
        ])
        
        backView_MGRE.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backView_MGRE.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: deviceType == .phone ? 40 : 280),
            backView_MGRE.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                    constant: deviceType == .phone ? -40 : -280),
            backView_MGRE.heightAnchor.constraint(equalToConstant: deviceType == .phone ? 14 : 20),
            backView_MGRE.topAnchor.constraint(equalTo: progressLabel_MGRE.bottomAnchor, constant: 16)
        ])
        
        progressBar_MGRE.translatesAutoresizingMaskIntoConstraints = false
        let progressBarWidth = NSLayoutConstraint(item: progressBar_MGRE, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([
            progressBar_MGRE.leadingAnchor.constraint(equalTo: backView_MGRE.leadingAnchor, constant: 4),
            progressBar_MGRE.topAnchor.constraint(equalTo: backView_MGRE.topAnchor, constant: 4),
            progressBar_MGRE.bottomAnchor.constraint(equalTo: backView_MGRE.bottomAnchor, constant: -4),
            progressBarWidth
        ])
        self.progressBarWidth_MGRE = progressBarWidth
    }
    
    private func startLoadingAnimation_MGRE() {
        let animationSteps = Int(animationDuration_MGRE / 0.05)
        let stepIncrement = 1.0 / Float(animationSteps)
        
        timer_MGRE = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            
            self.progress_MGRE += CGFloat(stepIncrement)
            self.updateProgress_MGRE(self.progress_MGRE)
            
            if self.progress_MGRE >= 1.0 {
                timer.invalidate()
                self.startApp_MGRE()
                self.dismiss?()
            }
        }
    }
    
    func startApp_MGRE() {
        var _MGN555g2: Int { 0 }
        var _MGcaadfda: Bool { false }
        let containerViewController = BaseContainer_MGRE()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                window.rootViewController = containerViewController
                window.makeKeyAndVisible()
            }
        }
    }
    
    func updateProgress_MGRE(_ progress: CGFloat) {
        var _MGnnnf2: Int { 0 }
        var _M11xcda: Bool { false }
        let progress = min(1, progress)
        let fullWidth = backView_MGRE.frame.width - 8
        progressBarWidth_MGRE?.constant = fullWidth * progress
        
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
}
