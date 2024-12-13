//
//  SplashViewController.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

class SplashViewController_MGRE: UIViewController {
    // MARK: - UI Components
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: StringConstants.Images.launchScreenBackground))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let launchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let waitLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.blackText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let progressBar = RoundProgressBar_MGRE(frame: .zero)
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Properties
    
    private let animationDuration: TimeInterval = 2.0
    private var timer: Timer?
    var onDismiss: (() -> Void)?
    
    private var isDevicePhone: Bool {
        return Helper.getDeviceType() == .phone
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        startLoadingAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyConstraints()
    }
    
    // MARK: - UI Configuration
    
    private func configureUI() {
        // Add subviews
        view.addSubview(backgroundImageView)
        view.addSubview(verticalStackView)
        view.sendSubviewToBack(backgroundImageView)
        
        // Setup horizontal stack view
        horizontalStackView.addArrangedSubview(waitLabel)
        horizontalStackView.addArrangedSubview(progressBar)
        
        // Setup vertical stack view
        verticalStackView.addArrangedSubview(launchImageView)
        verticalStackView.addArrangedSubview(horizontalStackView)
        
        // Configure device-specific UI
        configureDeviceSpecificUI()
    }
    
    private func configureDeviceSpecificUI() {
        if isDevicePhone {
            configureForPhone()
        } else {
            configureForIpad()
        }
    }
    
    private func configureForPhone() {
        waitLabel.text = LocalizationKeys.waitALittleBit
        waitLabel.font = UIFont(name: StringConstants.ptSansRegular, size: 20)
        waitLabel.setLineHeight(20)
        
        launchImageView.image = UIImage(named: StringConstants.Images.launchScreen)
        launchImageView.contentMode = .scaleAspectFill
        
        verticalStackView.spacing = 138
        horizontalStackView.spacing = 68
    }
    
    private func configureForIpad() {
        waitLabel.text = LocalizationKeys.waitALittleBit
        waitLabel.font = UIFont(name: StringConstants.ptSansRegular, size: 34)
        waitLabel.setLineHeight(34)
        
        launchImageView.image = UIImage(named: StringConstants.Images.launchScreenIpad)
        launchImageView.contentMode = .scaleAspectFit

        verticalStackView.spacing = 90
        horizontalStackView.spacing = 115.6
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            // Background Image Constraints
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Vertical Stack View Constraints
            verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: isDevicePhone ? 147 : 170.53),
            
            // Launch Image Constraints
            launchImageView.widthAnchor.constraint(equalToConstant: isDevicePhone ? 375 : 818),
            launchImageView.heightAnchor.constraint(equalTo: launchImageView.widthAnchor),
            
            // Horizontal Stack View Constraints
            horizontalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            horizontalStackView.heightAnchor.constraint(equalToConstant: isDevicePhone ? 80 : 136),
            horizontalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: isDevicePhone ? -64 : -173),
            
            // Progress Bar Constraints
            progressBar.widthAnchor.constraint(equalToConstant: isDevicePhone ? 80 : 136),
            progressBar.heightAnchor.constraint(equalTo: progressBar.widthAnchor)
        ])
    }
    
    // MARK: - Animation
    
    private func startLoadingAnimation() {
        animateProgress(progressBar: progressBar, duration: animationDuration) { [weak self] in
            self?.navigateToApp()
        }
    }
    
    private func animateProgress(progressBar: RoundProgressBar_MGRE, duration: TimeInterval, completion: @escaping () -> Void) {
        let stepInterval = 0.05
        let animationSteps = Int(duration / stepInterval)
        let progressIncrement = 1.0 / CGFloat(animationSteps)
        var progress: CGFloat = 0.0
        
        timer = Timer.scheduledTimer(withTimeInterval: stepInterval, repeats: true) { [weak self] timer in
            guard let _ = self else { return }
            progress += progressIncrement
            progressBar.progress = progress
            
            if progress > 1.0 {
                timer.invalidate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    completion()
                }
            }
        }
    }
    
    // MARK: - Navigation
    
    private func navigateToApp() {
        let window: UIWindow?
        if #available(iOS 15.0, *) {
            window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first
        } else {
            window = UIApplication.shared.windows.first
        }
            
        guard let mainWindow = window else { return }
        mainWindow.rootViewController = BaseContainer_MGRE()
        mainWindow.makeKeyAndVisible()
        onDismiss?()
    }
}
