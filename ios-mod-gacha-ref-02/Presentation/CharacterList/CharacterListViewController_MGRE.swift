//
//  CharacterListViewController_MGRE.swift
//  ios-mod-gacha
//
//  Created by Systems
//

import UIKit

// MARK: - CharacterListViewController_MGRE

class CharacterListViewController_MGRE: UIViewController {
    // MARK: - Properties

    @IBOutlet private var navigationView_MGRE: NavigationView_MGRE!
    @IBOutlet var imageView_MGRE: UIImageView!
    @IBOutlet var leftButton_MGRE: UIButton!
    @IBOutlet var rightButton_MGRE: UIButton!
    @IBOutlet var addNewButton_MGRE: UIButton!
    @IBOutlet var emptyLabel_MGRE: UILabel!
    @IBOutlet var addNewButtonTopConstraint_MGRE: NSLayoutConstraint!
    @IBOutlet var addNewButtonHeight_MGRE: NSLayoutConstraint!
    @IBOutlet var leftButtonHeight_MGRE: NSLayoutConstraint!
    @IBOutlet var rightButtonHeight_MGRE: NSLayoutConstraint!
    @IBOutlet var rightIndentConstraint_MGRE: NSLayoutConstraint!
    @IBOutlet var leftIndentConstraint_MGRE: NSLayoutConstraint!
    
    @IBOutlet var topConstraint_MGRE: NSLayoutConstraint!
    
    private var dropbox_MGRE: DBManager_MGRE { .shared }
    private var editorContentSet_MGRE: EditorContentSet_MGRE?
    private var characters_MGRE: [CharacterPreview_MGRE] = []
    private var currentPage_MGRE = 0
    
    var toggleMenuAction_MGRE: (() -> Void)?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var _ecvbyss: Int { 0 }
        var _wetgt: Bool { true }
        loadCharacters_MGRE()
        loadContent_MGRE()
        configureLayout_MGRE()
        configureNavigationView_MGRE()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Functions
    
    private func configureLayout_MGRE() {
        let deviceType = UIDevice.current.userInterfaceIdiom
        rightIndentConstraint_MGRE.constant = deviceType == .phone ? 20 : 85
        leftIndentConstraint_MGRE.constant = deviceType == .phone ? 20 : 85
        topConstraint_MGRE.constant = deviceType == .phone ? 58 : 97
        leftButtonHeight_MGRE.constant = deviceType == .phone ? 64 : 80
        rightButtonHeight_MGRE.constant = deviceType == .phone ? 64 : 80
        addNewButtonTopConstraint_MGRE.constant = deviceType == .phone ? -16 : -43
        
        rightButton_MGRE.layer.cornerRadius = deviceType == .phone ? 32 : 40
        leftButton_MGRE.layer.cornerRadius = deviceType == .phone ? 32 : 40
        
        let fontSize: CGFloat = deviceType == .phone ? 20 : 32
        addNewButton_MGRE.titleLabel?.font = UIFont(name: StringConstants.ptSansRegular, size: fontSize)!
        addNewButtonHeight_MGRE.constant = deviceType == .phone ? 58 : 72
        addNewButton_MGRE.layer.cornerRadius = deviceType == .phone ? 29 : 36
        
        let emptyLabelFontSize: CGFloat = deviceType == .phone ? 24 : 32
        emptyLabel_MGRE.font = UIFont(name: StringConstants.ptSansRegular, size: emptyLabelFontSize)!
        emptyLabel_MGRE.text = "You haven't created any\ncharacters yet"
    }
    
    private func updateCharImageView_MGRE() {
        navigationView_MGRE.build_MGRE(with: "Editor", rightIcon: characters_MGRE.isEmpty ? nil : UIImage(.deleteIcon))
        
        if characters_MGRE.indices.contains(currentPage_MGRE) {
            imageView_MGRE.image = characters_MGRE[currentPage_MGRE].image
        } else {
            imageView_MGRE.image = nil
        }
        
        if characters_MGRE.isEmpty {
            leftButton_MGRE.isHidden = true
            rightButton_MGRE.isHidden = true
        } else {
            leftButton_MGRE.isHidden = currentPage_MGRE == 0 ? true : false
            rightButton_MGRE.isHidden = currentPage_MGRE >= characters_MGRE.count-1 ? true : false
        }
    }
    
    @IBAction func imageTapped_MGRE(_ sender: UIButton) {
        guard let editorContentSet = editorContentSet_MGRE,
              characters_MGRE.indices.contains(currentPage_MGRE) else { return }
        let vc = CharacterEditorViewController_MGRE.loadFromNib_MGRE()
        vc.editorContentSet_MGRE = editorContentSet
        vc.characterPreview_MGRE = characters_MGRE[currentPage_MGRE]
        vc.addNewCharAction_MGRE = { [weak self] character in
            self?.add_MGRE(character: character)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addNewButtonDidTap_MGRE(_ sender: UIButton) {
        guard let editorContentSet = editorContentSet_MGRE else { return }
        showProgressView_MGRE()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.removeProgressView_MGRE()
            let vc = CharacterEditorViewController_MGRE.loadFromNib_MGRE()
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
    
    private func deleteButtonDidTap_MGRE() {
        guard !characters_MGRE.isEmpty else { return }
        let alertData = AlertData_MGRE(with: "ARE YOU CERTAIN?",
                                       subtitle: "You want to erase your character?",
                                       leftBtnText: "NO",
                                       rightBtnText: "Delete")
        { [weak self] in
            self?.deleteCharacter_MGRE()
        }
        showAlert_MGRE(with: alertData)
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
        navigationView_MGRE.build_MGRE(with: "Editor", rightIcon: characters_MGRE.isEmpty ? nil : UIImage(.deleteIcon))
        navigationView_MGRE.rightButtonAction_MGRE = { [weak self] in
            self?.deleteButtonDidTap_MGRE()
        }
        navigationView_MGRE.leftButtonAction_MGRE = { [weak self] in
            self?.toggleMenuAction_MGRE?()
        }
    }
    
    @IBAction func leftButtonDidTap_MGRE(_ sender: UIButton) {
        guard currentPage_MGRE > 0 else { return }
        currentPage_MGRE -= 1
        updateCharImageView_MGRE()
    }
    
    @IBAction func rightButtonDidTap_MGRE(_ sender: UIButton) {
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
