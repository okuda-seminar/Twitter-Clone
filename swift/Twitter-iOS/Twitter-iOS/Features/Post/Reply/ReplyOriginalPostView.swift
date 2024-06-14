import UIKit

class ReplyOriginalPostView: UIView {
  public let profileIcon: UIImage

  private enum LayoutConstant {
    static let profileIconSize: CGFloat = 48.0

    static let dividerViewWidth: CGFloat = 3.0
    static let dividerViewVerticalPadding: CGFloat = 6.0
  }

  private lazy var profileIconView: UIImageView = {
    let icon = UIImageView(image: profileIcon)
    icon.translatesAutoresizingMaskIntoConstraints = false
    icon.contentMode = .scaleAspectFit
    NSLayoutConstraint.activate([
      icon.widthAnchor.constraint(equalToConstant: LayoutConstant.profileIconSize),
      icon.heightAnchor.constraint(equalToConstant: LayoutConstant.profileIconSize),
    ])
    return icon
  }()

  private let dividerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .brandedLightGrayBackground
    NSLayoutConstraint.activate([
      view.widthAnchor.constraint(equalToConstant: LayoutConstant.dividerViewWidth)
    ])
    return view
  }()

  public init(profileIcon: UIImage) {
    self.profileIcon = profileIcon
    super.init(frame: .zero)
    setUpSubviews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpSubviews() {
    addSubview(profileIconView)
    addSubview(dividerView)

    NSLayoutConstraint.activate([
      profileIconView.topAnchor.constraint(equalTo: topAnchor),
      profileIconView.leadingAnchor.constraint(equalTo: leadingAnchor),

      dividerView.topAnchor.constraint(
        equalTo: profileIconView.bottomAnchor, constant: LayoutConstant.dividerViewVerticalPadding),
      dividerView.bottomAnchor.constraint(
        equalTo: bottomAnchor, constant: -LayoutConstant.dividerViewVerticalPadding),
      dividerView.centerXAnchor.constraint(equalTo: profileIconView.centerXAnchor),

      // Need to make the value dynamic.
      heightAnchor.constraint(greaterThanOrEqualToConstant: 200),
    ])
  }
}
