import SwiftUI
import UIKit

class HomeViewController: UIViewController {
  private let helloLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Hello"
    return label
  }()

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

  override func viewDidLoad() {
    super.viewDidLoad()

    setUpSubviews()
  }

  private func setUpSubviews() {
    view.backgroundColor = .white

    let forYouTabViewController = UIHostingController(rootView: HomeTabView())
    let followingTabViewController = UIHostingController(rootView: HomeTabView())
    forYouTabViewController.view.translatesAutoresizingMaskIntoConstraints = false
    followingTabViewController.view.translatesAutoresizingMaskIntoConstraints = false
    homeTabStackView.addArrangedSubview(forYouTabViewController.view)
    homeTabStackView.addArrangedSubview(followingTabViewController.view)

    homeTabScrollView.delegate = self

    homeTabScrollView.addSubview(homeTabStackView)
    view.addSubview(homeTabScrollView)

    NSLayoutConstraint.activate([
      homeTabScrollView.topAnchor.constraint(equalTo: view.topAnchor),
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
