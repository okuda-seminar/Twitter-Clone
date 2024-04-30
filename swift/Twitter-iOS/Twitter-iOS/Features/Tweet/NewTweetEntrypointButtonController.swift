import UIKit

final class NewTweetEntrypointButtonController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    let button = NewTweetEntrypointButton()
    button.addAction(
      .init { _ in
        let newTweetEditViewController = NewTweetEditViewController()
        newTweetEditViewController.modalPresentationStyle = .fullScreen
        self.present(newTweetEditViewController, animated: true)
      }, for: .touchUpInside)
    view = button
  }
}

final class NewTweetEntrypointButton: UIButton {
  private enum LayoutConstant {
    static let buttonSize: CGFloat = 44.0
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupButton()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupButton() {
    setImage(UIImage(systemName: "plus"), for: .normal)
    imageView?.contentMode = .scaleAspectFit
    layer.cornerRadius = LayoutConstant.buttonSize / 2
    translatesAutoresizingMaskIntoConstraints = false
    tintColor = .white
    backgroundColor = .systemBlue

    NSLayoutConstraint.activate([
      widthAnchor.constraint(equalToConstant: LayoutConstant.buttonSize),
      heightAnchor.constraint(equalToConstant: LayoutConstant.buttonSize),
    ])
  }
}
