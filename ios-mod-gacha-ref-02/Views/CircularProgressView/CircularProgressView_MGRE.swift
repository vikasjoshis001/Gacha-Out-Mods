//
//  CircularProgressView_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Vikas Joshi on 18/12/24.
//

import UIKit

// MARK: - CircularProgressView_MGRE

class CircularProgressView_MGRE: UIView {
    private let circleLayer_MGRE = CAShapeLayer()
    private let progressLayer_MGRE = CAShapeLayer()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers_MGRE()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers_MGRE()
    }
        
    private func setupLayers_MGRE() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) * 0.4
        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + (2 * CGFloat.pi)
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: radius,
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: true)
            
        // White border circle
        circleLayer_MGRE.path = circularPath.cgPath
        circleLayer_MGRE.fillColor = UIColor.clear.cgColor
        circleLayer_MGRE.strokeColor = UIColor.white.cgColor
        circleLayer_MGRE.lineWidth = 1
        circleLayer_MGRE.lineCap = .round
            
        // Black progress layer
        progressLayer_MGRE.path = circularPath.cgPath
        progressLayer_MGRE.fillColor = UIColor.clear.cgColor
        progressLayer_MGRE.strokeColor = UIColor.black.cgColor
        progressLayer_MGRE.lineWidth = 1
        progressLayer_MGRE.lineCap = .round
        progressLayer_MGRE.strokeEnd = 0
            
        layer.addSublayer(circleLayer_MGRE)
        layer.addSublayer(progressLayer_MGRE)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Update paths when frame changes
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) * 0.4
        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + (2 * CGFloat.pi)
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: radius,
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: true)
        
        circleLayer_MGRE.path = circularPath.cgPath
        progressLayer_MGRE.path = circularPath.cgPath
    }
        
    func updateProgress_MGRE(_ progress: Float) {
        progressLayer_MGRE.strokeEnd = CGFloat(progress)
    }
        
    func stopAnimation_MGRE() {
        progressLayer_MGRE.removeAllAnimations()
    }
}

// Extension for easy initialization
extension CircularProgressView_MGRE {
    static func create_MGRE(in view: UIView, size: CGFloat = 50) -> CircularProgressView_MGRE {
        let progressView = CircularProgressView_MGRE(frame: CGRect(x: 0, y: 0, width: size, height: size))
        progressView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            progressView.widthAnchor.constraint(equalToConstant: size),
            progressView.heightAnchor.constraint(equalToConstant: size)
        ])
        
        return progressView
    }
}
