import SwiftUI
import UIKit

class TopicDetailViewController: UIViewController {

  public var topicName: String = ""

  private enum LayoutConstant {
    static let homeHeaderHeight = 72.0
    static let edgePadding = 16.0
  }

  private let newTweetEntryPointButtonController = NewTweetEntrypointButtonController()

  override func viewDidLoad() {
    super.viewDidLoad()

    setUpSubviews()
  }

  private func setUpSubviews() {
    let headerViewHostingController = UIHostingController(
      rootView: SearchDetailHeaderView(delegate: self, searchQuery: topicName))
    addChild(headerViewHostingController)
    headerViewHostingController.didMove(toParent: self)
    headerViewHostingController.view.translatesAutoresizingMaskIntoConstraints = false

    addChild(newTweetEntryPointButtonController)
    newTweetEntryPointButtonController.didMove(toParent: self)

    view.backgroundColor = .white
    view.addSubview(headerViewHostingController.view)
    view.addSubview(newTweetEntryPointButtonController.view)

    let layoutGuide = view.safeAreaLayoutGuide

    NSLayoutConstraint.activate([
      headerViewHostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
      headerViewHostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      headerViewHostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      headerViewHostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),

      newTweetEntryPointButtonController.view.bottomAnchor.constraint(
        equalTo: layoutGuide.bottomAnchor, constant: -LayoutConstant.edgePadding),
      newTweetEntryPointButtonController.view.trailingAnchor.constraint(
        equalTo: layoutGuide.trailingAnchor, constant: -LayoutConstant.edgePadding),
    ])
  }
}

extension TopicDetailViewController: SearchDetailHeaderViewDelegate {
  func didTapBackButton() {
  }

  func didTapSearchBar() {
  }

  func didTapSearchFiltersEntryPoint() {
    // show search filters full screen modal view.
  }
}
