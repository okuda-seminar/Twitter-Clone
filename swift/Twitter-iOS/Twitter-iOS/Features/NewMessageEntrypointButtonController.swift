import UIKit

final class NewMessageEntrypointButtonController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    let button = NewMessageEntrypointButton()
    button.addAction(
      .init { _ in
        let newMessageEditViewController = NewMessageEditViewController()
        self.present(newMessageEditViewController, animated: true)
      }, for: .touchUpInside)
    view = button
  }
}

final class NewMessageEntrypointButton: UIButton {
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
    setImage(UIImage(systemName: "envelope"), for: .normal)
    imageView?.contentMode = .scaleAspectFit
    layer.cornerRadius = LayoutConstant.buttonSize / 2
    translatesAutoresizingMaskIntoConstraints = false
    tintColor = .white
    backgroundColor = .brandedBlue

    NSLayoutConstraint.activate([
      widthAnchor.constraint(equalToConstant: LayoutConstant.buttonSize),
      heightAnchor.constraint(equalToConstant: LayoutConstant.buttonSize),
    ])
  }
}
