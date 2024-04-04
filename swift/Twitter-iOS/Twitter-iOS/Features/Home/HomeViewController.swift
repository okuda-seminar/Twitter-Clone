import SwiftUI
import UIKit

class HomeViewController: UIViewController {

  private enum LayoutConstant {
    static let homeHeaderHeight = 44.0
  }

  private enum homeTabId: String {
    case forYou
    case following
  }

  private var selectedTabId: homeTabId = .forYou

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
    let view = HomeHeaderView()
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
  }
}

extension HomeViewController: UIScrollViewDelegate {
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    print("Finish")
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
