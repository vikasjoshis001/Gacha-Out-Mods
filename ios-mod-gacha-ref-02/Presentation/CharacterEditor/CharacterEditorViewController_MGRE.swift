//
//  CharacterEditorViewController_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Vikas Joshi on 17/12/24.
//

import UIKit

// MARK: - CharacterEditorViewController_MGRE

class CharacterEditorViewController_MGRE: UIViewController {
    // MARK: - Properties

    private var characterImageView_MGRE: CharacterEditorImage_MGRE!
    
    private let backgroundImageView_MGRE: UIImageView = {
        let backgroundImageView = UIImageView(image: UIImage(named: Helper.deviceSpecificImage(image: StringConstants.Images.editorBackground)))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.isUserInteractionEnabled = true
        return backgroundImageView
    }()
    
    private let buttonsStackView_MGRE: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.masksToBounds = true
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private let bottomView_MGRE: UIView = {
        let view = UIView()
        view.backgroundColor = .appBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let resetButton_MGRE = CharacterEditorViewController_MGRE.makeActionButton_MGRE(image: StringConstants.Images.reset)
    
    private let doneButton_MGRE = CharacterEditorViewController_MGRE.makeActionButton_MGRE(image: StringConstants.Images.done)
        
    private var dropDownView_MGRE: DropDownView_MGRE!
    private var contentCollectionView_MGRE: UICollectionView!
    private let navigationView_MGRE = NavigationView_MGRE()
    private let device = Helper.getDeviceType()
    
    typealias ContentDataSource_MGRE = UICollectionViewDiffableDataSource<Int, EditorContentModel_MGRE>
    typealias ContentSnapshot_MGRE = NSDiffableDataSourceSnapshot<Int, EditorContentModel_MGRE>
    
    private var dropbox_MGRE: DBManager_MGRE { .shared }
    var editorContentSet_MGRE: EditorContentSet_MGRE!
    var characterPreview_MGRE: CharacterPreview_MGRE?
    
    private var categories_MGRE: [String] = []
    private var selectedCategory_MGRE: String = "body"
    
    private var contentDataSource_MGRE: ContentDataSource_MGRE?
    private var contentModels_MGRE: [EditorContentModel_MGRE] = []
    
    var addNewCharAction_MGRE: ((CharacterPreview_MGRE) -> Void)?
    var actionСache_MGRE: [(type: String,
                            action: (old: String?,
                                     new: String?))] = []
    
    var toggleMenuAction_MGRE: (() -> Void)?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews_MGRE()
        setupViewHierarchy_MGRE()
        configureCell_MGRE()
        configureLayout_MGRE()
        configureNavigationView_MGRE()
        configureSubviews_MGRE()
        configureContentDataSource_MGRE()
        configureModels_MGRE()
        addActionsToButton_MGRE()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var _msvby: Int { 0 }
        var _m2344ff: Bool { true }
        
        characterImageView_MGRE.updateImage_MGRE()
    }
    
    // MARK: - Private methods

    private func configureCell_MGRE() {
        buttonsStackView_MGRE.spacing = device == .phone ? 63 : 107.1
        let buttonCornerRadius: CGFloat = device == .phone ? 14 : 23.8
        resetButton_MGRE.layer.cornerRadius = buttonCornerRadius
        doneButton_MGRE.layer.cornerRadius = buttonCornerRadius
        dropDownView_MGRE.layer.cornerRadius = buttonCornerRadius
        
        bottomView_MGRE.backgroundColor = .appBackground
        bottomView_MGRE.layer.cornerRadius = device == .phone ? 20 : 34
    }

    private func initializeViews_MGRE() {
        // Initialize CharacterEditorImage
        characterImageView_MGRE = CharacterEditorImage_MGRE()
        characterImageView_MGRE.translatesAutoresizingMaskIntoConstraints = false
        characterImageView_MGRE.contentMode = .scaleAspectFit
        
        // Initialize DropDownView
        dropDownView_MGRE = DropDownView_MGRE()
        dropDownView_MGRE.translatesAutoresizingMaskIntoConstraints = false
        
        // Initialize CollectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        contentCollectionView_MGRE = UICollectionView(frame: .zero, collectionViewLayout: layout)
        contentCollectionView_MGRE.backgroundColor = .clear
        contentCollectionView_MGRE.showsHorizontalScrollIndicator = false
        contentCollectionView_MGRE.translatesAutoresizingMaskIntoConstraints = false
        
        // Initialize NavigationView
        navigationView_MGRE.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureSubviews_MGRE() {
        var _etyyss: Int { 0 }
        var _mxcgt: Bool { true }
        configureCharacterEditorImage_MGRE()
        configureCollectionView_MGRE()
    }
    
    func addActionsToButton_MGRE() {
        resetButton_MGRE.addTarget(self, action: #selector(undoButtonDidTap_MGRE), for: .touchUpInside)
        doneButton_MGRE.addTarget(self, action: #selector(doneButtonDidTap_MGRE), for: .touchUpInside)
    }
    
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
    
    private func setupViewHierarchy_MGRE() {
        view.addSubview(backgroundImageView_MGRE)
        
        backgroundImageView_MGRE.addSubview(navigationView_MGRE)
        backgroundImageView_MGRE.addSubview(characterImageView_MGRE)
        backgroundImageView_MGRE.addSubview(buttonsStackView_MGRE)
        backgroundImageView_MGRE.addSubview(bottomView_MGRE)
        
        buttonsStackView_MGRE.addArrangedSubview(resetButton_MGRE)
        buttonsStackView_MGRE.addArrangedSubview(dropDownView_MGRE)
        buttonsStackView_MGRE.addArrangedSubview(doneButton_MGRE)
        
        bottomView_MGRE.addSubview(contentCollectionView_MGRE)
        
        backgroundImageView_MGRE.bringSubviewToFront(dropDownView_MGRE)
    }
    
    private func configureLayout_MGRE() {
        let bottomViewHeight: CGFloat = device == .phone ? 130 : 204
        let buttonStackViewHeight: CGFloat = device == .phone ? 38 : 64.6
        let buttonStackViewBottomConstraint: CGFloat = device == .phone ? 8 : 13.4
        let characterImageViewWidth: CGFloat = device == .phone ? 309 : 535.5
        let dropdownViewHeight: CGFloat = device == .phone ? 150 : 236.3
        
        let characterImagePadding: CGFloat = device == .phone ? 8 : 24
        
        let availableHeight = view.bounds.height -
            navigationView_MGRE.frame.maxY -
            buttonsStackView_MGRE.frame.height

        let characterImageViewHeight = availableHeight * 0.6

        NSLayoutConstraint.activate([
            backgroundImageView_MGRE.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView_MGRE.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView_MGRE.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView_MGRE.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            navigationView_MGRE.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView_MGRE.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView_MGRE.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            bottomView_MGRE.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView_MGRE.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView_MGRE.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView_MGRE.heightAnchor.constraint(equalToConstant: bottomViewHeight),

            // Collection view constraints
            contentCollectionView_MGRE.topAnchor.constraint(equalTo: bottomView_MGRE.topAnchor),
            contentCollectionView_MGRE.leadingAnchor.constraint(equalTo: bottomView_MGRE.leadingAnchor),
            contentCollectionView_MGRE.trailingAnchor.constraint(equalTo: bottomView_MGRE.trailingAnchor),
            contentCollectionView_MGRE.bottomAnchor.constraint(equalTo: bottomView_MGRE.bottomAnchor),
            
            characterImageView_MGRE.bottomAnchor.constraint(greaterThanOrEqualTo: buttonsStackView_MGRE.topAnchor, constant: -characterImagePadding),
            characterImageView_MGRE.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterImageView_MGRE.widthAnchor.constraint(equalToConstant: characterImageViewWidth),
            characterImageView_MGRE.heightAnchor.constraint(equalToConstant: characterImageViewHeight),
            
            buttonsStackView_MGRE.centerXAnchor.constraint(equalTo: backgroundImageView_MGRE.centerXAnchor),
            buttonsStackView_MGRE.bottomAnchor.constraint(equalTo: bottomView_MGRE.topAnchor, constant: -buttonStackViewBottomConstraint),
                    
            // Add these new constraints
            resetButton_MGRE.heightAnchor.constraint(equalToConstant: buttonStackViewHeight),
            resetButton_MGRE.widthAnchor.constraint(equalToConstant: buttonStackViewHeight),
                    
            doneButton_MGRE.heightAnchor.constraint(equalToConstant: buttonStackViewHeight),
            doneButton_MGRE.widthAnchor.constraint(equalToConstant: buttonStackViewHeight),
                    
            // Drop down view constraints
            dropDownView_MGRE.widthAnchor.constraint(equalToConstant: dropdownViewHeight)
        ])
    }
    
    private func configureNavigationView_MGRE() {
        navigationView_MGRE.build_MGRE(with: "Editor", rightIcon: nil)
        navigationView_MGRE.leftButtonAction_MGRE = { [weak self] in
            self?.toggleMenuAction_MGRE?()
        }
    }
    
    func configureCollectionView_MGRE() {
        if let flowLayout = contentCollectionView_MGRE.collectionViewLayout as? UICollectionViewFlowLayout {
            let deviceType = UIDevice.current.userInterfaceIdiom
            let sectionInset = deviceType == .phone ? LayoutConfig_MGRE.defaultPhoneInsets : LayoutConfig_MGRE.defaultPadInsets
            flowLayout.sectionInset = sectionInset
            flowLayout.minimumInteritemSpacing = 16
        }
        contentCollectionView_MGRE.registerNib_MGRE(for: ContentCharacterCell_MGRE.self)
        contentCollectionView_MGRE.delegate = self
    }
    
    func configureCharacterEditorImage_MGRE() {
        if let preview = characterPreview_MGRE,
           let characterModel = CharacterModel_MGRE(from: preview, set: editorContentSet_MGRE)
        {
            characterImageView_MGRE.setupCharacter_MGRE(with: characterModel, contentSet: editorContentSet_MGRE, isNew: false)
        } else if let body = editorContentSet_MGRE.getModels(for: "body")?.first {
            let characterModel = CharacterModel_MGRE(content: [body])
            characterImageView_MGRE.setupCharacter_MGRE(with: characterModel, contentSet: editorContentSet_MGRE, isNew: true)
        }
    }
    
    private func configureDropDownView_MGRE() {
        dropDownView_MGRE.categoryDidChange_MGRE = { [weak self] category in
            guard let `self` = self,
                  category != self.selectedCategory_MGRE else { return }
            let categoryType = category
            self.contentModels_MGRE = self.editorContentSet_MGRE?.getModels(for: categoryType) ?? []
            self.selectedCategory_MGRE = categoryType
            self.applyContentSnapshot_MGRE()
        }
        dropDownView_MGRE.setupDropDownView_MGRE(with: categories_MGRE, selectedCategory: selectedCategory_MGRE)
    }
    
    func configureContentDataSource_MGRE() {
        contentDataSource_MGRE = ContentDataSource_MGRE(collectionView: contentCollectionView_MGRE) { collectionView, indexPath, model in
            guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: ContentCharacterCell_MGRE.identifier_MGRE,
                                     for: indexPath) as? ContentCharacterCell_MGRE else { return UICollectionViewCell() }
            if model.id == "DeleteButton" {
                cell.configure_MGRE(with: UIImage(.deleteLargeIcon) ?? UIImage())
            } else {
                cell.configure_MGRE(with: model)
            }
            return cell
        }
    }
    
    func applyContentSnapshot_MGRE() {
        var snapshot = ContentSnapshot_MGRE()
        snapshot.appendSections([.zero])
        
        if selectedCategory_MGRE.lowercased() != "accessory" &&
            selectedCategory_MGRE.lowercased() != "shoes" &&
            selectedCategory_MGRE.lowercased() != "eyebrow" &&
            selectedCategory_MGRE.lowercased() != "nose" &&
            selectedCategory_MGRE.lowercased() != "mouth" &&
            selectedCategory_MGRE.lowercased() != "top" &&
            selectedCategory_MGRE.lowercased() != "body" &&
            selectedCategory_MGRE.lowercased() != "eyes" &&
            selectedCategory_MGRE.lowercased() != "bottom" &&
            selectedCategory_MGRE.lowercased() != "hair"
        {
            let buttonModel = EditorContentModel_MGRE(id: "DeleteButton",
                                                      contentType: selectedCategory_MGRE,
                                                      order: "0", path: "", preview: "")
            snapshot.appendItems([buttonModel] + contentModels_MGRE, toSection: .zero)
        } else {
            snapshot.appendItems(contentModels_MGRE)
        }
        
        DispatchQueue.main.async {
            let selectedIndexPath: IndexPath
            if let content = self.characterImageView_MGRE.getContent_MGRE(for: self.selectedCategory_MGRE) {
                let selectedIndex = self.contentModels_MGRE.firstIndex(of: content) ?? 0
                
                let isBody = self.selectedCategory_MGRE.lowercased() != "accessory" ||
                    self.selectedCategory_MGRE.lowercased() != "shoes" ||
                    self.selectedCategory_MGRE.lowercased() != "eyebrow" ||
                    self.selectedCategory_MGRE.lowercased() != "nose" ||
                    self.selectedCategory_MGRE.lowercased() != "mouth" ||
                    self.selectedCategory_MGRE.lowercased() != "top" ||
                    self.selectedCategory_MGRE.lowercased() != "body" ||
                    self.selectedCategory_MGRE.lowercased() != "eyes" ||
                    self.selectedCategory_MGRE.lowercased() != "bottom" ||
                    self.selectedCategory_MGRE.lowercased() != "hair"
                let index = isBody ? selectedIndex : selectedIndex + 1
                selectedIndexPath = IndexPath(item: index, section: 0)
            } else {
                selectedIndexPath = IndexPath(item: 0, section: 0)
            }
            self.contentDataSource_MGRE?.apply(snapshot, animatingDifferences: false)
            self.contentCollectionView_MGRE.reloadData()
            self.contentCollectionView_MGRE.selectItem(at: selectedIndexPath,
                                                       animated: false,
                                                       scrollPosition: .centeredHorizontally)
        }
    }
    
    func configureModels_MGRE() {
        let types = editorContentSet_MGRE.contentTypes
        
        categories_MGRE = types
        selectedCategory_MGRE = editorContentSet_MGRE.contentTypes.first ?? "body"
        
        contentModels_MGRE = editorContentSet_MGRE.getModels(for: selectedCategory_MGRE) ?? []
        
        applyContentSnapshot_MGRE()
        configureDropDownView_MGRE()
    }
    
    func backButtonDidTap_MGRE() {
        dropDownView_MGRE.closeView_MGRE()
        if actionСache_MGRE.isEmpty {
            navigationController?.popViewController(animated: true)
        } else {
            let alertData = AlertData_MGRE(with: "THINK TWICE",
                                           subtitle: "Exiting means discarding all modifications.",
                                           leftBtnText: "NO",
                                           rightBtnText: "Exit")
            { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            showAlert_MGRE(with: alertData)
        }
    }
    
    @objc func undoButtonDidTap_MGRE() {
        guard let lastAction = actionСache_MGRE.last else { return }
        dropDownView_MGRE.closeView_MGRE()
        let models = editorContentSet_MGRE.getModels(for: lastAction.type) ?? []
        
        if let old = lastAction.action.old,
           let model = models.first(where: { $0.id == old })
        {
            characterImageView_MGRE.changeStatus_MGRE(with: model)
        } else {
            characterImageView_MGRE.remove_MGRE(contentType: lastAction.type)
        }
        actionСache_MGRE.removeLast()
        
        selectedCategory_MGRE = lastAction.type
        dropDownView_MGRE.setupDropDownView_MGRE(with: categories_MGRE, selectedCategory: lastAction.type)
        contentModels_MGRE = editorContentSet_MGRE.getModels(for: lastAction.type) ?? []
        
        applyContentSnapshot_MGRE()
    }
    
    @objc func doneButtonDidTap_MGRE() {
        if let completeCharacterImage = characterImageView_MGRE.createCharacterToSave_MGRE() {
            guard let characterPreview = characterImageView_MGRE.preview_MGRE else {
                return
            }
           
            let savedCharacter = CharacterPreview_MGRE(
                id: characterPreview.id,
                contentData: completeCharacterImage.pngData() ?? Data(),
                content: characterPreview.content
            )
           
            // Close editor UI
            dropDownView_MGRE.closeView_MGRE()
           
            // Save to storage and trigger callback
            dropbox_MGRE.contentManager.store_MGRE(character: savedCharacter)
            addNewCharAction_MGRE?(savedCharacter)
           
            // Show character details screen
            let detailsViewController = CharacterViewController_MGRE()
            detailsViewController.characterImageView_MGRE.image = completeCharacterImage
            navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
}

// MARK: UICollectionViewDelegate

extension CharacterEditorViewController_MGRE: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath,
                                    at: .centeredHorizontally,
                                    animated: true)
        dropDownView_MGRE.closeView_MGRE()
        let old = characterImageView_MGRE.getContent_MGRE(for: selectedCategory_MGRE)?.id

        let isBody = selectedCategory_MGRE.lowercased() != "accessory" ||
            selectedCategory_MGRE.lowercased() != "shoes" ||
            selectedCategory_MGRE.lowercased() != "eyebrow" ||
            selectedCategory_MGRE.lowercased() != "nose" ||
            selectedCategory_MGRE.lowercased() != "mouth" ||
            selectedCategory_MGRE.lowercased() != "top" ||
            selectedCategory_MGRE.lowercased() != "body" ||
            selectedCategory_MGRE.lowercased() != "eyes" ||
            selectedCategory_MGRE.lowercased() != "bottom"

        if indexPath.item == 0 && !isBody {
            guard old != nil else { return }
            characterImageView_MGRE.remove_MGRE(contentType: selectedCategory_MGRE)
            actionСache_MGRE.append((selectedCategory_MGRE, (old, nil)))
        } else {
            let index = isBody ? indexPath.item : indexPath.item - 1
            let contentModel = contentModels_MGRE[index]
            
            guard old != contentModel.id else { return }
            characterImageView_MGRE.changeStatus_MGRE(with: contentModel)
            actionСache_MGRE.append((selectedCategory_MGRE, (old, contentModel.id)))
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension CharacterEditorViewController_MGRE: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let deviceType = UIDevice.current.userInterfaceIdiom
        let size: CGFloat = deviceType == .phone ? 92 : 138
        return CGSize(width: size, height: size)
    }
}
