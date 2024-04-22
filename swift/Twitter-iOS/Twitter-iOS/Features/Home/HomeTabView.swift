import SwiftUI
import UIKit

final class HomeTabView: UIView {

  public var tweets: [TweetModel]? {
    didSet {
      setUpSubviews()
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpSubviews() {
    guard let tweets else { return }

    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.showsVerticalScrollIndicator = false

    let contentStackView = UIStackView()
    contentStackView.translatesAutoresizingMaskIntoConstraints = false
    contentStackView.axis = .vertical
    contentStackView.spacing = 5

    scrollView.addSubview(contentStackView)
    addSubview(scrollView)

    for tweet in tweets {
      let dividerView = UIView()
      dividerView.translatesAutoresizingMaskIntoConstraints = false
      dividerView.backgroundColor = UIColor.lightGray

      let tweetCellView = HomeTweetCellView()
      tweetCellView.translatesAutoresizingMaskIntoConstraints = false
      tweetCellView.tweet = tweet

      contentStackView.addArrangedSubview(dividerView)
      contentStackView.addArrangedSubview(tweetCellView)

      NSLayoutConstraint.activate([
        tweetCellView.widthAnchor.constraint(equalTo: widthAnchor),
      ])
    }

    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

      contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
    ])

    backgroundColor = UIColor.systemBackground
  }
}
