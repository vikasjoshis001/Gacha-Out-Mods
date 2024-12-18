//
//  SettingsCancelView_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Vikas Joshi on 18/12/24.
//

import UIKit

// MARK: - SettingsCancelView_MGRE

class SettingsCancelView_MGRE: UIView {
    // MARK: - Properties

    private let containerView_MGRE: UIView = {
        let view = UIView()
        view.backgroundColor = .menubarBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel_MGRE: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let yesButton_MGRE: UIButton = {
        let button = UIButton()
        button.setTitle(LocalizationKeys.yes, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .buttonBg
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let noButton_MGRE: UIButton = {
        let button = UIButton()
        button.setTitle(LocalizationKeys.no, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .buttonBg
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let device = Helper.getDeviceType_MGRE()
    private var containerLeadingConstraint_MGRE: NSLayoutConstraint?
    private var onYes_MGRE: (() -> Void)?
    private var onNo_MGRE: (() -> Void)?
    
    // MARK: - Lifecycle

    init(title: String, onYes: (() -> Void)? = nil, onNo: (() -> Void)? = nil) {
        super.init(frame: .zero)
        self.onYes_MGRE = onYes
        self.onNo_MGRE = onNo
        titleLabel_MGRE.text = title
        configureView_MGRE()
        setupView_MGRE()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped_MGRE))
        addGestureRecognizer(tapGesture)
        containerView_MGRE.isUserInteractionEnabled = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods

    private func configureView_MGRE() {
        let containerViewCornerRadius: CGFloat = device == .phone ? 20 : 34
        containerView_MGRE.layer.cornerRadius = containerViewCornerRadius
        containerView_MGRE.layer.maskedCorners = [.layerMaxXMaxYCorner]

        let titleLabelFontSize: CGFloat = device == .phone ? 30 : 51
        let titleLabelLineHeight: CGFloat = device == .phone ? 38.85 : 66.05

        titleLabel_MGRE.font = UIFont(name: StringConstants_MGRE.ptSansRegular, size: titleLabelFontSize)
        titleLabel_MGRE.setLineHeight_MGRE(titleLabelLineHeight)
        titleLabel_MGRE.textColor = .black
        titleLabel_MGRE.textAlignment = .center
        
        let buttonCornerRadius: CGFloat = device == .phone ? 14 : 23.8
        let buttonTitleFontSize: CGFloat = device == .phone ? 20 : 34
        yesButton_MGRE.layer.cornerRadius = buttonCornerRadius
        noButton_MGRE.layer.cornerRadius = buttonCornerRadius
        yesButton_MGRE.titleLabel?.font = UIFont(name: StringConstants_MGRE.ptSansRegular, size: buttonTitleFontSize)
        noButton_MGRE.titleLabel?.font = UIFont(name: StringConstants_MGRE.ptSansRegular, size: buttonTitleFontSize)
    }
    
    private func setupView_MGRE() {
        let popupScreenWidth: CGFloat = device == .phone ? 0.5 : 0.5
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backgroundColor = .clear
        
        let buttonHeight: CGFloat = device == .phone ? 38 : 64.6
        let buttonWidth: CGFloat = device == .phone ? 86 : 146.2
        let buttonTop: CGFloat = device == .phone ? 23 : 39.1
        
        addSubview(containerView_MGRE)
        containerView_MGRE.addSubview(titleLabel_MGRE)
        containerView_MGRE.addSubview(yesButton_MGRE)
        containerView_MGRE.addSubview(noButton_MGRE)
        
        containerLeadingConstraint_MGRE = containerView_MGRE.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)

        NSLayoutConstraint.activate([
            containerView_MGRE.topAnchor.constraint(equalTo: topAnchor),
            containerLeadingConstraint_MGRE!,
            containerView_MGRE.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * popupScreenWidth),
            containerView_MGRE.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel_MGRE.centerYAnchor.constraint(equalTo: containerView_MGRE.centerYAnchor),
            titleLabel_MGRE.centerXAnchor.constraint(equalTo: containerView_MGRE.centerXAnchor),
            
            yesButton_MGRE.topAnchor.constraint(equalTo: titleLabel_MGRE.bottomAnchor, constant: buttonTop),
            yesButton_MGRE.centerXAnchor.constraint(equalTo: containerView_MGRE.centerXAnchor),
            yesButton_MGRE.heightAnchor.constraint(equalToConstant: buttonHeight),
            yesButton_MGRE.widthAnchor.constraint(equalToConstant: buttonWidth),

            noButton_MGRE.topAnchor.constraint(equalTo: yesButton_MGRE.bottomAnchor, constant: buttonTop),
            noButton_MGRE.centerXAnchor.constraint(equalTo: containerView_MGRE.centerXAnchor),
            noButton_MGRE.heightAnchor.constraint(equalToConstant: buttonHeight),
            noButton_MGRE.widthAnchor.constraint(equalToConstant: buttonWidth),
        ])
        
        yesButton_MGRE.addTarget(self, action: #selector(yesButtonTapped_MGRE), for: .touchUpInside)
        noButton_MGRE.addTarget(self, action: #selector(noButtonTapped_MGRE), for: .touchUpInside)
    }
    
    // MARK: - Show Hide Dialog

    func show_MGRE() {
        containerLeadingConstraint_MGRE?.constant = -UIScreen.main.bounds.width
        layoutIfNeeded()
            
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            self.containerLeadingConstraint_MGRE?.constant = 0
            self.layoutIfNeeded()
        }
    }

    func hide_MGRE(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn]) {
            self.backgroundColor = .clear
            self.containerLeadingConstraint_MGRE?.constant = -UIScreen.main.bounds.width
            self.layoutIfNeeded()
        } completion: { _ in
            self.removeFromSuperview()
            completion?()
        }
    }
    
    // MARK: - Actions

    @objc private func yesButtonTapped_MGRE() {
        hide_MGRE { [weak self] in
            self?.onYes_MGRE?()
        }
    }
    
    @objc private func noButtonTapped_MGRE() {
        hide_MGRE { [weak self] in
            self?.onNo_MGRE?()
        }
    }
    
    @objc private func backgroundTapped_MGRE(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        if !containerView_MGRE.frame.contains(location) {
            hide_MGRE()
        }
    }
}

// MARK: - Extension to show the settings cancel popup

extension UIViewController {
    func showSettingsCancelPopup_MGRE(title: String, onYes: (() -> Void)? = nil, onNo: (() -> Void)? = nil) {
        let popupView = SettingsCancelView_MGRE(title: title, onYes: onYes, onNo: onNo)
        popupView.frame = view.bounds
        popupView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(popupView)
        
        NSLayoutConstraint.activate([
            popupView.topAnchor.constraint(equalTo: view.topAnchor),
            popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            popupView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        popupView.show_MGRE()
    }
}
