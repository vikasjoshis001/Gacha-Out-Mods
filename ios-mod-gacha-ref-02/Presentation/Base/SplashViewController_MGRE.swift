//
//  SplashViewController.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

class SplashViewController_MGRE: UIViewController {
    // MARK: - UI Components
    
    private let backgroundImageView_MGRE: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: StringConstants.Images.launchScreenBackground)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let launchImageView_MGRE: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: StringConstants.Images.launchScreen)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let waitLabel_MGRE: UILabel = {
        let label = UILabel()
        label.text = LocalizationKeys.waitALittleBit
        label.textColor = UIColor.blackText
        label.font = Typography.heading
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let progressBar_MGRE = RoundProgressBar_MGRE(frame: .zero)
    
    // MARK: - Properties
    
    private var animationDuration: TimeInterval = 2.0
    private var progress: CGFloat = 0.0
    private var timer: Timer?
    var onDismiss: (() -> Void)?
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startLoadingAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        view.addSubview(backgroundImageView_MGRE)
        view.sendSubviewToBack(backgroundImageView_MGRE)
        view.addSubview(launchImageView_MGRE)
        view.addSubview(waitLabel_MGRE)
        view.addSubview(progressBar_MGRE)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Background Image
            backgroundImageView_MGRE.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView_MGRE.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView_MGRE.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView_MGRE.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // Launch Image
            launchImageView_MGRE.widthAnchor.constraint(equalToConstant: 375),
            launchImageView_MGRE.heightAnchor.constraint(equalToConstant: 375),
            launchImageView_MGRE.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            launchImageView_MGRE.topAnchor.constraint(equalTo: view.topAnchor, constant: 191),
            
            // Wait Label
            waitLabel_MGRE.widthAnchor.constraint(equalToConstant: 167),
            waitLabel_MGRE.heightAnchor.constraint(equalToConstant: 20),
            waitLabel_MGRE.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -64),
            waitLabel_MGRE.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
            
            // Progress Bar
            progressBar_MGRE.widthAnchor.constraint(equalToConstant: 80),
            progressBar_MGRE.heightAnchor.constraint(equalToConstant: 80),
            progressBar_MGRE.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -34),
            progressBar_MGRE.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -29)
        ])
    }
    
    // MARK: - Animation Methods
    
    private func startLoadingAnimation() {
        animateProgress(progressBar: progressBar_MGRE, animationDuration: animationDuration) { [weak self] in
            guard let self = self else { return }
            self.navigateToApp()
            self.onDismiss?()
        }
    }
    
    private func animateProgress(
        progressBar: RoundProgressBar_MGRE,
        animationDuration: TimeInterval = 2.0,
        completion: @escaping () -> Void
    ) {
        let animationSteps = Int(animationDuration / 0.05)
        let stepIncrement = 1.0 / Float(animationSteps)
        var progress: CGFloat = 0.0
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            progress += CGFloat(stepIncrement)
            progressBar.progress = progress
            
            if progress >= 1.0 {
                timer.invalidate()
                completion()
            }
        }
    }
    
    // MARK: - Navigation
    
    private func navigateToApp() {
        let containerViewController = BaseContainer_MGRE()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                window.rootViewController = containerViewController
                window.makeKeyAndVisible()
            }
        }
    }
}
