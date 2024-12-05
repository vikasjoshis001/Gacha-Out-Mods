import UIKit

class RoundProgressBar_MGRE: UIView {
    // MARK: - Constants
    private struct Constants {
        let labelFontSize: CGFloat
        let labelLineHeight: CGFloat
        let labelLetterSpacing: CGFloat
        let backgroundCornerRadius: CGFloat
        let progressCornerRadius: CGFloat
        let labelWidth: CGFloat
        let labelHeight: CGFloat
        let backgroundSize: CGFloat
        let progressSize: CGFloat

        static let iPhone = Constants(
            labelFontSize: 16,
            labelLineHeight: 20,
            labelLetterSpacing: -0.5,
            backgroundCornerRadius: 32,
            progressCornerRadius: 40,
            labelWidth: 42,
            labelHeight: 18,
            backgroundSize: 64,
            progressSize: 80
        )

        static let iPad = Constants(
            labelFontSize: 27.2,
            labelLineHeight: 34,
            labelLetterSpacing: -0.85,
            backgroundCornerRadius: 54.4,
            progressCornerRadius: 68,
            labelWidth: 71.4,
            labelHeight: 30.6,
            backgroundSize: 108.8,
            progressSize: 136
        )
    }

    // MARK: - UI Elements
    private let percentageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let circularBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.circularProgressBarBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let circularProgressView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // Shape Layers
    private let borderLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()

    // MARK: - Properties
    private let constants: Constants
    var progress: CGFloat = 0 {
        didSet {
            updateProgressView()
        }
    }

    // MARK: - Initializers
    override init(frame: CGRect) {
        self.constants = Helper.getDeviceType() == .phone ? Constants.iPhone : Constants.iPad
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupUI()
    }

    required init?(coder: NSCoder) {
        self.constants = Helper.getDeviceType() == .phone ? Constants.iPhone : Constants.iPad
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

        configureUI()
        configureLayers()
    }

    private func configureUI() {
        percentageLabel.font = UIFont(name: StringConstants.ptSansRegular, size: constants.labelFontSize)
        percentageLabel.setLineHeight(constants.labelLineHeight)
        percentageLabel.setLetterSpacing(constants.labelLetterSpacing)
        
        circularBackgroundView.layer.cornerRadius = constants.backgroundCornerRadius
        
        circularProgressView.layer.cornerRadius = constants.progressCornerRadius
    }

    private func configureLayers() {
        let radius = constants.progressCornerRadius

        let circularPath = UIBezierPath(
            arcCenter: CGPoint(x: radius, y: radius),
            radius: radius,
            startAngle: -CGFloat.pi / 2,
            endAngle: 2 * CGFloat.pi - CGFloat.pi / 2,
            clockwise: true
        )

        borderLayer.path = circularPath.cgPath
        borderLayer.strokeColor = UIColor.circularProgressBarBackground.cgColor
        borderLayer.lineWidth = 4
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeEnd = 1

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
        borderLayer.strokeColor = progress == 1.0 ? UIColor.buttonBg.cgColor : UIColor.circularProgressBarBackground.cgColor
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            percentageLabel.widthAnchor.constraint(equalToConstant: constants.labelWidth),
            percentageLabel.heightAnchor.constraint(equalToConstant: constants.labelHeight),
            percentageLabel.centerXAnchor.constraint(equalTo: circularBackgroundView.centerXAnchor),
            percentageLabel.centerYAnchor.constraint(equalTo: circularBackgroundView.centerYAnchor),

            circularBackgroundView.widthAnchor.constraint(equalToConstant: constants.backgroundSize),
            circularBackgroundView.heightAnchor.constraint(equalToConstant: constants.backgroundSize),
            circularBackgroundView.centerXAnchor.constraint(equalTo: circularProgressView.centerXAnchor),
            circularBackgroundView.centerYAnchor.constraint(equalTo: circularProgressView.centerYAnchor),

            circularProgressView.widthAnchor.constraint(equalToConstant: constants.progressSize),
            circularProgressView.heightAnchor.constraint(equalToConstant: constants.progressSize),
            circularProgressView.centerXAnchor.constraint(equalTo: centerXAnchor),
            circularProgressView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
