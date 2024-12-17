//
//  SplashViewController.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

// MARK: - SplashViewController_MGRE

class SplashViewController_MGRE: UIViewController {
    // MARK: - UI Components
    
    private var blurView: UIVisualEffectView!
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
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
    
    // Add loading tasks management
    private enum LoadingTask: CaseIterable {
        case checkingInternet
        case initializingDatabase
        case loadingContent
        case preparingApp
            
        var weight: Float {
            switch self {
            case .checkingInternet: return 0.1
            case .initializingDatabase: return 0.3
            case .loadingContent: return 0.4
            case .preparingApp: return 0.2
            }
        }
    }
        
    private var currentTaskIndex = 0
    private var currentProgress: Float = 0
    private let loadingTasks = LoadingTask.allCases
    
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
        startActualLoading()
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
        
        configureDeviceSpecificUI()
    }
    
    private func setupBlurBackground() {
//        if isDevicePhone {
//            backgroundImageView.image = UIImage(named: StringConstants.Images.blurBackgroundIphone)
//        } else {
//            backgroundImageView.image = UIImage(named: StringConstants.Images.blurBackgroundIpad)
//        }
//
//        progressBar.isHidden = true
    }
    
    private func configureDeviceSpecificUI() {
        if isDevicePhone {
            configureForPhone()
        } else {
            configureForIpad()
        }
    }
    
    private func configureForPhone() {
        backgroundImageView.image = UIImage(named: StringConstants.Images.launchScreenBackground)
        
        waitLabel.text = LocalizationKeys.waitALittleBit
        waitLabel.font = UIFont(name: StringConstants.ptSansRegular, size: 20)
        waitLabel.setLineHeight(20)
        
        launchImageView.image = UIImage(named: StringConstants.Images.launchScreen)
        launchImageView.contentMode = .scaleAspectFill
        
        verticalStackView.spacing = 138
        horizontalStackView.spacing = 68
    }
    
    private func configureForIpad() {
        backgroundImageView.image = UIImage(named: StringConstants.Images.launchScreenBackground)

        waitLabel.text = LocalizationKeys.waitALittleBit
        waitLabel.font = UIFont(name: StringConstants.ptSansRegular, size: 34)
        waitLabel.setLineHeight(34)
        
        launchImageView.image = UIImage(named: StringConstants.Images.launchScreenIpad)
        launchImageView.contentMode = .scaleAspectFit

        verticalStackView.spacing = 90
        horizontalStackView.spacing = 115.6
    }
    
    private func applyConstraints() {
        let bottomInsets = Helper.getBottomInset()
        let horizontalStackViewBottomIphone: CGFloat = bottomInsets == 0 ? 34 : 0
        
        let horizontalStackViewBottom: CGFloat = isDevicePhone ? horizontalStackViewBottomIphone : 122

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
            horizontalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -horizontalStackViewBottom),
            
            // Progress Bar Constraints
            progressBar.widthAnchor.constraint(equalToConstant: isDevicePhone ? 80 : 136),
            progressBar.heightAnchor.constraint(equalTo: progressBar.widthAnchor)
        ])
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
    
    // MARK: - App Loading
    
    private func startActualLoading() {
        if !InternetManager_MGRE.shared.checkInternetConnectivity_MGRE() {
            setupBlurBackground()
            DBManager_MGRE().showInternetError_MGRE()
            return
        }
            
        executeNextTask()
    }
        
    private func executeNextTask() {
        guard currentTaskIndex < loadingTasks.count else {
            navigateToApp()
            return
        }
            
        let task = loadingTasks[currentTaskIndex]
            
        switch task {
        case .checkingInternet:
            performInternetCheck()
        case .initializingDatabase:
            initializeDatabase()
        case .loadingContent:
            loadInitialContent()
        case .preparingApp:
            prepareAppContent()
        }
    }
        
    private func updateProgress(for task: LoadingTask, progress: Float) {
        var totalProgress: Float = 0
            
        // Add completed tasks progress
        for index in 0 ..< currentTaskIndex {
            totalProgress += loadingTasks[index].weight
        }
            
        // Add current task progress
        totalProgress += task.weight * progress
            
        // Update UI on main thread
        DispatchQueue.main.async { [weak self] in
            self?.progressBar.progress = CGFloat(totalProgress)
        }
    }
        
    private func completeCurrentTask() {
        currentTaskIndex += 1
        executeNextTask()
    }
        
    // Actual loading tasks
    private func performInternetCheck() {
        updateProgress(for: .checkingInternet, progress: 0.5)
            
        // Simulate network check
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.updateProgress(for: .checkingInternet, progress: 1.0)
            self?.completeCurrentTask()
        }
    }
        
    private func initializeDatabase() {
        // Update progress as database initialization progresses
        DBManager_MGRE.shared.initialize { [weak self] progress in
            self?.updateProgress(for: .initializingDatabase, progress: progress)
        } completion: { [weak self] in
            self?.completeCurrentTask()
        }
    }
        
    private func loadInitialContent() {
        // Load initial content with progress
        ContentManager_MGRE().loadInitialContent { [weak self] progress in
            self?.updateProgress(for: .loadingContent, progress: progress)
        } completion: { [weak self] in
            self?.completeCurrentTask()
        }
    }
        
    private func prepareAppContent() {
        updateProgress(for: .preparingApp, progress: 0.5)
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.updateProgress(for: .preparingApp, progress: 1.0)
            self?.completeCurrentTask()
        }
    }
}

extension DBManager_MGRE {
    func initialize(progress: @escaping (Float) -> Void, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            progress(1.0)
            completion()
        }
    }
}

extension ContentManager_MGRE {
    func loadInitialContent(progress: @escaping (Float) -> Void, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            progress(1.0)
            completion()
        }
    }
}
