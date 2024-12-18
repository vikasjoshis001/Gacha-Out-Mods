//
//  CircularProgressView_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Vikas Joshi on 18/12/24.
//

import UIKit

// MARK: - CircularProgressView_MGRE

class CircularProgressView_MGRE: UIView {
    private let circleLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
        
    private func setupLayers() {
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
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.lineWidth = 1
        circleLayer.lineCap = .round
            
        // Black progress layer
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.black.cgColor
        progressLayer.lineWidth = 1
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0
            
        layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)
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
        
        circleLayer.path = circularPath.cgPath
        progressLayer.path = circularPath.cgPath
    }
        
    func updateProgress(_ progress: Float) {
        progressLayer.strokeEnd = CGFloat(progress)
    }
        
    func stopAnimation() {
        progressLayer.removeAllAnimations()
    }
}

// Extension for easy initialization
extension CircularProgressView_MGRE {
    static func create(in view: UIView, size: CGFloat = 50) -> CircularProgressView_MGRE {
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
