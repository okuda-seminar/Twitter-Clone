import SwiftUI

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/82 - Fetch search categories data from backend.
let searchCategories = [
  String(localized: "For You"),
  String(localized: "Trending"),
  String(localized: "News"),
  String(localized: "Sports"),
  String(localized: "Entertainment"),
]

class SearchCategoryTabButton: UIButton {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpLayout() {
    backgroundColor = .systemBackground
    setTitleColor(.black, for: .normal)
  }
}
