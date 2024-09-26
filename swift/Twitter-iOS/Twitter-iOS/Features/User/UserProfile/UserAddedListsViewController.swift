import SwiftUI
import UIKit

class UserAddedListsViewController: UIViewController {

  private enum LocalizedString {
    static let viewTitle = String(localized: "Lists you're on")
  }

  private lazy var hostingController: UIHostingController = {
    let hostingController = UIHostingController(rootView: UserAddedListsView())
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(hostingController)
    hostingController.didMove(toParent: self)
    return hostingController
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubViews()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setUpNavigation()
  }

  private func setUpSubViews() {
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
    view.backgroundColor = .systemBackground

    navigationItem.backButtonDisplayMode = .minimal
    navigationItem.title = LocalizedString.viewTitle

    guard let navigationController else { return }
    let backButtonImage = UIImage(systemName: "arrow.left")
    navigationController.navigationBar.backIndicatorImage = backButtonImage
    navigationController.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
    navigationController.navigationBar.tintColor = .black
    navigationController.setNavigationBarHidden(false, animated: false)
  }
}

struct UserAddedListsView: View {

  private enum LocalizedString {
    static let headlineText = String(localized: "You haven't been added to any Lists")
    static let subHeadlineText = String(
      localized: "When someone adds you to a List, it'll show up here.")
  }

  private enum LayoutConstant {
    static let headlineFontSize: CGFloat = 29.0
    static let subHeadlineFontSize: CGFloat = 16.0
    static let headlineBottomPadding: CGFloat = 6.0
  }

  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/438
  // - Enable Dynamic Updates of UserAddedListsView in UserListsPageView Based on DataSource.
  private var isUserAddedOnLists: Bool = false

  var body: some View {
    switch isUserAddedOnLists {
    case true:
      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/435
      // - Create View to Display Lists User Has Been Added to (With Data State).
      EmptyView()

    case false:
      AddedListsViewWithoutData()
    }
  }

  @ViewBuilder
  private func AddedListsViewWithoutData() -> some View {
    VStack(alignment: .leading) {
      Text(LocalizedString.headlineText)
        .font(.system(size: LayoutConstant.headlineFontSize, weight: .heavy))
        .padding(.bottom, LayoutConstant.headlineBottomPadding)

      Text(LocalizedString.subHeadlineText)
        .font(.system(size: LayoutConstant.subHeadlineFontSize))
        .foregroundStyle(.gray)

      Spacer()
    }
    .padding()
  }
}
