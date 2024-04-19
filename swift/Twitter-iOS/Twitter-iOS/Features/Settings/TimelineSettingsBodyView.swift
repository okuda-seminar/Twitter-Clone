import UIKit

class TimelineSettingsBodyView: UIView {

  private enum LayoutConstant {
    static let edgeLeadingPadding = 32.0
    static let headlineLabelTopPadding = 32.0
  }

  private enum LocalizedString {
    static let headlineText = String(localized: "Nothing here yet")
  }

  private let headlineLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = LocalizedString.headlineText
    label.sizeToFit()
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
    addSubview(headlineLabel)

    NSLayoutConstraint.activate([
      headlineLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutConstant.edgeLeadingPadding),
      headlineLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutConstant.headlineLabelTopPadding),
    ])
  }
}
