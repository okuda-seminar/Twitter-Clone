import SwiftUI
import UIKit

class TopicDetailViewController: UIViewController {

  public var topicName: String = ""

  private enum LayoutConstant {
    static let homeHeaderHeight = 72.0
    static let edgePadding = 16.0
  }

  private let newTweetEntryPointButtonController = NewTweetEntrypointButtonController()

  private lazy var searchFiltersEntryPointButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "", style: .plain, target: self, action: #selector(presentSearchFilters))
    button.image = UIImage(systemName: "line.3.horizontal.decrease.circle")
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    setUpSubviews()
  }

  private func setUpSubviews() {
    addChild(newTweetEntryPointButtonController)
    newTweetEntryPointButtonController.didMove(toParent: self)

    view.backgroundColor = .white
    view.addSubview(newTweetEntryPointButtonController.view)

    let layoutGuide = view.safeAreaLayoutGuide

    NSLayoutConstraint.activate([
      newTweetEntryPointButtonController.view.bottomAnchor.constraint(
        equalTo: layoutGuide.bottomAnchor, constant: -LayoutConstant.edgePadding),
      newTweetEntryPointButtonController.view.trailingAnchor.constraint(
        equalTo: layoutGuide.trailingAnchor, constant: -LayoutConstant.edgePadding),
    ])

    // set up navigation bar
    let backButtonImage = UIImage(systemName: "arrow.left")
    navigationController?.navigationBar.backIndicatorImage = backButtonImage
    navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
    navigationItem.rightBarButtonItems = [searchFiltersEntryPointButton]
    let searchBar = TapOnlySearchBar()
    searchBar.delegate = self
    searchBar.text = topicName
    navigationItem.titleView = searchBar
  }

  @objc
  private func presentSearchFilters() {}
}

extension TopicDetailViewController: TapOnlySearchBarDelegate {
  func didTapSearchBar() {
    print("called")
  }
}
