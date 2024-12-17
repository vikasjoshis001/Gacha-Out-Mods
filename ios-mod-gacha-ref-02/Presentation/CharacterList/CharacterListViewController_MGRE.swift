//
//  CharacterListViewController_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Vikas Joshi on 17/12/24.
//

import UIKit

// MARK: - CharacterListViewController_MGRE

class CharacterListViewController_MGRE: UIViewController {
    private let backgroundImageView_MGRE: UIImageView = {
        let backgroundImageView = UIImageView(image: UIImage(named: Helper.deviceSpecificImage(image: StringConstants.Images.editorBackground)))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.isUserInteractionEnabled = true
        return backgroundImageView
    }()
    
    private let characterImageView_MGRE: UIImageView = {
        let characterImageView_MGRE = UIImageView()
        characterImageView_MGRE.contentMode = .scaleAspectFill
        characterImageView_MGRE.translatesAutoresizingMaskIntoConstraints = false
        characterImageView_MGRE.isUserInteractionEnabled = true
        return characterImageView_MGRE
    }()
    
    private let rightLeftButtonsStackView_MGRE: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.masksToBounds = true
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private let bottomButtonsStackView_MGRE: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.masksToBounds = true
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private let emptyLabel_MGRE: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let rightButton_MGRE = CharacterListViewController_MGRE.makeActionButton_MGRE(image: StringConstants.Images.rightChevron)

    private let leftButton_MGRE = CharacterListViewController_MGRE.makeActionButton_MGRE(image: StringConstants.Images.back)
    
    private let deleteButton_MGRE = CharacterListViewController_MGRE.makeActionButton_MGRE(image: StringConstants.Images.download)
    
    private let createNewCharacterButton_MGRE = CharacterListViewController_MGRE.makeActionButton_MGRE(title: LocalizationKeys.createNewCharacter_MGRE)
    
    let navigationView = NavigationView_MGRE()
    private var dropbox_MGRE: DBManager_MGRE { .shared }
    private var editorContentSet_MGRE: EditorContentSet_MGRE?
    private var characters_MGRE: [CharacterPreview_MGRE] = []
    private var currentPage_MGRE = 0
    private let device = Helper.getDeviceType()
    
    var toggleMenuAction_MGRE: (() -> Void)?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewHierarchy()
        configureCell()
        configureLayout()
        configureNavigationView_MGRE()
        addActionToButtons()
        loadCharacters_MGRE()
        loadContent_MGRE()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Private Methods

    private static func makeActionButton_MGRE(image: String? = nil, title: String? = nil) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .buttonBg
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        if let image = image {
            button.setImage(UIImage(named: Helper.deviceSpecificImage(image: image)), for: .normal)
        } else if let title = title {
            button.setTitle(title, for: .normal)
        }
        return button
    }
    
    private func addActionToButtons() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        characterImageView_MGRE.addGestureRecognizer(tapGesture)
                
        leftButton_MGRE.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        rightButton_MGRE.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        deleteButton_MGRE.addTarget(self, action: #selector(deleteButtonDidTapped), for: .touchUpInside)
        createNewCharacterButton_MGRE.addTarget(self, action: #selector(createNewCharacterButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupViewHierarchy() {
        view.addSubview(backgroundImageView_MGRE)
                
        backgroundImageView_MGRE.addSubview(navigationView)
        backgroundImageView_MGRE.addSubview(rightLeftButtonsStackView_MGRE)
        backgroundImageView_MGRE.addSubview(bottomButtonsStackView_MGRE)
        
        rightLeftButtonsStackView_MGRE.addArrangedSubview(leftButton_MGRE)
        rightLeftButtonsStackView_MGRE.addArrangedSubview(characterImageView_MGRE)
        rightLeftButtonsStackView_MGRE.addArrangedSubview(emptyLabel_MGRE)
        rightLeftButtonsStackView_MGRE.addArrangedSubview(rightButton_MGRE)
        
        bottomButtonsStackView_MGRE.addArrangedSubview(createNewCharacterButton_MGRE)
        bottomButtonsStackView_MGRE.addArrangedSubview(deleteButton_MGRE)
    }
    
    private func configureCell() {
        bottomButtonsStackView_MGRE.spacing = device == .phone ? 13 : 22.1
        
        let buttonsCornerRadius: CGFloat = device == .phone ? 14 : 23.8
        rightButton_MGRE.layer.cornerRadius = buttonsCornerRadius
        leftButton_MGRE.layer.cornerRadius = buttonsCornerRadius
        deleteButton_MGRE.layer.cornerRadius = buttonsCornerRadius
        createNewCharacterButton_MGRE.layer.cornerRadius = buttonsCornerRadius
        
        let emptyLabelFontSize: CGFloat = device == .phone ? 19.1 : 32.48
        let emptyLabelLineHeight: CGFloat = device == .phone ? 23.88 : 40.6
        emptyLabel_MGRE.font = UIFont(name: StringConstants.ptSansRegular, size: emptyLabelFontSize)
        emptyLabel_MGRE.setLineHeight(emptyLabelLineHeight)
        emptyLabel_MGRE.text = LocalizationKeys.emptyCharactersMsg
        
        let createNewButtonTitleFontSize: CGFloat = device == .phone ? 20 : 34
        createNewCharacterButton_MGRE.titleLabel?.font =
            UIFont(name: StringConstants.ptSansRegular,
                   size: createNewButtonTitleFontSize)
        createNewCharacterButton_MGRE.setTitleColor(.black, for: .normal)
    }
    
    private func configureLayout() {
        let buttonHeight: CGFloat = device == .phone ? 38 : 64.6
        let bottomInset = Helper.getBottomInset()
        let iphoneBottomConstraints: CGFloat = bottomInset == 0 ? 34 : 0

        let rightLeftButtonsLeading: CGFloat = device == .phone ? 19 : 81
        let createCharacterButtonWidth: CGFloat = device == .phone ? 224 : 380.8

        let bottomButtonsBottom: CGFloat = device == .phone ? -iphoneBottomConstraints : -40
        let characterImageHeight: CGFloat = device == .phone ? 531 : 918
        let characterImageWidth: CGFloat = device == .phone ? 309 : 535.5

        navigationView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            backgroundImageView_MGRE.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView_MGRE.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView_MGRE.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView_MGRE.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
            rightLeftButtonsStackView_MGRE.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rightLeftButtonsStackView_MGRE.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: rightLeftButtonsLeading),
            rightLeftButtonsStackView_MGRE.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightLeftButtonsLeading),
                
            // Character image size
            characterImageView_MGRE.heightAnchor.constraint(equalToConstant: characterImageHeight),
            characterImageView_MGRE.widthAnchor.constraint(equalToConstant: characterImageWidth),
                
            // Left and right buttons size
            rightButton_MGRE.heightAnchor.constraint(equalTo: leftButton_MGRE.heightAnchor),
            rightButton_MGRE.widthAnchor.constraint(equalTo: leftButton_MGRE.widthAnchor),
            
            leftButton_MGRE.heightAnchor.constraint(equalToConstant: buttonHeight),
            leftButton_MGRE.widthAnchor.constraint(equalToConstant: buttonHeight),
            
            emptyLabel_MGRE.centerXAnchor.constraint(equalTo: rightLeftButtonsStackView_MGRE.centerXAnchor),
            emptyLabel_MGRE.centerYAnchor.constraint(equalTo: rightLeftButtonsStackView_MGRE.centerYAnchor),
            
            bottomButtonsStackView_MGRE.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: bottomButtonsBottom),
            bottomButtonsStackView_MGRE.centerXAnchor.constraint(equalTo: backgroundImageView_MGRE.centerXAnchor),
                    
            createNewCharacterButton_MGRE.heightAnchor.constraint(equalToConstant: buttonHeight),
            createNewCharacterButton_MGRE.widthAnchor.constraint(equalToConstant: createCharacterButtonWidth),

            deleteButton_MGRE.heightAnchor.constraint(equalToConstant: buttonHeight),
            deleteButton_MGRE.widthAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
    
    private func updateCharImageView_MGRE() {
        navigationView.build_MGRE(with: "Editor", rightIcon: nil)
        
        if characters_MGRE.indices.contains(currentPage_MGRE) {
            characterImageView_MGRE.image = characters_MGRE[currentPage_MGRE].image
        } else {
            characterImageView_MGRE.image = nil
        }
        
        if characters_MGRE.isEmpty {
            leftButton_MGRE.isHidden = true
            rightButton_MGRE.isHidden = true
        } else {
            leftButton_MGRE.alpha = currentPage_MGRE == 0 ? 0 : 1
            rightButton_MGRE.alpha = currentPage_MGRE >= characters_MGRE.count-1 ? 0 : 1
        }
    }
    
    @objc private func imageTapped(_ gesture: UITapGestureRecognizer) {
        guard let editorContentSet = editorContentSet_MGRE,
              characters_MGRE.indices.contains(currentPage_MGRE) else { return }
        let vc = CharacterEditorViewController_MGRE()
        vc.editorContentSet_MGRE = editorContentSet
        vc.characterPreview_MGRE = characters_MGRE[currentPage_MGRE]
        vc.addNewCharAction_MGRE = { [weak self] character in
            self?.add_MGRE(character: character)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func createNewCharacterButtonTapped(_ sender: UIButton) {
        guard let editorContentSet = editorContentSet_MGRE else { return }
        showProgressView_MGRE()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.removeProgressView_MGRE()
            let vc = CharacterEditorViewController_MGRE()
            vc.editorContentSet_MGRE = editorContentSet
            vc.addNewCharAction_MGRE = { [weak self] character in
                self?.add_MGRE(character: character)
            }
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func add_MGRE(character: CharacterPreview_MGRE) {
        if let index = characters_MGRE.firstIndex(where: { $0.id == character.id }) {
            characters_MGRE[index] = character
        } else {
            characters_MGRE.append(character)
            let charactersCount = characters_MGRE.count
            currentPage_MGRE = charactersCount-1
        }
        emptyLabel_MGRE.isHidden = !characters_MGRE.isEmpty
        updateCharImageView_MGRE()
    }
    
    @objc private func deleteButtonDidTapped() {
        guard !characters_MGRE.isEmpty else { return }
        showSettingsCancelPopup_MGRE(title: LocalizationKeys.cancelAllSettings, onYes: { [weak self] in
            self?.deleteCharacter_MGRE()
        },
        onNo: nil)
    }
    
    private func deleteCharacter_MGRE() {
        guard !characters_MGRE.isEmpty, characters_MGRE.indices.contains(currentPage_MGRE) else { return }
        let character = characters_MGRE[currentPage_MGRE]
        dropbox_MGRE.contentManager.delete_MGRE(character: character)
        characters_MGRE.remove(at: currentPage_MGRE)
        emptyLabel_MGRE.isHidden = !characters_MGRE.isEmpty
        currentPage_MGRE = characters_MGRE.count > 0 ? characters_MGRE.count-1 : 0
        updateCharImageView_MGRE()
    }
    
    private func configureNavigationView_MGRE() {
        navigationView.build_MGRE(with: "Editor", rightIcon: characters_MGRE.isEmpty ? nil : UIImage(.deleteIcon))
        navigationView.leftButtonAction_MGRE = { [weak self] in
            self?.toggleMenuAction_MGRE?()
        }
    }
    
    @objc private func leftButtonTapped() {
        guard currentPage_MGRE > 0 else { return }
        currentPage_MGRE -= 1
        updateCharImageView_MGRE()
    }
    
    @objc private func rightButtonTapped() {
        guard currentPage_MGRE < characters_MGRE.count-1 else { return }
        currentPage_MGRE += 1
        updateCharImageView_MGRE()
    }
}

extension CharacterListViewController_MGRE {
    func loadCharacters_MGRE() {
        characters_MGRE = dropbox_MGRE.contentManager.fetchCharacters_MGRE()
        emptyLabel_MGRE.isHidden = !characters_MGRE.isEmpty
        updateCharImageView_MGRE()
    }
    
    func loadContent_MGRE() {
        dropbox_MGRE.fetchEditorContent_MGRE(vc: self) { [weak self] editorContentSet in
            DispatchQueue.main.async {
                self?.removeProgressView_MGRE()
                self?.editorContentSet_MGRE = editorContentSet
                self?.loadStartContent_MGRE()
            }
        }
    }
    
    func loadStartContent_MGRE() {
        editorContentSet_MGRE?.contentTypes.forEach { [weak self] type in
            if let model = self?.editorContentSet_MGRE?.getModels(for: type)?.first {
                UIImageView.uploadPDF_MGRE(image: "\(Keys_MGRE.ImagePath_MGRE.editor_mgre)\(model.path.pdfPath)")
            }
        }
    }
}
