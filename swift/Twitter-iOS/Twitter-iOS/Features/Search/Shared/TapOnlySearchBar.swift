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
    label.textColor = .brandedLightGrayText
    return label
  }()

  private let searchIcon: UIImageView = {
    let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.tintColor = .brandedLightGrayText
    return imageView
  }()

  override var intrinsicContentSize: CGSize {
    return UIView.layoutFittingExpandedSize
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpSubviews()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpSubviews() {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .brandedLightGrayBackground
    addSubview(titleLabel)
    addSubview(searchIcon)

    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

      searchIcon.trailingAnchor.constraint(
        equalTo: titleLabel.leadingAnchor, constant: -LayoutConstant.searchIconTrailingPadding),
      searchIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
    ])

    let tapGestureRecognizer = UITapGestureRecognizer(
      target: self, action: #selector(propagateTapEventToDelegate))
    titleLabel.addGestureRecognizer(tapGestureRecognizer)
    searchIcon.addGestureRecognizer(tapGestureRecognizer)
    isUserInteractionEnabled = true
  }

  @objc
  private func propagateTapEventToDelegate() {
    delegate?.didTapSearchBar()
  }
}

protocol TapOnlySearchBarDelegate: AnyObject {
  func didTapSearchBar()
}
