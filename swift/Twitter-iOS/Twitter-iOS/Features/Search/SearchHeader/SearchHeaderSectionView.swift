import SwiftUI
import UIKit

class SearchHeaderSectionView: UIView {
  private enum LayoutConstant {
    static let edgeHorizontalPadding = 16.0
    static let edgeTopPadding = 8.0
    static let searchBarViewHorizontalPadding = 8.0
    static let searchBarViewBottomPadding = 4.0
    static let settingsEntryPointButtonSize = 28.0
    static let categoryTabButtonWidth = 80.0
    static let categoryTabButtonHeight = 44.0
  }

  public var headerView = SearchHeaderView()

  private let categoryTabsScrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.showsHorizontalScrollIndicator = false
    return scrollView
  }()

  private lazy var categoryTabsStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.spacing = 12
    return stackView
  }()

  public let categoryTabButtons: [SearchCategoryTabButton] = {
    var buttons: [SearchCategoryTabButton] = []
    for category in searchCategoryModels {
      let button = SearchCategoryTabButton(frame: .zero)
      button.translatesAutoresizingMaskIntoConstraints = false
      button.setTitle(category.title, for: .normal)
      button.tabID = category.tabId
      button.isSelected = category.tabId == .forYou
      buttons.append(button)
    }
    return buttons
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpSubviews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpSubviews() {
    for button in categoryTabButtons {
      categoryTabsStackView.addArrangedSubview(button)
      NSLayoutConstraint.activate([
        button.widthAnchor.constraint(equalToConstant: LayoutConstant.categoryTabButtonWidth),
        button.heightAnchor.constraint(equalToConstant: LayoutConstant.categoryTabButtonHeight),
      ])
    }

    let searchHeaderHostingController = UIHostingController(rootView: headerView)
    searchHeaderHostingController.view.translatesAutoresizingMaskIntoConstraints = false
    addSubview(searchHeaderHostingController.view)
    categoryTabsScrollView.addSubview(categoryTabsStackView)
    addSubview(categoryTabsScrollView)

    NSLayoutConstraint.activate([
      searchHeaderHostingController.view.topAnchor.constraint(equalTo: topAnchor),
      searchHeaderHostingController.view.leadingAnchor.constraint(
        equalTo: leadingAnchor, constant: LayoutConstant.edgeHorizontalPadding),
      searchHeaderHostingController.view.trailingAnchor.constraint(
        equalTo: trailingAnchor, constant: -LayoutConstant.edgeHorizontalPadding),

      categoryTabsScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      categoryTabsScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      categoryTabsScrollView.topAnchor.constraint(
        equalTo: searchHeaderHostingController.view.bottomAnchor,
        constant: LayoutConstant.searchBarViewBottomPadding),
      categoryTabsScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

      categoryTabsStackView.leadingAnchor.constraint(equalTo: categoryTabsScrollView.leadingAnchor),
      categoryTabsStackView.trailingAnchor.constraint(
        equalTo: categoryTabsScrollView.trailingAnchor),
      categoryTabsStackView.topAnchor.constraint(equalTo: categoryTabsScrollView.topAnchor),
      categoryTabsStackView.bottomAnchor.constraint(equalTo: categoryTabsScrollView.bottomAnchor),
    ])
  }
}
