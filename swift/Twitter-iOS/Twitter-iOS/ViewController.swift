import UIKit

class RootViewController: UIViewController {

  private let helloLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Hello"
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    setUpSubviews()
  }

  private func setUpSubviews() {
    view.backgroundColor = .white
    view.addSubview(helloLabel)

    NSLayoutConstraint.activate([
      helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      helloLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])
  }
}

