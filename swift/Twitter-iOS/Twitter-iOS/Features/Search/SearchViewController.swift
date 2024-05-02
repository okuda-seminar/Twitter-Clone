import UIKit

class SearchViewController: UIViewController {

  private enum LayoutConstant {
    static let headerHeight = 96.0
    static let edgePadding = 16.0
  }

  private let headerSectionView: SearchHeaderSectionView = {
    let view = SearchHeaderSectionView()
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

  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/131 - Refactor Search view hierarchy.
  private let newTweetEntryPointButtonController = NewTweetEntrypointButtonController()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    view.backgroundColor = .systemBackground

    view.addSubview(headerSectionView)
    view.addSubview(tabsView)
    view.addSubview(newTweetEntryPointButtonController.view)

    headerSectionView.headerView.delegate = self

    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/94 - Fetch Search tab data from server.
    for button in headerSectionView.categoryTabButtons {
      button.delegate = self
    }
    tabsView.loadTabsData(headerSectionView.categoryTabButtons.count)

    addChild(newTweetEntryPointButtonController)
    newTweetEntryPointButtonController.didMove(toParent: self)

    let layoutGuide = view.safeAreaLayoutGuide

    NSLayoutConstraint.activate([
      headerSectionView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      headerSectionView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      headerSectionView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      headerSectionView.heightAnchor.constraint(equalToConstant: LayoutConstant.headerHeight),

      tabsView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      tabsView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      tabsView.topAnchor.constraint(equalTo: headerSectionView.bottomAnchor),
      tabsView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),

      newTweetEntryPointButtonController.view.bottomAnchor.constraint(
        equalTo: layoutGuide.bottomAnchor, constant: -LayoutConstant.edgePadding),
      newTweetEntryPointButtonController.view.trailingAnchor.constraint(
        equalTo: layoutGuide.trailingAnchor, constant: -LayoutConstant.edgePadding),
    ])
  }
}

extension SearchViewController: SearchCategoryTabButtonDelegate {
  func didTapSearchCategoryButton(selectedButton: SearchCategoryTabButton) {
    for (tabIdx, button) in zip(
      headerSectionView.categoryTabButtons.indices, headerSectionView.categoryTabButtons)
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

extension SearchViewController: SearchHeaderViewDelegate {
  func didTapProfileIconButton() {
  }

  func didTapSearchBar() {
  }

  func didTapSettingsEntryPointButton() {
    let exploreSettingsViewController = ExploreSettingsViewController()
    exploreSettingsViewController.modalPresentationStyle = .fullScreen
    present(exploreSettingsViewController, animated: true)
  }
}
