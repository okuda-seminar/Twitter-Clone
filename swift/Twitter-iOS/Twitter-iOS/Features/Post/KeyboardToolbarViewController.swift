import SwiftUI
import UIKit

class KeyboardToolbarViewController: UIViewController {

  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(rootView: KeyboardToolBarView())
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    view.addSubview(hostingController.view)

    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
  }
}

struct KeyboardToolBarView: View {
  @State var currentUser = InjectCurrentUser()

  private enum LayoutConstant {
    static let protectedIconSize: CGFloat = 28.0
    static let protectedIconPadding: CGFloat = 8.0
  }

  private enum LocalizedString {
    static let warningForProtectedAccount = String(
      localized: "They can't see your Protected reply.")
    static let learnMore = String(localized: "Learn more")
  }

  var body: some View {
    GeometryReader { geoProxy in
      if currentUser.isPrivateAccount {
        VStack {
          HStack(alignment: .top) {
            Image(systemName: "lock.fill")
              .resizable()
              .scaledToFit()
              .frame(
                width: LayoutConstant.protectedIconSize, height: LayoutConstant.protectedIconSize
              )
              .foregroundStyle(.white)
              .padding(LayoutConstant.protectedIconPadding)
              .background(Color(uiColor: .brandedBlue))
              .clipShape(Circle())

            VStack(alignment: .leading) {
              Text(LocalizedString.warningForProtectedAccount)
              Text(LocalizedString.learnMore)
                .underline()
            }
            Spacer()
          }
          .padding()
        }
        .background(Color(uiColor: .brandedLightBlueBackground))
        .frame(width: geoProxy.size.width, height: geoProxy.size.height)
      }
    }
  }
}

#Preview {
  KeyboardToolBarView()
}
