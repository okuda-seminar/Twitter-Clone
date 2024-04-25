import UIKit

class SearchViewController: UIViewController {

  private enum LayoutConstant {
    static let headerHeight = 44.0
    static let edgePadding = 16.0
  }

  private let headerView: SearchHeaderView = {
    let view = SearchHeaderView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private let tabsView: SearchTabsView = {
    let view = SearchTabsView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private let tabView: SearchTabView = {
    let view = SearchTabView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private let newTweetEntryPointButton: NewTweetEntrypointButton = {
    let button = NewTweetEntrypointButton()
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    view.backgroundColor = .systemBackground

    view.addSubview(headerView)
    view.addSubview(tabsView)
    view.addSubview(newTweetEntryPointButton)

    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/94 - Fetch Search tab data from server.
    for button in headerView.categoryTabButtons {
      button.delegate = self
    }
    tabsView.loadTabsData(headerView.categoryTabButtons.count)

    let layoutGuide = view.safeAreaLayoutGuide

    NSLayoutConstraint.activate([
      headerView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      headerView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      headerView.heightAnchor.constraint(equalToConstant: LayoutConstant.headerHeight),

      tabsView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      tabsView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      tabsView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
      tabsView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),

      newTweetEntryPointButton.bottomAnchor.constraint(
        equalTo: layoutGuide.bottomAnchor, constant: -LayoutConstant.edgePadding),
      newTweetEntryPointButton.trailingAnchor.constraint(
        equalTo: layoutGuide.trailingAnchor, constant: -LayoutConstant.edgePadding),
    ])

    headerView.settingsEntryPointButton.addAction(
      .init { _ in
        self.showExploreSettings()
      }, for: .touchUpInside)
  }

  private func showExploreSettings() {
    let exploreSettingsViewController = ExploreSettingsViewController()
    exploreSettingsViewController.modalPresentationStyle = .fullScreen
    present(exploreSettingsViewController, animated: true)
  }
}

extension SearchViewController: SearchCategoryTabButtonDelegate {
  func didTapSearchCategoryButton(selectedButton: SearchCategoryTabButton) {
    for (tabIdx, button) in zip(
      headerView.categoryTabButtons.indices, headerView.categoryTabButtons)
    {
      if button.tabID == selectedButton.tabID {
        button.isSelected = true
        tabsView.scroll(to: tabIdx)
      } else {
        button.isSelected = false
      }
    }
  }
}
