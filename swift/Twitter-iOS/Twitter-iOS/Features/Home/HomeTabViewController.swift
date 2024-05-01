import SwiftUI
import UIKit

final class HomeTabViewController: UIViewController {

  public var tweets: [TweetModel]? {
    didSet {
      setUpSubviews()
    }
  }

  public weak var delegate: HomeTabViewControllerDelegate?

  public var tweetCellViews: [HomeTweetCellView] = []

  private var scrollViewYOffset = 0.0 {
    didSet {
      if oldValue != scrollViewYOffset {
        self.delegate?.didScrollVertically(xDelta: scrollViewYOffset - oldValue)
      }
    }
  }

  private let verticalScrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.showsVerticalScrollIndicator = false
    return scrollView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    guard let tweets else { return }

    view.backgroundColor = UIColor.systemBackground

    verticalScrollView.delegate = self

    let contentStackView = UIStackView()
    contentStackView.translatesAutoresizingMaskIntoConstraints = false
    contentStackView.axis = .vertical
    contentStackView.spacing = 5

    verticalScrollView.addSubview(contentStackView)
    view.addSubview(verticalScrollView)

    for tweet in tweets {
      let dividerView = UIView()
      dividerView.translatesAutoresizingMaskIntoConstraints = false
      dividerView.backgroundColor = UIColor.lightGray

      let tweetCellView = HomeTweetCellView()
      tweetCellView.translatesAutoresizingMaskIntoConstraints = false
      tweetCellView.tweet = tweet

      contentStackView.addArrangedSubview(dividerView)
      contentStackView.addArrangedSubview(tweetCellView)
      tweetCellViews.append(tweetCellView)

      NSLayoutConstraint.activate([
        tweetCellView.widthAnchor.constraint(equalTo: view.widthAnchor)
      ])
    }

    NSLayoutConstraint.activate([
      verticalScrollView.topAnchor.constraint(equalTo: view.topAnchor),
      verticalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      verticalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      verticalScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

      contentStackView.topAnchor.constraint(equalTo: verticalScrollView.topAnchor),
      contentStackView.leadingAnchor.constraint(equalTo: verticalScrollView.leadingAnchor),
      contentStackView.trailingAnchor.constraint(equalTo: verticalScrollView.trailingAnchor),
      contentStackView.bottomAnchor.constraint(equalTo: verticalScrollView.bottomAnchor),
    ])
  }
}

extension HomeTabViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    scrollViewYOffset = scrollView.contentOffset.y
  }
}

protocol HomeTabViewControllerDelegate: AnyObject {
  func didScrollVertically(xDelta: CGFloat)
}
