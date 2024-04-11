import UIKit

class SearchTabsView: UIView {

  private let tabsStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    return stackView
  }()

  private let tabsScrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.isScrollEnabled = false
    return scrollView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpSubviews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpSubviews() {
    addSubview(tabsScrollView)
    tabsScrollView.addSubview(tabsStackView)

    NSLayoutConstraint.activate([
      tabsScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tabsScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tabsScrollView.topAnchor.constraint(equalTo: topAnchor),
      tabsScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

      tabsStackView.leadingAnchor.constraint(equalTo: tabsScrollView.leadingAnchor),
      tabsStackView.trailingAnchor.constraint(equalTo: tabsScrollView.trailingAnchor),
      tabsStackView.topAnchor.constraint(equalTo: tabsScrollView.topAnchor),
      tabsStackView.bottomAnchor.constraint(equalTo: tabsScrollView.bottomAnchor)
    ])
  }

  public func scroll(to tabIdx: Int) {
    guard 0 <= tabIdx && tabIdx < tabsStackView.arrangedSubviews.count else {
      return
    }
    let xOffset = tabsStackView.arrangedSubviews[tabIdx].frame.origin.x
    tabsScrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
  }

  public func loadTabsData(_ count: Int) {
    for _ in 0..<count {
      let tabView = SearchTabView()
      tabView.translatesAutoresizingMaskIntoConstraints = false
      tabsStackView.addArrangedSubview(tabView)
      NSLayoutConstraint.activate([
        tabView.topAnchor.constraint(equalTo: tabsStackView.topAnchor),
        tabView.bottomAnchor.constraint(equalTo: tabsStackView.bottomAnchor),
        tabView.widthAnchor.constraint(equalTo: widthAnchor),
        tabView.heightAnchor.constraint(equalTo: heightAnchor)
      ])
    }
  }
}
