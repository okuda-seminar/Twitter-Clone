import UIKit

class HomeTweetCellView: UIView {

  public var tweet: TweetModel? {
    didSet {
      setUpSubviews()
    }
  }

  public weak var delegate: HomeTweetCellViewDelegate?

  public let userIconButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.contentMode = .scaleAspectFit
    button.contentHorizontalAlignment = .fill
    button.tintColor = .black
    return button
  }()

  private enum LayoutConstant {
    static let horizontalEdgePadding = 16.0
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpSubviews() {
    guard let tweet else { return }
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.alignment = .fill

    userIconButton.setImage(tweet.userIcon, for: .normal)

    let infoStackView = UIStackView()
    infoStackView.translatesAutoresizingMaskIntoConstraints = false
    infoStackView.axis = .vertical
    infoStackView.alignment = .leading

    let userNameLabel = UILabel()
    userNameLabel.translatesAutoresizingMaskIntoConstraints = false
    userNameLabel.text = tweet.userName
    userNameLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)

    let bodyTextLabel = UILabel()
    bodyTextLabel.translatesAutoresizingMaskIntoConstraints = false
    bodyTextLabel.text = tweet.bodyText
    bodyTextLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    bodyTextLabel.numberOfLines = 0
    bodyTextLabel.lineBreakMode = .byWordWrapping

    stackView.addArrangedSubview(userIconButton)
    stackView.addArrangedSubview(infoStackView)

    infoStackView.addArrangedSubview(userNameLabel)
    infoStackView.addArrangedSubview(bodyTextLabel)

    stackView.spacing = 10
    infoStackView.spacing = 5

    addSubview(stackView)

    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.leadingAnchor.constraint(
        equalTo: leadingAnchor, constant: LayoutConstant.horizontalEdgePadding),
      stackView.trailingAnchor.constraint(
        equalTo: trailingAnchor, constant: -LayoutConstant.horizontalEdgePadding),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor),

      bodyTextLabel.trailingAnchor.constraint(lessThanOrEqualTo: stackView.trailingAnchor),

      bottomAnchor.constraint(equalTo: bodyTextLabel.bottomAnchor),
    ])

    userIconButton.addAction(
      .init { _ in
        self.delegate?.didTapUserIconButton(userName: tweet.userName, profileIcon: tweet.userIcon)
      }, for: .touchUpInside)

    let tapGestureRecognizer = UITapGestureRecognizer(
      target: self, action: #selector(didTapTweet))
    infoStackView.addGestureRecognizer(tapGestureRecognizer)
  }

  @objc
  private func didTapTweet() {
    self.delegate?.didTapTweet()
  }
}

protocol HomeTweetCellViewDelegate: AnyObject {
  func didTapUserIconButton(userName: String, profileIcon: UIImage?)

  func didTapTweet()
}
