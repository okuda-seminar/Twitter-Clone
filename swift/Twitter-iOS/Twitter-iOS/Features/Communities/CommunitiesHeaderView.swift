import UIKit

class CommunitiesHeaderView: UIView {
  private enum LocalizedString {
    static let title = String(localized: "Communities")
  }

  private enum LayoutConstant {
    static let profileIconButtonSize = 32.0
    static let searchButtonSize = 28.0
    static let searchButtonTrailingPadding = 16.0
  }

  private let profileIconButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "person.circle.fill"), for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.imageView?.contentMode = .scaleAspectFit
    button.contentHorizontalAlignment = .fill
    button.contentVerticalAlignment = .fill
    return button
  }()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = LocalizedString.title
    label.textColor = .black
    return label
  }()

  private let searchButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    button.contentHorizontalAlignment = .fill
    button.contentVerticalAlignment = .fill
    return button
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpSubviews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpSubviews() {
    addSubview(profileIconButton)
    addSubview(titleLabel)
    addSubview(searchButton)

    titleLabel.sizeToFit()

    NSLayoutConstraint.activate([
      profileIconButton.leadingAnchor.constraint(equalTo: leadingAnchor),
      profileIconButton.centerYAnchor.constraint(equalTo: centerYAnchor),
      profileIconButton.widthAnchor.constraint(equalToConstant: LayoutConstant.profileIconButtonSize),
      profileIconButton.heightAnchor.constraint(equalToConstant: LayoutConstant.profileIconButtonSize),

      titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

      searchButton.centerYAnchor.constraint(equalTo: centerYAnchor),
      searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutConstant.searchButtonTrailingPadding),
      searchButton.widthAnchor.constraint(equalToConstant: LayoutConstant.searchButtonSize),
      searchButton.heightAnchor.constraint(equalToConstant: LayoutConstant.searchButtonSize),
    ])
  }
}
