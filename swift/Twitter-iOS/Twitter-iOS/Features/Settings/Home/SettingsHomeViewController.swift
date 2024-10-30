import SwiftUI
import UIKit

class SettingsHomeViewController: SettingsViewController {

  // MARK: - Private Props

  private enum LocalizedString {
    static let title = String(localized: "Settings")
  }

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = LocalizedString.title
    label.font = .preferredFont(forTextStyle: .headline)
    return label
  }()

  private let subtitleLabel: UILabel = {
    let label = UILabel()
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/464
    // - Enable Real Username Display in subtitleLabel in Settings View Controllers.

    /// This is a placeholder username that does not need to be wrapped in LocalizedString.
    /// It should be replaced with the real username variable in the future.
    label.text = "@userName"
    label.font = .preferredFont(forTextStyle: .footnote)
    label.textColor = .gray
    return label
  }()

  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(rootView: SettingsHomeView(delegate: self))
    addChild(controller)
    controller.didMove(toParent: self)
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    return controller
  }()

  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setUpNavigation()
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

  private func setUpNavigation() {
    let titleStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
    titleStackView.axis = .vertical
    titleStackView.alignment = .center

    navigationItem.backButtonDisplayMode = .minimal
    navigationItem.titleView = titleStackView
    navigationItem.leftBarButtonItems = []
    navigationController?.navigationBar.backgroundColor = .systemBackground
  }
}

// MARK: - Delegate

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/465
// - Implement Delegate Methods and Integrate Navigation to Corresponding View Controllers in SettingsHomeViewDelegate.
extension SettingsHomeViewController: SettingsHomeViewDelegate {
  public func pushSearchSettings(animated: Bool) {}
  public func pushAccountSettings(animated: Bool) {}
  public func pushSecurityAndAccountAccessSettings(animated: Bool) {}
  public func pushMonetizationSettings(animated: Bool) {}
  public func pushPremiumSettings(animated: Bool) {}

  public func pushTimelineSettings(animated: Bool = true) {
    navigationController?.pushViewController(
      TimelineSettingsViewController(), animated: animated)
  }

  public func pushPrivacyAndSafetySettings(animated: Bool) {}

  public func pushNotificationsSettings(animated: Bool = true) {
    navigationController?.pushViewController(
      NotificationsSettingsViewController(), animated: animated)
  }

  public func pushAccessibilityDisplayAndLanguagesSettings(animated: Bool) {}
  public func pushAdditionalResourcesSettings(animated: Bool) {}
}

// MARK: - View

struct SettingsHomeView: View {
  public weak var delegate: SettingsHomeViewDelegate?

  private enum LayoutConstant {
    static let searchSettingsNavigationBarTitleOpacity: CGFloat = 0.6
    static let searchSettingsNavigationBarBackgroundOpacity: CGFloat = 0.2
    static let searchSettingsNavigationBarHeight: CGFloat = 40.0
    static let searchSettingsNavigationBarCornerRadius: CGFloat = 20.0
  }

  private enum LocalizedString {
    static let searchSettingsNavigationBarTitle = String(localized: "Search settings")

    static let yourAccountTitle = String(localized: "Your account")
    // \ is required to avoid unintended line breaks.
    static let yourAccountCaption = String(
      localized:
        """
        See information about your account, download an archive of your data, \
        or learn about your account deactivation options.
        """
    )

    static let securityAndAccountAccessTitle = String(localized: "Security and account access")
    // \ is required to avoid unintended line breaks.
    static let securityAndAccountAccessCaption = String(
      localized:
        """
        Manage your account's security and keep track of your account's \
        usage including apps that you have connected to your account.
        """)

    static let monetizationTitle = String(localized: "Monetization")
    static let monetizationCaption = String(
      localized: "See how you can make money on X and manage your monetization options.")

    static let premiumTitle = String(localized: "Premium")
    static let premiumCaption = String(
      localized: "Manage your subscription features including Undo post timing.")

    static let timelineSettingsTitle = String(localized: "Timeline")
    static let timelineSettingsCaption = String(
      localized: "Configure your timeline appearance.")

    static let privacyAndSafetyTitle = String(localized: "Privacy and safety")
    static let privacyAndSafetyCaption = String(
      localized: "Manage what information you see and share on X.")

    static let notificationsTitle = String(localized: "Notifications")
    // \ is required to avoid unintended line breaks.
    static let notificationsCaption = String(
      localized:
        """
        Select the kinds of notifications you get \
        about your activities, interests, and recommendations.
        """
    )

    static let accessibilityDisplayAndLanguagesTitle = String(
      localized: "Accessibility, display, and languages")
    static let accessibilityDisplayAndLanguagesCaption = String(
      localized: "Manage how X content is displayed to you.")

    static let additionalResourcesTitle = String(localized: "Additional resources")
    // \ is required to avoid unintended line breaks.
    static let additionalResourcesCaption = String(
      localized:
        """
        Check out other places for helpful information \
        to learn more about X products and services.
        """
    )
  }

  var body: some View {
    VStack {
      SearchSettingsNavigationBar()

      ScrollView {
        SettingsNavigationList()
      }
    }
  }

  @ViewBuilder
  private func SearchSettingsNavigationBar() -> some View {
    HStack {
      Spacer()

      Image(systemName: "magnifyingglass")
        .foregroundStyle(.black.opacity(LayoutConstant.searchSettingsNavigationBarTitleOpacity))

      Text(LocalizedString.searchSettingsNavigationBarTitle)
        .foregroundStyle(.black.opacity(LayoutConstant.searchSettingsNavigationBarTitleOpacity))

      Spacer()
    }
    .padding()
    .background(.gray.opacity(LayoutConstant.searchSettingsNavigationBarBackgroundOpacity))
    .frame(height: LayoutConstant.searchSettingsNavigationBarHeight)
    .clipShape(
      RoundedRectangle(cornerRadius: LayoutConstant.searchSettingsNavigationBarCornerRadius)
    )
    .padding(.horizontal)
    .onTapGesture {
      delegate?.pushSearchSettings(animated: true)
    }
  }

  @ViewBuilder
  private func SettingsNavigationList() -> some View {
    VStack {
      SettingsNavigationRow(
        icon: Image(systemName: "person"),
        title: LocalizedString.yourAccountTitle,
        caption: LocalizedString.yourAccountCaption
      )
      .onTapGesture {
        delegate?.pushAccountSettings(animated: true)
      }

      SettingsNavigationRow(
        icon: Image(systemName: "lock"),
        title: LocalizedString.securityAndAccountAccessTitle,
        caption: LocalizedString.securityAndAccountAccessCaption
      )
      .onTapGesture {
        delegate?.pushSecurityAndAccountAccessSettings(animated: true)
      }

      SettingsNavigationRow(
        icon: Image(systemName: "dollarsign.square"),
        title: LocalizedString.monetizationTitle,
        caption: LocalizedString.monetizationCaption
      )
      .onTapGesture {
        delegate?.pushMonetizationSettings(animated: true)
      }

      SettingsNavigationRow(
        icon: Image(systemName: "x.square"),
        title: LocalizedString.premiumTitle,
        caption: LocalizedString.premiumCaption
      )
      .onTapGesture {
        delegate?.pushPremiumSettings(animated: true)
      }

      SettingsNavigationRow(
        icon: Image(systemName: "square.text.square"),
        title: LocalizedString.timelineSettingsTitle,
        caption: LocalizedString.timelineSettingsCaption
      )
      .onTapGesture {
        delegate?.pushTimelineSettings(animated: true)
      }

      SettingsNavigationRow(
        icon: Image(systemName: "checkmark.shield"),
        title: LocalizedString.privacyAndSafetyTitle,
        caption: LocalizedString.privacyAndSafetyCaption
      )
      .onTapGesture {
        delegate?.pushPrivacyAndSafetySettings(animated: true)
      }

      SettingsNavigationRow(
        icon: Image(systemName: "bell"),
        title: LocalizedString.notificationsTitle,
        caption: LocalizedString.notificationsCaption
      )
      .onTapGesture {
        delegate?.pushNotificationsSettings(animated: true)
      }

      SettingsNavigationRow(
        icon: Image(systemName: "figure.child.circle"),
        title: LocalizedString.accessibilityDisplayAndLanguagesTitle,
        caption: LocalizedString.accessibilityDisplayAndLanguagesCaption
      )
      .onTapGesture {
        delegate?.pushAccessibilityDisplayAndLanguagesSettings(animated: true)
      }

      SettingsNavigationRow(
        icon: Image(systemName: "ellipsis.circle"),
        title: LocalizedString.additionalResourcesTitle,
        caption: LocalizedString.additionalResourcesCaption
      )
      .onTapGesture {
        delegate?.pushAdditionalResourcesSettings(animated: true)
      }
    }
  }

  @ViewBuilder
  private func SettingsNavigationRow(icon: Image, title: String, caption: String) -> some View {
    HStack(alignment: .center) {
      icon
        .foregroundStyle(Color(uiColor: .gray))

      VStack(alignment: .leading) {
        Text(title)
          .foregroundStyle(.black)
          .font(.subheadline)
        Text(caption)
          .foregroundStyle(Color(uiColor: .brandedLightGrayText))
          .font(.caption2)
          .multilineTextAlignment(.leading)
      }
      .padding()
      Spacer()

      Image(systemName: "chevron.right")
        .foregroundStyle(Color(uiColor: .lightGray))
    }
    .padding(.horizontal)
  }
}

// MARK: - Protocol

protocol SettingsHomeViewDelegate: AnyObject {
  func pushSearchSettings(animated: Bool)
  func pushAccountSettings(animated: Bool)
  func pushSecurityAndAccountAccessSettings(animated: Bool)
  func pushMonetizationSettings(animated: Bool)
  func pushPremiumSettings(animated: Bool)
  func pushTimelineSettings(animated: Bool)
  func pushPrivacyAndSafetySettings(animated: Bool)
  func pushNotificationsSettings(animated: Bool)
  func pushAccessibilityDisplayAndLanguagesSettings(animated: Bool)
  func pushAdditionalResourcesSettings(animated: Bool)
}

// MARK: - Preview

#Preview {
  SettingsHomeView()
}
