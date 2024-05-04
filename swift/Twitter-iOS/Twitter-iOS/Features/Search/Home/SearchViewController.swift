import SwiftUI
import UIKit

class SearchViewController: UIViewController {

  private enum LayoutConstant {
    static let headerHeight = 48.0
    static let edgePadding = 16.0
  }

  private lazy var headerViewHostingController: UIHostingController = {
    let headerView = SearchHeaderView(delegate: self)
    let hostingController = UIHostingController(rootView: headerView)
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(hostingController)
    hostingController.didMove(toParent: self)
    return hostingController
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

    view.addSubview(headerViewHostingController.view)
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
      headerViewHostingController.view.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      headerViewHostingController.view.leadingAnchor.constraint(
        equalTo: layoutGuide.leadingAnchor, constant: LayoutConstant.edgePadding),
      headerViewHostingController.view.trailingAnchor.constraint(
        equalTo: layoutGuide.trailingAnchor, constant: -LayoutConstant.edgePadding),

      headerTabSelectionView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      headerTabSelectionView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      headerTabSelectionView.topAnchor.constraint(
        equalTo: headerViewHostingController.view.bottomAnchor),
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
  }
}

extension SearchViewController: SearchCategoryTabButtonDelegate {
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

extension SearchViewController: SearchTopicCellViewDelegate {
  func didSelectSearchTopicCellView(_ view: SearchTopicCellView) {
    let topicDetailViewController = TopicDetailViewController()
    topicDetailViewController.topicName = view.topic.name
    self.navigationController?.pushViewController(topicDetailViewController, animated: true)
  }
}
