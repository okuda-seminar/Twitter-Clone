import UIKit

class CommunitiesSearchViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    let dummyButton = UIButton()
    dummyButton.translatesAutoresizingMaskIntoConstraints = false
    dummyButton.setTitle("OK", for: .normal)
    dummyButton.setTitleColor(.brandedBlue, for: .normal)
    dummyButton.sizeToFit()
    dummyButton.addAction(
      .init { _ in
        self.navigationController?.popViewController(animated: true)
      }, for: .touchUpInside)

    // set up navigation bar
    let backButtonImage = UIImage(systemName: "arrow.left")
    navigationController?.navigationBar.backIndicatorImage = backButtonImage
    navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage

    view.backgroundColor = .systemBackground
    view.addSubview(dummyButton)

    NSLayoutConstraint.activate([
      dummyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      dummyButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])
  }
}
