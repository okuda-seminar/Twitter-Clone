import SwiftUI
import UIKit

class SearchHeaderView: UIView {
  private enum LayoutConstant {
    static let edgeHorizontalPadding = 16.0
    static let edgeTopPadding = 8.0
    static let profileIconButtonSize = 28.0
    static let searchBarViewHorizontalPadding = 8.0
    static let searchBarViewBottomPadding = 4.0
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

  public let searchBarController: UIHostingController = {
    let controller = UIHostingController(rootView: SearchBarView())
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    return controller
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
    addSubview(searchBarController.view)
    addSubview(settingsEntryPointButton)
    categoryTabsScrollView.addSubview(categoryTabsStackView)
    addSubview(categoryTabsScrollView)

    NSLayoutConstraint.activate([
      profileIconButton.leadingAnchor.constraint(
        equalTo: leadingAnchor, constant: LayoutConstant.edgeHorizontalPadding),
      profileIconButton.topAnchor.constraint(
        equalTo: topAnchor, constant: LayoutConstant.edgeTopPadding),
      profileIconButton.widthAnchor.constraint(
        equalToConstant: LayoutConstant.profileIconButtonSize),
      profileIconButton.heightAnchor.constraint(
        equalToConstant: LayoutConstant.profileIconButtonSize),

      searchBarController.view.leadingAnchor.constraint(
        equalTo: profileIconButton.trailingAnchor,
        constant: LayoutConstant.searchBarViewHorizontalPadding),
      searchBarController.view.trailingAnchor.constraint(
        equalTo: settingsEntryPointButton.leadingAnchor,
        constant: -LayoutConstant.searchBarViewHorizontalPadding),
      searchBarController.view.centerYAnchor.constraint(equalTo: profileIconButton.centerYAnchor),

      settingsEntryPointButton.trailingAnchor.constraint(
        equalTo: trailingAnchor, constant: -LayoutConstant.edgeHorizontalPadding),
      settingsEntryPointButton.topAnchor.constraint(equalTo: profileIconButton.topAnchor),
      settingsEntryPointButton.widthAnchor.constraint(
        equalToConstant: LayoutConstant.settingsEntryPointButtonSize),
      settingsEntryPointButton.heightAnchor.constraint(
        equalToConstant: LayoutConstant.settingsEntryPointButtonSize),

      categoryTabsScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      categoryTabsScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      categoryTabsScrollView.topAnchor.constraint(
        equalTo: searchBarController.view.bottomAnchor,
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

struct SearchBarView: View {
  var body: some View {
    HStack {
      Spacer()
      Image(systemName: "magnifyingglass")
        .foregroundStyle(Color.primary)

      Text("Search")
        .foregroundStyle(Color.primary)
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
      Spacer()
    }
    .background(Color.gray.opacity(0.15))
    .clipShape(Capsule())
  }
}

#Preview{
  SearchBarView()
}
