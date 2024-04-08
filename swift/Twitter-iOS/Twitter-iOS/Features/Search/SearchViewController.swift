import UIKit



class SearchViewController: UIViewController {

  private enum LayoutConstant {
    static let headerHeight = 44.0
  }

  private let headerView: SearchHeaderView = {
    let view = SearchHeaderView(frame: .zero)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    view.backgroundColor = .systemBackground
    view.addSubview(headerView)

    for button in headerView.categoryTabButtons {
      button.delegate = self
    }

    let layoutGuide = view.safeAreaLayoutGuide

    NSLayoutConstraint.activate([
      headerView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      headerView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      headerView.heightAnchor.constraint(equalToConstant: LayoutConstant.headerHeight),
    ])
  }
}

extension SearchViewController: SearchCategoryTabButtonDelegate {
  func didTapSearchCategoryButton(selectedButton: SearchCategoryTabButton) {
    for button in headerView.categoryTabButtons {
      if button.tabID == selectedButton.tabID {
        button.isSelected = true
      } else {
        button.isSelected = false
      }
    }
  }
}
