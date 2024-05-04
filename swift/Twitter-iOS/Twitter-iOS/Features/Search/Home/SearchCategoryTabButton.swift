import SwiftUI

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/82 - Fetch search categories data from backend.
let searchCategoryModels: [SearchCategoryModel] = [
  SearchCategoryModel(title: String(localized: "For You"), tabId: .forYou),
  SearchCategoryModel(title: String(localized: "Trending"), tabId: .trending),
  SearchCategoryModel(title: String(localized: "News"), tabId: .news),
  SearchCategoryModel(title: String(localized: "Sports"), tabId: .sports),
  SearchCategoryModel(title: String(localized: "Entertainment"), tabId: .entertainment),
]

protocol SearchCategoryTabButtonDelegate {
  func didTapSearchCategoryButton(selectedButton: SearchCategoryTabButton)
}

class SearchCategoryTabButton: UIButton {

  var delegate: SearchCategoryTabButtonDelegate?

  var tabID: SearchCategoryTabId?

  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpLayout() {
    backgroundColor = .systemBackground
    setTitleColor(.black, for: .selected)
    setTitleColor(.placeholderText, for: .normal)
    setTitleColor(.gray, for: .disabled)

    self.addTarget(self, action: #selector(didTap), for: .touchUpInside)
  }

  @objc
  private func didTap() {
    self.delegate?.didTapSearchCategoryButton(selectedButton: self)
  }
}
