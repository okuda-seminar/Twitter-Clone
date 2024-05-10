import UIKit

class HomeTweetCollectionViewCell: UICollectionViewCell {
  public var tweet: TweetModel? {
    didSet {
      guard let tweet else { return }
      userNameLabel.text = tweet.userName
      userNameLabel.sizeToFit()
      bodyTextLabel.text = tweet.bodyText
      bodyTextLabel.sizeToFit()
      userIconButton.setImage(tweet.userIcon, for: .normal)
    }
  }

  public weak var delegate: HomeTweetCollectionViewCellDelegate?

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

  private let userNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    return label
  }()

  private let bodyTextLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpSubviews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpSubviews() {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.alignment = .fill

    let infoStackView = UIStackView()
    infoStackView.translatesAutoresizingMaskIntoConstraints = false
    infoStackView.axis = .vertical
    infoStackView.alignment = .leading

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

    let tapGestureRecognizer = UITapGestureRecognizer(
      target: self, action: #selector(didTapTweet))
    infoStackView.addGestureRecognizer(tapGestureRecognizer)
  }

  @objc
  private func didTapTweet() {
    self.delegate?.didTapTweet()
  }

  @objc
  private func notifyTapUserIconButton() {
    guard let tweet else { return }
    delegate?.didTapUserIconButton(userName: tweet.userName, profileIcon: tweet.userIcon)
  }
}

protocol HomeTweetCollectionViewCellDelegate: AnyObject {
  func didTapUserIconButton(userName: String, profileIcon: UIImage?)

  func didTapTweet()
}
