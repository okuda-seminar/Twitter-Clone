import UIKit

final class NewPostEntrypointButtonController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    let button = NewPostEntrypointButton()
    button.addAction(
      .init { _ in
        let newPostEditViewController = NewPostEditViewController()
        newPostEditViewController.modalPresentationStyle = .fullScreen
        self.present(newPostEditViewController, animated: true)
      }, for: .touchUpInside)
    view = button
  }
}

final class NewPostEntrypointButton: UIButton {
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
    backgroundColor = .brandedBlue

    NSLayoutConstraint.activate([
      widthAnchor.constraint(equalToConstant: LayoutConstant.buttonSize),
      heightAnchor.constraint(equalToConstant: LayoutConstant.buttonSize),
    ])
  }
}
