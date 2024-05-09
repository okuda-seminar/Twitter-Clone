import SwiftUI
import UIKit

class SearchHomeViewController: ViewControllerWithUserIconButton {

  private enum LayoutConstant {
    static let headerHeight = 48.0
    static let edgePadding = 16.0
  }

  private lazy var profileIconButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "", style: .plain, target: self, action: #selector(slideInSideMenu))
    button.tintColor = .black
    button.image = UIImage(systemName: "person.circle.fill")
    button.action = #selector(showSideMenu)
    button.target = self
    return button
  }()

  private lazy var exploreSettingsEntryPointButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "", style: .plain, target: self, action: #selector(presentExploreSettings))
    button.tintColor = .black
    button.image = UIImage(systemName: "gear")
    return button
  }()

  private let headerTabSelectionView: SearchTabSelectionView = {
    let view = SearchTabSelectionView()
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

  private let newTweetEntryPointButtonController = NewTweetEntrypointButtonController()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    view.backgroundColor = .systemBackground

    view.addSubview(headerTabSelectionView)
    view.addSubview(tabsView)
    view.addSubview(newTweetEntryPointButtonController.view)

    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/94 - Fetch Search tab data from server.
    for button in headerTabSelectionView.categoryTabButtons {
      button.delegate = self
    }
    tabsView.loadTabsData(
      headerTabSelectionView.categoryTabButtons.count, searchTopicCellViewDelegate: self)

    addChild(newTweetEntryPointButtonController)
    newTweetEntryPointButtonController.didMove(toParent: self)

    let layoutGuide = view.safeAreaLayoutGuide

    NSLayoutConstraint.activate([
      headerTabSelectionView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      headerTabSelectionView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      headerTabSelectionView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      headerTabSelectionView.heightAnchor.constraint(equalToConstant: LayoutConstant.headerHeight),

      tabsView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      tabsView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      tabsView.topAnchor.constraint(equalTo: headerTabSelectionView.bottomAnchor),
      tabsView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),

      newTweetEntryPointButtonController.view.bottomAnchor.constraint(
        equalTo: layoutGuide.bottomAnchor, constant: -LayoutConstant.edgePadding),
      newTweetEntryPointButtonController.view.trailingAnchor.constraint(
        equalTo: layoutGuide.trailingAnchor, constant: -LayoutConstant.edgePadding),
    ])

    // set up the navigation header
    navigationController?.navigationBar.tintColor = .black
    title = ""
    navigationItem.leftBarButtonItems = [profileIconButton]
    navigationItem.rightBarButtonItems = [exploreSettingsEntryPointButton]
    let searchBar = TapOnlySearchBar()
    searchBar.delegate = self
    navigationItem.titleView = searchBar
  }

  @objc
  private func slideInSideMenu() {}

  @objc
  private func presentExploreSettings() {
    let exploreSettingsViewController = ExploreSettingsViewController()
    exploreSettingsViewController.modalPresentationStyle = .fullScreen
    present(exploreSettingsViewController, animated: true)
  }
}

extension SearchHomeViewController: SearchCategoryTabButtonDelegate {
  func didTapSearchCategoryButton(selectedButton: SearchCategoryTabButton) {
    for (tabIdx, button) in zip(
      headerTabSelectionView.categoryTabButtons.indices, headerTabSelectionView.categoryTabButtons)
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

extension SearchHomeViewController: SearchTopicCellViewDelegate {
  func didSelectSearchTopicCellView(_ view: SearchTopicCellView) {
    let topicDetailViewController = TopicDetailViewController()
    topicDetailViewController.topicName = view.topic.name
    navigationController?.pushViewController(topicDetailViewController, animated: true)
  }
}

extension SearchHomeViewController: TapOnlySearchBarDelegate {
  func didTapSearchBar() {
    navigationItem.backButtonDisplayMode = .minimal
    navigationController?.pushViewController(SearchInputViewController(), animated: true)
  }
}
