//
//  UIViewController+ProgressView_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import UIKit

fileprivate struct ProgressViewConstants_MGRE {
    static var overlayTag_MGRE: Int { return 999999 }
}

class ProgressView_MGRE: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI_MGRE()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI_MGRE()
    }
    
    private func setupUI_MGRE() {
        let customView = UIView()
        customView.backgroundColor = .background
        customView.layer.cornerRadius = 24
        customView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(customView)
        
        NSLayoutConstraint.activate([
            customView.centerXAnchor.constraint(equalTo: centerXAnchor),
            customView.centerYAnchor.constraint(equalTo: centerYAnchor),
            customView.widthAnchor.constraint(equalToConstant: 230),
            customView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        let label = UILabel()
        label.text = "Loading...."
        label.textColor = .blackText
        let deviceType = UIDevice.current.userInterfaceIdiom
        let titleFontSize: CGFloat = deviceType == .phone ? 22 : 32
        label.font = UIFont(name: "BakbakOne-Regular", size: titleFontSize)!
        label.translatesAutoresizingMaskIntoConstraints = false
        customView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: customView.centerXAnchor),
            label.topAnchor.constraint(equalTo: customView.topAnchor, constant: 24),
            label.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -24),
            label.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
}

extension UIViewController_MGRE {
    func showProgressView_MGRE() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        if let window = windowScene.windows.first {
            let progressView: UIView
            
            let overlayView = ProgressView_MGRE()
            overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            overlayView.translatesAutoresizingMaskIntoConstraints = false
            overlayView.tag = ProgressViewConstants_MGRE.overlayTag_MGRE
            progressView = overlayView
            
            window.addSubview(progressView)
            
            NSLayoutConstraint.activate([
                progressView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
                progressView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
                progressView.topAnchor.constraint(equalTo: window.topAnchor),
                progressView.bottomAnchor.constraint(equalTo: window.bottomAnchor)
            ])
        }
    }
    
    func removeProgressView_MGRE() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                if let overlayView = window.viewWithTag(ProgressViewConstants_MGRE.overlayTag_MGRE) {
                    overlayView.removeFromSuperview()
                }
            }
        }
    }
}
