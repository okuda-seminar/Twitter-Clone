import SwiftUI
import UIKit

class HomeViewController: ViewControllerWithUserIconButton {

  private enum LayoutConstant {
    static let homeTabSelectionHeight = 48.0
    static let edgePadding = 16.0
  }

  private enum homeTabId: String {
    case forYou
    case following
  }

  private let homeTabScrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.bounces = false
    return scrollView
  }()

  private let homeTabStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    return stackView
  }()

  private let homeTabSelectionView: HomeTabSelectionView = {
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/138 - Replace custom home header view with Apple's navigation bar items.
    let view = HomeTabSelectionView(frame: .zero)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var profileIconButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "", style: .plain, target: self, action: #selector(showSideMenu))
    button.tintColor = .black
    button.image = UIImage(systemName: "person.circle.fill")
    return button
  }()

  private lazy var timelineSettingsEntryPointButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "", style: .plain, target: self, action: #selector(presentExploreSettings))
    button.tintColor = .black
    button.image = UIImage(systemName: "gear")
    return button
  }()

  private lazy var newTweetEntryPointButtonController: NewTweetEntrypointButtonController = {
    let viewController = NewTweetEntrypointButtonController()
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(viewController)
    viewController.didMove(toParent: self)
    return viewController
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    view.backgroundColor = .white
    view.addSubview(homeTabSelectionView)
    view.addSubview(homeTabScrollView)
    view.addSubview(newTweetEntryPointButtonController.view)
    homeTabScrollView.addSubview(homeTabStackView)

    homeTabSelectionView.forYouButton.tabID = homeTabId.forYou.rawValue
    homeTabSelectionView.forYouButton.delegate = self
    homeTabSelectionView.followingButton.tabID = homeTabId.following.rawValue
    homeTabSelectionView.followingButton.delegate = self

    let forYouTabViewController = HomeTabViewController()
    forYouTabViewController.view.translatesAutoresizingMaskIntoConstraints = false
    loadTweetData(viewController: forYouTabViewController)
    addChild(forYouTabViewController)
    forYouTabViewController.didMove(toParent: self)
    forYouTabViewController.delegate = self
    homeTabStackView.addArrangedSubview(forYouTabViewController.view)

    let followingTabViewController = HomeTabViewController()
    followingTabViewController.view.translatesAutoresizingMaskIntoConstraints = false
    loadTweetData(viewController: followingTabViewController)
    addChild(followingTabViewController)
    followingTabViewController.didMove(toParent: self)
    followingTabViewController.delegate = self
    homeTabStackView.addArrangedSubview(followingTabViewController.view)

    homeTabScrollView.delegate = self

    addChild(newTweetEntryPointButtonController)
    newTweetEntryPointButtonController.didMove(toParent: self)

    let layoutGuide = view.safeAreaLayoutGuide

    NSLayoutConstraint.activate([
      homeTabSelectionView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      homeTabSelectionView.heightAnchor.constraint(
        equalToConstant: LayoutConstant.homeTabSelectionHeight),
      homeTabSelectionView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      homeTabSelectionView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),

      homeTabScrollView.topAnchor.constraint(equalTo: homeTabSelectionView.bottomAnchor),
      homeTabScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      homeTabScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      homeTabScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

      homeTabStackView.topAnchor.constraint(equalTo: homeTabScrollView.topAnchor),
      homeTabStackView.leadingAnchor.constraint(equalTo: homeTabScrollView.leadingAnchor),
      homeTabStackView.trailingAnchor.constraint(equalTo: homeTabScrollView.trailingAnchor),
      homeTabStackView.heightAnchor.constraint(equalTo: homeTabScrollView.heightAnchor),

      forYouTabViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor),
      followingTabViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor),

      newTweetEntryPointButtonController.view.bottomAnchor.constraint(
        equalTo: layoutGuide.bottomAnchor, constant: -LayoutConstant.edgePadding),
      newTweetEntryPointButtonController.view.trailingAnchor.constraint(
        equalTo: layoutGuide.trailingAnchor, constant: -LayoutConstant.edgePadding),
    ])

    // set up the navigation header
    navigationController?.navigationBar.tintColor = .black
    navigationItem.backButtonDisplayMode = .minimal
    let backButtonImage = UIImage(systemName: "arrow.left")
    navigationController?.navigationBar.backIndicatorImage = backButtonImage
    navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
    navigationItem.leftBarButtonItems = [profileIconButton]
    navigationItem.rightBarButtonItems = [timelineSettingsEntryPointButton]
    navigationItem.titleView = UIImageView(image: UIImage(systemName: "apple.logo"))
  }

  private func loadTweetData(viewController: HomeTabViewController) {
    var tweets: [TweetModel] = []
    for _ in 0..<30 {
      tweets.append(createFakeTweet())
    }
    viewController.tweets = tweets
  }

  private func showTimelineSettings() {
    let timelineSettingsViewController = TimelineSettingsViewController()
    timelineSettingsViewController.modalPresentationStyle = .fullScreen
    present(timelineSettingsViewController, animated: true)
  }

  @objc
  private func presentExploreSettings() {
    let timelineSettingsViewController = TimelineSettingsViewController()
    timelineSettingsViewController.modalPresentationStyle = .fullScreen
    present(timelineSettingsViewController, animated: true)
  }
}

extension HomeViewController: UIScrollViewDelegate {
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let curXOffset = scrollView.contentOffset.x
    var selectedButtonIdx = 0

    for left in 0...homeTabSelectionView.allButtons.count - 1 {
      let leftXOffset = homeTabStackView.arrangedSubviews[left].frame.origin.x
      let rightXOffset = homeTabStackView.arrangedSubviews[left + 1].frame.origin.x
      guard leftXOffset <= curXOffset && curXOffset <= curXOffset else { continue }

      if curXOffset <= (leftXOffset + rightXOffset) / 2 {
        selectedButtonIdx = left
        scrollView.setContentOffset(CGPoint(x: leftXOffset, y: 0), animated: true)
      } else {
        selectedButtonIdx = left + 1
        scrollView.setContentOffset(CGPoint(x: rightXOffset, y: 0), animated: true)
      }
      break
    }

    for (idx, button) in zip(
      homeTabSelectionView.allButtons.indices, homeTabSelectionView.allButtons)
    {
      if idx == selectedButtonIdx {
        updateSelectedButtonUI(button)
      } else {
        updateUnselectedButtonUI(button)
      }
    }
  }
}

extension HomeViewController: HomeTabSelectionButtonDelegate {
  func didTapHomeTabSelectionButton(selectedButton: HomeTabSelectionButton) {
    for (idx, button) in zip(
      homeTabSelectionView.allButtons.indices, homeTabSelectionView.allButtons)
    {
      if button.tabID == selectedButton.tabID {
        updateSelectedButtonUI(button)

        let xOffset = homeTabStackView.arrangedSubviews[idx].frame.origin.x
        homeTabScrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
      } else {
        updateUnselectedButtonUI(button)
      }
    }
  }

  private func updateSelectedButtonUI(_ button: HomeTabSelectionButton) {
    button.isSelected = true
  }

  private func updateUnselectedButtonUI(_ button: HomeTabSelectionButton) {
    button.isSelected = false
  }
}

//extension HomeViewController: HomeTweetCellViewDelegate {
//  func didTapUserIconButton(userName: String, profileIcon: UIImage?) {
//    let userProfileViewController = UserProfileViewController()
//    userProfileViewController.userName = userName
//    userProfileViewController.profileIcon = profileIcon
//    navigationController?.pushViewController(userProfileViewController, animated: true)
//  }
//
//  func didTapTweet() {
//    let tweetDetailViewController = TweetDetailViewController()
//    navigationController?.pushViewController(tweetDetailViewController, animated: true)
//  }
//}

extension HomeViewController: HomeTabViewControllerDelegate {
  func didScrollVertically(xDelta: CGFloat) {
    UIView.animate(withDuration: 0.3) {
      self.homeTabSelectionView.layer.opacity = xDelta > 0 ? 0.0 : 1.0
    }
  }

  func didTapTweetCell(_ cell: HomeTweetCollectionViewCell) {
    let tweetDetailViewController = TweetDetailViewController()
    navigationController?.pushViewController(tweetDetailViewController, animated: true)
  }
}
