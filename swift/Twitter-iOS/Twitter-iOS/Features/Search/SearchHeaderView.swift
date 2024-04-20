import UIKit

class SearchHeaderView: UIView {
  private enum LayoutConstant {
    static let edgeHorizontalPadding = 16.0
    static let edgeTopPadding = 8.0
    static let profileIconButtonSize = 28.0
    static let settingsEntryPointButtonSize = 28.0
    static let categoryTabButtonWidth = 80.0
    static let categoryTabButtonHeight = 44.0
  }

  public let profileIconButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "person.circle.fill"), for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.tintColor = .black
    button.imageView?.contentMode = .scaleAspectFit
    button.contentHorizontalAlignment = .fill
    button.contentVerticalAlignment = .fill
    return button
  }()

  public let settingsEntryPointButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "gear"), for: .normal)
    button.contentMode = .scaleAspectFit
    button.contentHorizontalAlignment = .fill
    button.contentVerticalAlignment = .fill
    button.tintColor = .black
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

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
    
    addSubview(profileIconButton)
    addSubview(settingsEntryPointButton)
    categoryTabsScrollView.addSubview(categoryTabsStackView)
    addSubview(categoryTabsScrollView)

    NSLayoutConstraint.activate([
      profileIconButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutConstant.edgeHorizontalPadding),
      profileIconButton.topAnchor.constraint(equalTo: topAnchor, constant: LayoutConstant.edgeTopPadding),
      profileIconButton.widthAnchor.constraint(equalToConstant: LayoutConstant.profileIconButtonSize),
      profileIconButton.heightAnchor.constraint(equalToConstant: LayoutConstant.profileIconButtonSize),

      settingsEntryPointButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutConstant.edgeHorizontalPadding),
      settingsEntryPointButton.topAnchor.constraint(equalTo: profileIconButton.topAnchor),
      settingsEntryPointButton.widthAnchor.constraint(equalToConstant: LayoutConstant.settingsEntryPointButtonSize),
      settingsEntryPointButton.heightAnchor.constraint(equalToConstant: LayoutConstant.settingsEntryPointButtonSize),

      categoryTabsScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      categoryTabsScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      categoryTabsScrollView.topAnchor.constraint(equalTo: settingsEntryPointButton.bottomAnchor),
      categoryTabsScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

      categoryTabsStackView.leadingAnchor.constraint(equalTo: categoryTabsScrollView.leadingAnchor),
      categoryTabsStackView.trailingAnchor.constraint(equalTo: categoryTabsScrollView.trailingAnchor),
      categoryTabsStackView.topAnchor.constraint(equalTo: categoryTabsScrollView.topAnchor),
      categoryTabsStackView.bottomAnchor.constraint(equalTo: categoryTabsScrollView.bottomAnchor)
    ])
  }
}
