import SwiftUI
import UIKit

final class BlockedNewCommunityCreationBottomSheetViewController: UIViewController {

  // MARK: - Private Props

  private enum LayoutConstant {
    static let edgeHorizontalPadding = 16.0
  }

  private let dismissalObserver = BlockedNewCommunityCreationBottomSheetViewObserver()

  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(
      rootView: BottomSheetView(dismissalObserver: dismissalObserver))
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
    setUpViewObserver()
  }

  private func setUpSubviews() {
    view.addSubview(hostingController.view)

    view.backgroundColor = .systemBackground

    NSLayoutConstraint.activate([
      hostingController.view.leadingAnchor.constraint(
        equalTo: view.leadingAnchor, constant: LayoutConstant.edgeHorizontalPadding),
      hostingController.view.trailingAnchor.constraint(
        equalTo: view.trailingAnchor, constant: -LayoutConstant.edgeHorizontalPadding),
      hostingController.view.topAnchor.constraint(
        equalTo: view.topAnchor, constant: 12),
    ])
  }

  private func setUpViewObserver() {
    dismissalObserver.didTapDismissalButton = { [weak self] in
      self?.dismiss(animated: true)
    }
  }
}

struct BottomSheetView: View {

  // MARK: - Public Props

  @ObservedObject var dismissalObserver: BlockedNewCommunityCreationBottomSheetViewObserver

  // MARK: - Private Props

  private enum LayoutConstant {
    static let vStackSpacing: CGFloat = 10.0
    static let headlineFontSize: CGFloat = 21.0
    static let subHeadlineFontSize: CGFloat = 14.0
    static let buttonHeight: CGFloat = 44.0
    static let buttonCornerRadius: CGFloat = 22.0
    static let overlayLineWidth: CGFloat = 0.5
  }

  private enum LocalizedString {
    static let headlineText = String(localized: "Unlock creating a Community with X Premium")
    static let subHeadlineText = String(
      localized:
        "Only X Premium subscribers have access to create a Community. Upgrade to continue.")
    static let upgradeButtonText = String(localized: "Upgrade")
    static let dismissButtonText = String(localized: "Maybe later")
  }

  // MARK: - View

  var body: some View {

    VStack(alignment: .leading, spacing: LayoutConstant.vStackSpacing) {
      Text(LocalizedString.headlineText)
        .font(.system(size: LayoutConstant.headlineFontSize, weight: .heavy))

      Text(LocalizedString.subHeadlineText)
        .font(.system(size: LayoutConstant.subHeadlineFontSize, weight: .regular))
        .foregroundStyle(Color(.gray))
        .padding(.bottom)

      Button(
        action: {
          // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/377
          // - Create Subscription Type Selection Page in Communities.
        },
        label: {
          Spacer()
          Text(LocalizedString.upgradeButtonText)
            .underline()
            .fontWeight(.semibold)
            .foregroundStyle(Color(.white))
          Spacer()
        }
      )
      .frame(height: LayoutConstant.buttonHeight)
      .background(Color(.black))
      .clipShape(RoundedRectangle(cornerRadius: LayoutConstant.buttonCornerRadius))

      Button(
        action: {
          dismissalObserver.didTapDismissalButton?()
        },
        label: {
          Spacer()
          Text(LocalizedString.dismissButtonText)
            .underline()
            .fontWeight(.semibold)
            .foregroundStyle(Color(.black))
          Spacer()
        }
      )
      .frame(height: LayoutConstant.buttonHeight)
      .background(Color(.white))
      .clipShape(RoundedRectangle(cornerRadius: LayoutConstant.buttonCornerRadius))
      .overlay(
        RoundedRectangle(cornerRadius: LayoutConstant.buttonCornerRadius)
          .stroke(Color.gray, lineWidth: LayoutConstant.overlayLineWidth)
      )
    }
    .padding()

  }
}

#Preview {
  BottomSheetView(dismissalObserver: BlockedNewCommunityCreationBottomSheetViewObserver())
}
