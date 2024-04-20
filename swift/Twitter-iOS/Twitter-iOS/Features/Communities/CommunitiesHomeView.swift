import UIKit

class CommunitiesHomeView: UIView {

  private enum LocalizedString {
    static let headlineLabelText = String(localized: "Discover new Communities")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpSubviews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpSubviews() {
    let headlineLabel = UILabel()
    headlineLabel.translatesAutoresizingMaskIntoConstraints = false
    headlineLabel.text = LocalizedString.headlineLabelText
    headlineLabel.tintColor = .black
    headlineLabel.sizeToFit()

    addSubview(headlineLabel)

    NSLayoutConstraint.activate([
      headlineLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      headlineLabel.topAnchor.constraint(equalTo: topAnchor),
    ])
  }
}
