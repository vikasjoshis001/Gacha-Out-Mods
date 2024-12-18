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

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .menubarBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let yesButton: UIButton = {
        let button = UIButton()
        button.setTitle(LocalizationKeys.yes, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .buttonBg
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let noButton: UIButton = {
        let button = UIButton()
        button.setTitle(LocalizationKeys.no, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .buttonBg
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let device = Helper.getDeviceType()
    private var containerLeadingConstraint: NSLayoutConstraint?
    private var onYes: (() -> Void)?
    private var onNo: (() -> Void)?
    
    // MARK: - Lifecycle

    init(title: String, onYes: (() -> Void)? = nil, onNo: (() -> Void)? = nil) {
        super.init(frame: .zero)
        self.onYes = onYes
        self.onNo = onNo
        titleLabel.text = title
        configureView()
        setupView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        addGestureRecognizer(tapGesture)
        containerView.isUserInteractionEnabled = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods

    private func configureView() {
        let containerViewCornerRadius: CGFloat = device == .phone ? 20 : 34
        containerView.layer.cornerRadius = containerViewCornerRadius
        containerView.layer.maskedCorners = [.layerMaxXMaxYCorner]

        let titleLabelFontSize: CGFloat = device == .phone ? 30 : 51
        let titleLabelLineHeight: CGFloat = device == .phone ? 38.85 : 66.05

        titleLabel.font = UIFont(name: StringConstants.ptSansRegular, size: titleLabelFontSize)
        titleLabel.setLineHeight(titleLabelLineHeight)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        
        let buttonCornerRadius: CGFloat = device == .phone ? 14 : 23.8
        let buttonTitleFontSize: CGFloat = device == .phone ? 20 : 34
        yesButton.layer.cornerRadius = buttonCornerRadius
        noButton.layer.cornerRadius = buttonCornerRadius
        yesButton.titleLabel?.font = UIFont(name: StringConstants.ptSansRegular, size: buttonTitleFontSize)
        noButton.titleLabel?.font = UIFont(name: StringConstants.ptSansRegular, size: buttonTitleFontSize)
    }
    
    private func setupView() {
        let popupScreenWidth: CGFloat = device == .phone ? 0.5 : 0.5
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backgroundColor = .clear
        
        let buttonHeight: CGFloat = device == .phone ? 38 : 64.6
        let buttonWidth: CGFloat = device == .phone ? 86 : 146.2
        let buttonTop: CGFloat = device == .phone ? 23 : 39.1
        
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(yesButton)
        containerView.addSubview(noButton)
        
        containerLeadingConstraint = containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerLeadingConstraint!,
            containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * popupScreenWidth),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            yesButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: buttonTop),
            yesButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            yesButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            yesButton.widthAnchor.constraint(equalToConstant: buttonWidth),

            noButton.topAnchor.constraint(equalTo: yesButton.bottomAnchor, constant: buttonTop),
            noButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            noButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            noButton.widthAnchor.constraint(equalToConstant: buttonWidth),
        ])
        
        yesButton.addTarget(self, action: #selector(yesButtonTapped), for: .touchUpInside)
        noButton.addTarget(self, action: #selector(noButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Show Hide Dialog

    func show() {
        containerLeadingConstraint?.constant = -UIScreen.main.bounds.width
        layoutIfNeeded()
            
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            self.containerLeadingConstraint?.constant = 0
            self.layoutIfNeeded()
        }
    }

    func hide(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn]) {
            self.backgroundColor = .clear
            self.containerLeadingConstraint?.constant = -UIScreen.main.bounds.width
            self.layoutIfNeeded()
        } completion: { _ in
            self.removeFromSuperview()
            completion?()
        }
    }
    
    // MARK: - Actions

    @objc private func yesButtonTapped() {
        hide { [weak self] in
            self?.onYes?()
        }
    }
    
    @objc private func noButtonTapped() {
        hide { [weak self] in
            self?.onNo?()
        }
    }
    
    @objc private func backgroundTapped(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        if !containerView.frame.contains(location) {
            hide()
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
        
        popupView.show()
    }
}
