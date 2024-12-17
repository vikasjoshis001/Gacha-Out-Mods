//
//  DropDownView_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

// MARK: - DropDownView_MGRE

class DropDownView_MGRE: UIView {
    @IBOutlet private var categoryLabel_MGRE: UILabel!
    @IBOutlet private var imageView_MGRE: UIImageView!
    @IBOutlet private var tableView_MGRE: UITableView!
    
    @IBOutlet private var categoryLabelHeight_MGRE: NSLayoutConstraint!
    @IBOutlet private var tableViewHeight_MGRE: NSLayoutConstraint!
    
    var isOpen_MGRE: Bool = false
    var categories_MGRE: [String] = []
    var selectedCategory_MGRE: String = ""
    var categoryDidChange_MGRE: ((String) -> Void)?
    let device = Helper.getDeviceType()
    
    
    private var overlayView: UIView?
    private var overlayTableView: UITableView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib_MGRE()
        configureLayout_MGRE()
        configureTableView_MGRE()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadViewFromNib_MGRE()
        configureLayout_MGRE()
        configureTableView_MGRE()
    }
    
    func configureTableView_MGRE() {
        tableView_MGRE.allowsMultipleSelection = false
        tableView_MGRE.registerNib_MGRE(for: DropDownCell_MGRE.self)
    }
    
    private func configureLayout_MGRE() {
        let fontSize: CGFloat = device == .phone ? 20 : 34
        
        categoryLabel_MGRE.font = UIFont(name: StringConstants.ptSansRegular, size: fontSize)!
        categoryLabelHeight_MGRE.constant = getButtonHeight()
        categoryLabel_MGRE.textColor = .black
        tableView_MGRE.isHidden = !isOpen_MGRE
        imageView_MGRE.tintColor = .black
        imageView_MGRE.image = isOpen_MGRE ? getDownChevron() : getUpChevron()
    }
    
    func closeView_MGRE() {
        isOpen_MGRE = false
        tableView_MGRE.isHidden = !isOpen_MGRE
        imageView_MGRE.image = isOpen_MGRE ? getDownChevron() : getUpChevron()
    }
    
    func setupDropDownView_MGRE(with categories: [String], selectedCategory: String) {
        categories_MGRE = categories
        selectedCategory_MGRE = selectedCategory
        
        let deviceType = UIDevice.current.userInterfaceIdiom
        tableViewHeight_MGRE.constant = CGFloat(Int(getButtonHeight()) * categories.count)
        categoryLabel_MGRE.text = selectedCategory.capitalized
        tableView_MGRE.reloadData()
    }
    
    @IBAction func openButtonDidTap_MGRE(_ sender: UIButton) {
        updateView_MGRE()
    }
    
    private func getButtonHeight() -> CGFloat {
        return device == .phone ? 38 : 64.6
    }
    
    private func getDownChevron() -> UIImage? {
//        return UIImage(named: Helper.deviceSpecificImage(image: StringConstants.Images.downChevron))
        return UIImage(.chevronBottomIcon)
    }
    
    private func getUpChevron() -> UIImage? {
//        return UIImage(named: Helper.deviceSpecificImage(image: StringConstants.Images.upChevron))
        return UIImage(.chevronTopIcon)

    }
    
    private func updateView_MGRE() {
        isOpen_MGRE.toggle()
        
        if isOpen_MGRE {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.delegate = self
            tableView.dataSource = self
            tableView.backgroundColor = .buttonBg
            tableView.layer.cornerRadius = 14
            tableView.registerNib_MGRE(for: DropDownCell_MGRE.self)
            
            if let window = window {
                window.addSubview(tableView)
                let globalPoint = convert(bounds, to: window)
                let tableHeight = CGFloat(categories_MGRE.count) * getButtonHeight()
                
                tableView.frame = CGRect(
                    x: globalPoint.minX,
                    y: globalPoint.minY - tableHeight - 8,
                    width: bounds.width,
                    height: tableHeight
                )
            }
            
            overlayTableView = tableView
        } else {
            overlayTableView?.removeFromSuperview()
            overlayTableView = nil
        }
        
        imageView_MGRE.image = isOpen_MGRE ? getDownChevron() : getUpChevron()
    }
    override func removeFromSuperview() {
        super.removeFromSuperview()
        tableView_MGRE?.removeFromSuperview()
    }
}

// MARK: UITableViewDataSource

extension DropDownView_MGRE: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories_MGRE.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DropDownCell_MGRE.identifier_MGRE, for: indexPath) as! DropDownCell_MGRE
        cell.buildCell_MGRE(with: categories_MGRE[indexPath.row])
        return cell
    }
}

// MARK: UITableViewDelegate

extension DropDownView_MGRE: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories_MGRE[indexPath.row]
        selectedCategory_MGRE = category
        categoryLabel_MGRE.text = category
        categoryDidChange_MGRE?(category)
        updateView_MGRE()
        closeView_MGRE()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getButtonHeight()
    }
}
