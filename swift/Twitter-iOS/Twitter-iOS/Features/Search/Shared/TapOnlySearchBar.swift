import UIKit

class TapOnlySearchBar: UIView {
  public weak var delegate: TapOnlySearchBarDelegate?

  public var text = "" {
    didSet {
      titleLabel.text = text
    }
  }

  private enum LayoutConstant {
    static let searchIconTrailingPadding = 4.0
  }

  private enum LocalizedString {
    static let title = String(localized: "Search")
  }

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = LocalizedString.title
    label.textColor = .lightGray
    return label
  }()

  private let searchIcon: UIImageView = {
    let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.tintColor = .lightGray
    return imageView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpSubviews()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpSubviews() {
    addSubview(titleLabel)
    addSubview(searchIcon)

    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

      searchIcon.trailingAnchor.constraint(
        equalTo: titleLabel.leadingAnchor, constant: -LayoutConstant.searchIconTrailingPadding),
      searchIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
    ])
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    delegate?.didTapSearchBar()
  }
}

protocol TapOnlySearchBarDelegate: AnyObject {
  func didTapSearchBar()
}
