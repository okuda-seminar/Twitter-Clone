import SwiftUI
import UIKit

class HomeViewController: UIViewController {

  private enum LayoutConstant {
    static let homeHeaderHeight = 72.0
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

  private let homeHeaderView: HomeHeaderView = {
    let view = HomeHeaderView(frame: .zero)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    setUpSubviews()
  }

  private func setUpSubviews() {
    view.backgroundColor = .white

    homeHeaderView.forYouButton.tabID = homeTabId.forYou.rawValue
    homeHeaderView.forYouButton.delegate = self
    homeHeaderView.followingButton.tabID = homeTabId.following.rawValue
    homeHeaderView.followingButton.delegate = self
    view.addSubview(homeHeaderView)

    let forYouTabViewController = UIHostingController(rootView: HomeTabView())
    let followingTabViewController = UIHostingController(rootView: HomeTabView())
    forYouTabViewController.view.translatesAutoresizingMaskIntoConstraints = false
    followingTabViewController.view.translatesAutoresizingMaskIntoConstraints = false
    homeTabStackView.addArrangedSubview(forYouTabViewController.view)
    homeTabStackView.addArrangedSubview(followingTabViewController.view)

    homeTabScrollView.delegate = self

    homeTabScrollView.addSubview(homeTabStackView)
    view.addSubview(homeTabScrollView)

    let layoutGuide = view.safeAreaLayoutGuide

    NSLayoutConstraint.activate([
      homeHeaderView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      homeHeaderView.heightAnchor.constraint(equalToConstant: LayoutConstant.homeHeaderHeight),
      homeHeaderView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      homeHeaderView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),

      homeTabScrollView.topAnchor.constraint(equalTo: homeHeaderView.bottomAnchor),
      homeTabScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      homeTabScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      homeTabScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

      homeTabStackView.topAnchor.constraint(equalTo: homeTabScrollView.topAnchor),
      homeTabStackView.leadingAnchor.constraint(equalTo: homeTabScrollView.leadingAnchor),
      homeTabStackView.trailingAnchor.constraint(equalTo: homeTabScrollView.trailingAnchor),
      homeTabStackView.bottomAnchor.constraint(equalTo: homeTabScrollView.bottomAnchor),
      homeTabStackView.heightAnchor.constraint(equalTo: homeTabScrollView.heightAnchor),

      forYouTabViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor),
      followingTabViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor),
    ])

    homeHeaderView.settingsEntryPointButton.addAction(
      .init { _ in
        self.showTimelineSettings()
      }, for: .touchUpInside)
  }

  private func showTimelineSettings() {
    let timelineSettingsViewController = TimelineSettingsViewController()
    timelineSettingsViewController.modalPresentationStyle = .fullScreen
    present(timelineSettingsViewController, animated: true)
  }
}

extension HomeViewController: UIScrollViewDelegate {
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let curXOffset = scrollView.contentOffset.x
    var selectedButtonIdx = 0

    for left in 0...homeHeaderView.allButtons.count - 1 {
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

    for (idx, button) in zip(homeHeaderView.allButtons.indices, homeHeaderView.allButtons) {
      if idx == selectedButtonIdx {
        updateSelectedButtonUI(button)
      } else {
        updateUnselectedButtonUI(button)
      }
    }
  }
}

extension HomeViewController: HomeHeaderButtonDelegate {
  func didTapHomeHeaderButton(selectedButton: HomeHeaderButton) {
    for (idx, button) in zip(homeHeaderView.allButtons.indices, homeHeaderView.allButtons) {
      if button.tabID == selectedButton.tabID {
        updateSelectedButtonUI(button)

        let xOffset = homeTabStackView.arrangedSubviews[idx].frame.origin.x
        homeTabScrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
      } else {
        updateUnselectedButtonUI(button)
      }
    }
  }

  private func updateSelectedButtonUI(_ button: HomeHeaderButton) {
    button.isSelected = true
  }

  private func updateUnselectedButtonUI(_ button: HomeHeaderButton) {
    button.isSelected = false
  }
}
