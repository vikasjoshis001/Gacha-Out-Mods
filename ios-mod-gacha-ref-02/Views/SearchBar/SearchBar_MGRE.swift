//
//  SearchBar_MGRE.swift
//  ios-mod-gacha
//
//  Created by Systems
//

import UIKit

class SearchBar_MGRE: UIView {
    
    @IBOutlet weak var searchTextField_MGRE: UITextField!
    @IBOutlet private weak var searchView_MGRE: UIView!
    @IBOutlet private weak var resultView_MGRE: UIView!
    @IBOutlet private weak var resultTableView_MGRE: UITableView!
    
    @IBOutlet private weak var bottomViewHeight_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var searchViewHeight_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var resultViewHeight_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var rightIndentConstraint_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var leftIndentConstraint_MGRE: NSLayoutConstraint!
    @IBOutlet weak var searchIconHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchIconImageView: UIImageView!
    @IBOutlet weak var searchIconLeadingConstraint: NSLayoutConstraint!
    
    private let device = Helper.getDeviceType()
    
    var textDidChange_MGRE: ((String?) -> Void)?
    var results_MGRE: [String] = []
    var dismiss_MGRE: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib_MGRE()
        setupViews_MGRE()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadViewFromNib_MGRE()
        setupViews_MGRE()
    }
    
    private func setupViews_MGRE() {
        resultView_MGRE.addShadow_MGRE(with: UIColor(red: 0.887, green: 0.887, blue: 0.887, alpha: 1))
        
        searchTextField_MGRE.addTarget(self, action: #selector(textFieldDidChange_MGRE), for: .editingChanged)
        searchView_MGRE.layer.borderWidth = device == .phone ? 1 : 1.7
        searchView_MGRE.layer.borderColor = UIColor.black.cgColor
        configureLayout_MGRE()
        configureTableView_MGRE()
    }
    
    private func configureLayout_MGRE() {
        let deviceType = UIDevice.current.userInterfaceIdiom
        rightIndentConstraint_MGRE.constant = deviceType == .phone ? 32 : 180
        leftIndentConstraint_MGRE.constant = deviceType == .phone ? 33 : 180
        searchIconLeadingConstraint.constant = deviceType == .phone ? 4 : 6.8
        
        let fontSize: CGFloat = deviceType == .phone ? 14 : 23.8
        let lineHeight: CGFloat = deviceType == .phone ? 18.2 : 30.94
        searchTextField_MGRE.font = UIFont(name: StringConstants.ptSansRegular, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
        searchTextField_MGRE.setLineHeight(lineHeight)
        
        searchIconImageView.image = UIImage(named: Helper.deviceSpecificImage(image: StringConstants.Images.search))
        searchIconHeightConstraint.constant = deviceType == .phone ? 20 : 34
        
        bottomViewHeight_MGRE.constant = deviceType == .phone ? 58 : 97
        searchViewHeight_MGRE.constant = deviceType == .phone ? 25 : 42.5
        searchView_MGRE.layer.cornerRadius = deviceType == .phone ? 12.5 : 21.3

        resultView_MGRE.layer.cornerRadius = 18
        resultView_MGRE.layer.masksToBounds = true
        resultViewHeight_MGRE.constant = 0
    }
    
    func configureTableView_MGRE() {
        resultTableView_MGRE.separatorStyle = .none
        resultTableView_MGRE.allowsMultipleSelection = false
        resultTableView_MGRE.registerNib_MGRE(for: DropDownCell_MGRE.self)
    }
    
    func updateResultView_MGRE(with results: [String]) {
        self.results_MGRE = results
        let deviceType = UIDevice.current.userInterfaceIdiom
        let height: CGFloat = deviceType == .phone ? 48 : 63
        resultViewHeight_MGRE.constant = height * CGFloat(results.count)
        resultTableView_MGRE.reloadData()
    }
    
    @objc
    private func textFieldDidChange_MGRE(_ textField: UITextField) {
        textDidChange_MGRE?(textField.text)
    }
    
    @IBAction func dismissButtonDidTap_MGRE(_ sender: UIButton) {
        textDidChange_MGRE?(nil)
        searchTextField_MGRE.text = nil
        updateResultView_MGRE(with: [])
        searchTextField_MGRE.resignFirstResponder()
        dismiss_MGRE?()
    }
}

extension SearchBar_MGRE: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SearchBar_MGRE: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results_MGRE.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DropDownCell_MGRE.identifier_MGRE, for: indexPath) as! DropDownCell_MGRE
        cell.buildCell_MGRE(with: results_MGRE[indexPath.row], titleColor: UIColor(red: 0.304, green: 0.304, blue: 0.304, alpha: 1))
        return cell
    }
}

extension SearchBar_MGRE: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = results_MGRE[indexPath.row]
        searchTextField_MGRE.text = category
        textDidChange_MGRE?(category)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let deviceType = UIDevice.current.userInterfaceIdiom
        return deviceType == .phone ? 48 : 63
    }
}
