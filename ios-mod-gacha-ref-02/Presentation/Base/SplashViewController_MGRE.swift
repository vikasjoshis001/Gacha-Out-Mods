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
    private let backgroundImageView_MGRE: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let launchImageView_MGRE: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let waitLabel_MGRE: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.blackText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let progressBar_MGRE = RoundProgressBar_MGRE(frame: .zero)
    
    private let horizontalStackView_MGRE: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let verticalStackView_MGRE: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Add loading tasks management
    private enum LoadingTask_MGRE: CaseIterable {
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
    private let loadingTasks = LoadingTask_MGRE.allCases
    
    // MARK: - Properties
    
    private let animationDuration: TimeInterval = 2.0
    private var timer: Timer?
    var onDismiss: (() -> Void)?
    
    private var isDevicePhone: Bool {
        return Helper.getDeviceType_MGRE() == .phone
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI_MGRE()
        startActualLoading_MGRE()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyConstraints_MGRE()
    }
    
    // MARK: - UI Configuration
    
    private func configureUI_MGRE() {
        // Add subviews
        view.addSubview(backgroundImageView_MGRE)
        view.addSubview(verticalStackView_MGRE)
        view.sendSubviewToBack(backgroundImageView_MGRE)
        
        // Setup horizontal stack view
        horizontalStackView_MGRE.addArrangedSubview(waitLabel_MGRE)
        horizontalStackView_MGRE.addArrangedSubview(progressBar_MGRE)
        
        // Setup vertical stack view
        verticalStackView_MGRE.addArrangedSubview(launchImageView_MGRE)
        verticalStackView_MGRE.addArrangedSubview(horizontalStackView_MGRE)
        
        configureDeviceSpecificUI_MGRE()
    }
    
    private func configureDeviceSpecificUI_MGRE() {
        if isDevicePhone {
            configureForPhone_MGRE()
        } else {
            configureForIpad_MGRE()
        }
    }
    
    private func configureForPhone_MGRE() {
        backgroundImageView_MGRE.image = UIImage(named: StringConstants_MGRE.Images.launchScreenBackground)
        
        waitLabel_MGRE.text = LocalizationKeys.waitALittleBit
        waitLabel_MGRE.font = UIFont(name: StringConstants_MGRE.ptSansRegular, size: 20)
        waitLabel_MGRE.setLineHeight_MGRE(20)
        
        launchImageView_MGRE.image = UIImage(named: StringConstants_MGRE.Images.launchScreen)
        launchImageView_MGRE.contentMode = .scaleAspectFill
        
        verticalStackView_MGRE.spacing = 138
        horizontalStackView_MGRE.spacing = 68
    }
    
    private func configureForIpad_MGRE() {
        backgroundImageView_MGRE.image = UIImage(named: StringConstants_MGRE.Images.launchScreenBackground)

        waitLabel_MGRE.text = LocalizationKeys.waitALittleBit
        waitLabel_MGRE.font = UIFont(name: StringConstants_MGRE.ptSansRegular, size: 34)
        waitLabel_MGRE.setLineHeight_MGRE(34)
        
        launchImageView_MGRE.image = UIImage(named: StringConstants_MGRE.Images.launchScreenIpad)
        launchImageView_MGRE.contentMode = .scaleAspectFit

        verticalStackView_MGRE.spacing = 90
        horizontalStackView_MGRE.spacing = 115.6
    }
    
    private func applyConstraints_MGRE() {
        let bottomInsets = Helper.getBottomInset_MGRE()
        let horizontalStackViewBottomIphone: CGFloat = bottomInsets == 0 ? 34 : 0
        
        let horizontalStackViewBottom: CGFloat = isDevicePhone ? horizontalStackViewBottomIphone : 122

        NSLayoutConstraint.activate([
            // Background Image Constraints
            backgroundImageView_MGRE.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView_MGRE.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView_MGRE.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView_MGRE.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Vertical Stack View Constraints
            verticalStackView_MGRE.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStackView_MGRE.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: isDevicePhone ? 147 : 170.53),
            
            // Launch Image Constraints
            launchImageView_MGRE.widthAnchor.constraint(equalToConstant: isDevicePhone ? 375 : 818),
            launchImageView_MGRE.heightAnchor.constraint(equalTo: launchImageView_MGRE.widthAnchor),
            
            // Horizontal Stack View Constraints
            horizontalStackView_MGRE.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            horizontalStackView_MGRE.heightAnchor.constraint(equalToConstant: isDevicePhone ? 80 : 136),
            horizontalStackView_MGRE.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -horizontalStackViewBottom),
            
            // Progress Bar Constraints
            progressBar_MGRE.widthAnchor.constraint(equalToConstant: isDevicePhone ? 80 : 136),
            progressBar_MGRE.heightAnchor.constraint(equalTo: progressBar_MGRE.widthAnchor)
        ])
    }
        
    // MARK: - Navigation
    
    private func navigateToApp_MGRE() {
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
    
    private func startActualLoading_MGRE() {
        if !InternetManager_MGRE.shared.checkInternetConnectivity_MGRE() {
            DBManager_MGRE().showInternetError_MGRE()
            return
        }
            
        executeNextTask_MGRE()
    }
        
    private func executeNextTask_MGRE() {
        guard currentTaskIndex < loadingTasks.count else {
            navigateToApp_MGRE()
            return
        }
            
        let task = loadingTasks[currentTaskIndex]
            
        switch task {
        case .checkingInternet:
            performInternetCheck_MGRE()
        case .initializingDatabase:
            initializeDatabase_MGRE()
        case .loadingContent:
            loadInitialContent_MGRE()
        case .preparingApp:
            prepareAppContent_MGRE()
        }
    }
        
    private func updateProgress_MGRE(for task: LoadingTask_MGRE, progress: Float) {
        var totalProgress: Float = 0
            
        // Add completed tasks progress
        for index in 0 ..< currentTaskIndex {
            totalProgress += loadingTasks[index].weight
        }
            
        // Add current task progress
        totalProgress += task.weight * progress
            
        // Update UI on main thread
        DispatchQueue.main.async { [weak self] in
            self?.progressBar_MGRE.progress_MGRE = CGFloat(totalProgress)
        }
    }
        
    private func completeCurrentTask_MGRE() {
        currentTaskIndex += 1
        executeNextTask_MGRE()
    }
        
    // Actual loading tasks
    private func performInternetCheck_MGRE() {
        updateProgress_MGRE(for: .checkingInternet, progress: 0.5)
            
        // Simulate network check
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.updateProgress_MGRE(for: .checkingInternet, progress: 1.0)
            self?.completeCurrentTask_MGRE()
        }
    }
        
    private func initializeDatabase_MGRE() {
        // Update progress as database initialization progresses
        DBManager_MGRE.shared.initialize_MGRE { [weak self] progress in
            self?.updateProgress_MGRE(for: .initializingDatabase, progress: progress)
        } completion: { [weak self] in
            self?.completeCurrentTask_MGRE()
        }
    }
        
    private func loadInitialContent_MGRE() {
        // Load initial content with progress
        ContentManager_MGRE().loadInitialContent_MGRE { [weak self] progress in
            self?.updateProgress_MGRE(for: .loadingContent, progress: progress)
        } completion: { [weak self] in
            self?.completeCurrentTask_MGRE()
        }
    }
        
    private func prepareAppContent_MGRE() {
        updateProgress_MGRE(for: .preparingApp, progress: 0.5)
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.updateProgress_MGRE(for: .preparingApp, progress: 1.0)
            self?.completeCurrentTask_MGRE()
        }
    }
}

extension DBManager_MGRE {
    func initialize_MGRE(progress: @escaping (Float) -> Void, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            progress(1.0)
            completion()
        }
    }
}

extension ContentManager_MGRE {
    func loadInitialContent_MGRE(progress: @escaping (Float) -> Void, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            progress(1.0)
            completion()
        }
    }
}
