import SwiftUI
import UIKit

class SearchTabView: UIView {
  private enum LayoutConstant {
    static let topicCellHeight = 72.0
    static let stackViewSpacing = 4.0
  }

  private let topicCellScrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.showsVerticalScrollIndicator = false
    return scrollView
  }()

  private let topicCellStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = LayoutConstant.stackViewSpacing
    return stackView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpSubviews() {
    topicCellScrollView.addSubview(topicCellStackView)
    addSubview(topicCellScrollView)

    NSLayoutConstraint.activate([
      topicCellScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      topicCellScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      topicCellScrollView.topAnchor.constraint(equalTo: topAnchor),
      topicCellScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

      topicCellStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      topicCellStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      topicCellStackView.topAnchor.constraint(equalTo: topicCellScrollView.topAnchor),
      topicCellStackView.bottomAnchor.constraint(equalTo: topicCellScrollView.bottomAnchor),
    ])
  }

  public func loadSearchTopicModels(_ searchTopicCellViewDelegate: SearchTopicCellViewDelegate?) {
    for _ in 0..<30 {
      let topicModel = createFakeTopicModel()
      let searchTopicCellView = SearchTopicCellView(
        delegate: searchTopicCellViewDelegate, topic: topicModel)
      let searchTopicCellViewController = UIHostingController(rootView: searchTopicCellView)

      topicCellStackView.addArrangedSubview(searchTopicCellViewController.view)
      NSLayoutConstraint.activate([
        searchTopicCellViewController.view.heightAnchor.constraint(
          equalToConstant: LayoutConstant.topicCellHeight),
        searchTopicCellViewController.view.leadingAnchor.constraint(
          equalTo: topicCellStackView.leadingAnchor),
        searchTopicCellViewController.view.trailingAnchor.constraint(
          equalTo: topicCellStackView.trailingAnchor),
      ])
    }

    setUpSubviews()
  }

  @objc
  private func didSelectSearchTopic(_ topic: TopicModel) {

  }
}
