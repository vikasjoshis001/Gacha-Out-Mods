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
    private let percentageLabel_MGRE: UILabel = {
        let label = UILabel()
        label.text = "0%"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let circularBackgroundView_MGRE: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.circularProgressBarBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let circularProgressView_MGRE: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // Shape Layers
    private let borderLayer_MGRE = CAShapeLayer()
    private let progressLayer_MGRE = CAShapeLayer()

    // MARK: - Properties
    private let constants: Constants
    var progress_MGRE: CGFloat = 0 {
        didSet {
            updateProgressView_MGRE()
        }
    }

    // MARK: - Initializers
    override init(frame: CGRect) {
        self.constants = Helper.getDeviceType_MGRE() == .phone ? Constants.iPhone : Constants.iPad
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupUI_MGRE()
    }

    required init?(coder: NSCoder) {
        self.constants = Helper.getDeviceType_MGRE() == .phone ? Constants.iPhone : Constants.iPad
        super.init(coder: coder)
        setupUI_MGRE()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout_MGRE()
    }

    // MARK: - Setup Methods
    private func setupUI_MGRE() {
        addSubview(circularProgressView_MGRE)
        circularProgressView_MGRE.addSubview(circularBackgroundView_MGRE)
        circularBackgroundView_MGRE.addSubview(percentageLabel_MGRE)

        configureUI_MGRE()
        configureLayers_MGRE()
    }

    private func configureUI_MGRE() {
        percentageLabel_MGRE.font = UIFont(name: StringConstants_MGRE.ptSansRegular, size: constants.labelFontSize)
        percentageLabel_MGRE.setLineHeight_MGRE(constants.labelLineHeight)
        percentageLabel_MGRE.setLetterSpacing_MGRE(constants.labelLetterSpacing)
        
        circularBackgroundView_MGRE.layer.cornerRadius = constants.backgroundCornerRadius
        
        circularProgressView_MGRE.layer.cornerRadius = constants.progressCornerRadius
    }

    private func configureLayers_MGRE() {
        let radius = constants.progressCornerRadius

        let circularPath = UIBezierPath(
            arcCenter: CGPoint(x: radius, y: radius),
            radius: radius,
            startAngle: -CGFloat.pi / 2,
            endAngle: 2 * CGFloat.pi - CGFloat.pi / 2,
            clockwise: true
        )

        borderLayer_MGRE.path = circularPath.cgPath
        borderLayer_MGRE.strokeColor = UIColor.circularProgressBarBackground.cgColor
        borderLayer_MGRE.lineWidth = 4
        borderLayer_MGRE.fillColor = UIColor.clear.cgColor
        borderLayer_MGRE.strokeEnd = 1

        progressLayer_MGRE.path = circularPath.cgPath
        progressLayer_MGRE.strokeColor = UIColor.buttonBg.cgColor
        progressLayer_MGRE.lineWidth = 4
        progressLayer_MGRE.fillColor = UIColor.clear.cgColor
        progressLayer_MGRE.strokeEnd = 0
        progressLayer_MGRE.lineCap = .round
        
        circularProgressView_MGRE.layer.addSublayer(borderLayer_MGRE)
        circularProgressView_MGRE.layer.addSublayer(progressLayer_MGRE)
    }

    private func updateProgressView_MGRE() {
        percentageLabel_MGRE.text = "\(Int(progress_MGRE * 100))%"
        progressLayer_MGRE.strokeEnd = progress_MGRE
        borderLayer_MGRE.strokeColor = progress_MGRE == 1.0 ? UIColor.buttonBg.cgColor : UIColor.circularProgressBarBackground.cgColor
    }

    private func setupLayout_MGRE() {
        NSLayoutConstraint.activate([
            percentageLabel_MGRE.widthAnchor.constraint(equalToConstant: constants.labelWidth),
            percentageLabel_MGRE.heightAnchor.constraint(equalToConstant: constants.labelHeight),
            percentageLabel_MGRE.centerXAnchor.constraint(equalTo: circularBackgroundView_MGRE.centerXAnchor),
            percentageLabel_MGRE.centerYAnchor.constraint(equalTo: circularBackgroundView_MGRE.centerYAnchor),

            circularBackgroundView_MGRE.widthAnchor.constraint(equalToConstant: constants.backgroundSize),
            circularBackgroundView_MGRE.heightAnchor.constraint(equalToConstant: constants.backgroundSize),
            circularBackgroundView_MGRE.centerXAnchor.constraint(equalTo: circularProgressView_MGRE.centerXAnchor),
            circularBackgroundView_MGRE.centerYAnchor.constraint(equalTo: circularProgressView_MGRE.centerYAnchor),

            circularProgressView_MGRE.widthAnchor.constraint(equalToConstant: constants.progressSize),
            circularProgressView_MGRE.heightAnchor.constraint(equalToConstant: constants.progressSize),
            circularProgressView_MGRE.centerXAnchor.constraint(equalTo: centerXAnchor),
            circularProgressView_MGRE.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
