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
    label.isUserInteractionEnabled = true
    label.sizeToFit()
    return label
  }()

  private let searchIcon: UIImageView = {
    let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.tintColor = .brandedLightGrayText
    imageView.isUserInteractionEnabled = true
    return imageView
  }()

  override var intrinsicContentSize: CGSize {
    return UIView.layoutFittingExpandedSize
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    // Need to call method here once to make layoutSubviews after frame size is fixed.
    setUpSubviews()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    setUpSubviews()
    let tapGestureRecognizer = UITapGestureRecognizer(
      target: self, action: #selector(propagateTapEventToDelegate))
    addGestureRecognizer(tapGestureRecognizer)
    titleLabel.addGestureRecognizer(tapGestureRecognizer)
    searchIcon.addGestureRecognizer(tapGestureRecognizer)
    isUserInteractionEnabled = true
  }

  private func setUpSubviews() {
    translatesAutoresizingMaskIntoConstraints = false
    layer.cornerRadius = frame.height / 2
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
  }

  @objc
  private func propagateTapEventToDelegate() {
    delegate?.didTapSearchBar()
  }
}

protocol TapOnlySearchBarDelegate: AnyObject {
  func didTapSearchBar()
}
