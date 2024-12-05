import UIKit

class RoundProgressBar_MGRE: UIView {
    // MARK: - UI Elements
    
    private let percentageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont(name: StringConstants.ptSansRegular, size: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let circularBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.circularProgressBarBackground
        view.layer.cornerRadius = 32
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let circularProgressView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.cornerRadius = 40
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var progress: CGFloat = 0 {
        didSet {
            updateProgressView()
        }
    }
    
    // ShapeLayer for the circular progress border
    private let borderLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    // MARK: - Setup Methods
    
    private func setupUI() {
        addSubview(circularProgressView)
        circularProgressView.addSubview(circularBackgroundView)
        circularBackgroundView.addSubview(percentageLabel)
        
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: 40, y: 40),
                                        radius: 40,
                                        startAngle: -CGFloat.pi / 2,
                                        endAngle: 2 * CGFloat.pi - CGFloat.pi / 2,
                                        clockwise: true)
        
        // Set up the background border
        borderLayer.path = circularPath.cgPath
        borderLayer.strokeColor = UIColor.circularProgressBarBackground.cgColor
        borderLayer.lineWidth = 4
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeEnd = 1
        
        // Set up the progress stroke (pink color)
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = UIColor.buttonBg.cgColor
        progressLayer.lineWidth = 4
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeEnd = 0
        
        circularProgressView.layer.addSublayer(borderLayer)
        circularProgressView.layer.addSublayer(progressLayer)
    }
    
    private func updateProgressView() {
        percentageLabel.text = "\(Int(progress * 100))%"
        
        progressLayer.strokeEnd = progress
        
        if progress == 1.0 {
            borderLayer.strokeColor = UIColor.buttonBg.cgColor
        } else {
            borderLayer.strokeColor = UIColor.circularProgressBarBackground.cgColor
        }
    }
    
    // MARK: - Layout Setup
    
    private func setupLayout() {
        // Percentage Label
        NSLayoutConstraint.activate([
            percentageLabel.widthAnchor.constraint(equalToConstant: 42),
            percentageLabel.heightAnchor.constraint(equalToConstant: 18),
            percentageLabel.centerXAnchor.constraint(equalTo: circularBackgroundView.centerXAnchor),
            percentageLabel.centerYAnchor.constraint(equalTo: circularBackgroundView.centerYAnchor)
        ])
        
        // Circular Background View
        NSLayoutConstraint.activate([
            circularBackgroundView.centerXAnchor.constraint(equalTo: circularProgressView.centerXAnchor),
            circularBackgroundView.centerYAnchor.constraint(equalTo: circularProgressView.centerYAnchor),
            circularBackgroundView.widthAnchor.constraint(equalToConstant: 64),
            circularBackgroundView.heightAnchor.constraint(equalToConstant: 64)
        ])
        
        // Circular Progress View
        NSLayoutConstraint.activate([
            circularProgressView.widthAnchor.constraint(equalToConstant: 80),
            circularProgressView.heightAnchor.constraint(equalToConstant: 80),
            circularProgressView.centerXAnchor.constraint(equalTo: centerXAnchor),
            circularProgressView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
