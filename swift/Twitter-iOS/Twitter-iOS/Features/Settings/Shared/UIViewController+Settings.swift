import UIKit

extension UIViewController {
  fileprivate var isModal: Bool {
    let presentingIsModal = presentingViewController != nil
    let presentingIsNavigation =
      navigationController?.presentingViewController?.presentedViewController
      == navigationController
    let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController

    return presentingIsModal || presentingIsNavigation || presentingIsTabBar
  }
}

class SettingsViewController: UIViewController {
  private lazy var dismissalButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: String(localized: "Done"), style: .plain, target: self,
      action: #selector(dismissModalSheet))
    let attributes: [NSAttributedString.Key: Any] = [
      .underlineStyle: NSUnderlineStyle.single.rawValue, .underlineColor: UIColor.black,
    ]
    button.setTitleTextAttributes(attributes, for: .normal)
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    if isModal {
      navigationItem.rightBarButtonItems = [dismissalButton]
    }
  }

  @objc
  private func dismissModalSheet() {
    dismiss(animated: true)
  }
}
