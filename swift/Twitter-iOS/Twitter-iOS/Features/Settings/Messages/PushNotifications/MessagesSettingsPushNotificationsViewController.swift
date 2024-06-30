import SwiftUI
import UIKit

class MessagesSettingsPushNotificationsViewController: SettingsViewController {

  private enum LocalizedString {
    static let title = String(localized: "Push notifications")
  }

  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(
      rootView: MessagesSettingsPushNotificationsView(delegate: self))
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  // MARK: - View Lifecycle

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setUpNavigation()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  // MARK: - Private API

  private func setUpNavigation() {
    navigationItem.title = LocalizedString.title
  }

  // MARK: - Private API

  private func setUpSubviews() {
    view.backgroundColor = .systemBackground
    view.addSubview(hostingController.view)

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
    ])
  }
}

extension MessagesSettingsPushNotificationsViewController:
  MessagesSettingsPushNotificationsViewDelegate
{

  func didTapOpenIOSSettingsButton() {
    if let url = URL(string: UIApplication.openSettingsURLString) {
      UIApplication.shared.open(url)
    }
  }
}

struct MessagesSettingsPushNotificationsView: View {

  // MARK: - Public Props

  public weak var delegate: MessagesSettingsPushNotificationsViewDelegate?

  // MARK: - Private Props

  private enum LayoutConstant {
    static let navigationButtonHeight: CGFloat = 44.0
    static let navigationButtonCornerRadius: CGFloat = 22.0
  }

  private enum LocalizedString {
    static let openIOSSettings = String(localized: "Open iOS Settings")
  }

  var body: some View {
    Button(
      action: {
        delegate?.didTapOpenIOSSettingsButton()
      },
      label: {
        Text(LocalizedString.openIOSSettings)
          .foregroundStyle(.white)
          .underline()
          .padding()
      }
    )
    .background(Color(.black))
    .frame(height: LayoutConstant.navigationButtonHeight)
    .clipShape(RoundedRectangle(cornerRadius: LayoutConstant.navigationButtonCornerRadius))
    .padding(.leading)
    .padding(.bottom)
    .padding(.trailing)
  }
}

protocol MessagesSettingsPushNotificationsViewDelegate: AnyObject {
  func didTapOpenIOSSettingsButton()
}

#Preview {
  MessagesSettingsPushNotificationsView()
}
