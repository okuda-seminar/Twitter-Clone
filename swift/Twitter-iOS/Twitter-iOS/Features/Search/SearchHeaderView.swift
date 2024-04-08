import UIKit

class SearchHeaderView: UIView {
  private enum LayoutConstant {
    static let categoryTabButtonWidth = 80.0
    static let categoryTabButtonHeight = 44.0
  }

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
    categoryTabsScrollView.addSubview(categoryTabsStackView)
    addSubview(categoryTabsScrollView)

    NSLayoutConstraint.activate([
      categoryTabsScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      categoryTabsScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      categoryTabsScrollView.topAnchor.constraint(equalTo: topAnchor),
      categoryTabsScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

      categoryTabsStackView.leadingAnchor.constraint(equalTo: categoryTabsScrollView.leadingAnchor),
      categoryTabsStackView.trailingAnchor.constraint(equalTo: categoryTabsScrollView.trailingAnchor),
      categoryTabsStackView.topAnchor.constraint(equalTo: categoryTabsScrollView.topAnchor),
      categoryTabsStackView.bottomAnchor.constraint(equalTo: categoryTabsScrollView.bottomAnchor)
    ])
  }
}
