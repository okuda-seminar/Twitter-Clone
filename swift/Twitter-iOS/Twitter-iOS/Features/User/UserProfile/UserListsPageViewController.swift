import SwiftUI

class UserListsPageViewController: UIViewController {

  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/424
  // - Create EntryPointButton to Create New Lists,
  // - and Enable Animation Corresponding to Switch between New EntryPointButton and NewPostEntryPointButton.

  private enum LocalizedString {
    static let searchBarPlaceholderText = String(localized: "Search Lists")
    static let listMenuActionText = String(localized: "List's you're on")
  }

  private lazy var menuButton: UIBarButtonItem = {
    let button = UIBarButtonItem()
    button.tintColor = .black
    button.image = UIImage(systemName: "ellipsis")

    let action = UIAction(title: LocalizedString.listMenuActionText) { [weak self] _ in
      self?.navigationController?.pushViewController(UserAddedListsViewController(), animated: true)
    }

    button.menu = UIMenu(children: [action])
    return button
  }()

  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(rootView: UserListsPageView())
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setUpNavigationAndBackground()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpNavigationAndBackground() {
    view.backgroundColor = .systemBackground

    let searchBar = UISearchBar()
    searchBar.placeholder = LocalizedString.searchBarPlaceholderText
    searchBar.delegate = self
    searchBar.barTintColor = .blue
    navigationItem.titleView = searchBar
    navigationItem.rightBarButtonItems = [menuButton]
    navigationItem.backButtonDisplayMode = .minimal
    navigationController?.navigationBar.backgroundColor = .systemBackground
  }

  private func setUpSubviews() {
    view.addSubview(hostingController.view)

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
}

extension UserListsPageViewController: UISearchBarDelegate {
  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/420
  // - Create View to Search Existing Lists.
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    navigationController?.pushViewController(
      UIHostingController(rootView: EmptyView()), animated: true)
  }
}

struct UserListsPageView: View {

  private enum LocalizedString {
    static let titleText = String(localized: "Discover new Lists")
    static let headlineText = String(localized: "Your Lists")
    static let subHeadlineText = String(
      localized: "You haven't created or followed any Lists. When you do, they'll show up here.")
    static let followButtonText = String(localized: "Follow")
    static let showMoreButtonText = String(localized: "Show more")
    static let membersText = String(localized: "members")
    static let followersText = String(localized: "followers including")
  }

  private enum LayoutConstant {
    static let titleFontSize: CGFloat = 20.0
    static let imageSize: CGFloat = 50.0
    static let imageCornerRadius: CGFloat = 10.0
    static let headlineFontSize: CGFloat = 20.0
    static let subHeadlineFontSize: CGFloat = 15.0
    static let headlineButtomPadding: CGFloat = 25.0
    static let followButtonHeight: CGFloat = 30.0
    static let followButtonCornerRadius: CGFloat = 15.0
  }

  var body: some View {
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/425
    // - Enhance Scrolling Performance and UX in UserListsPageViewController.swift.
    ScrollView {
      VStack {
        newLists()
        Divider()
        ListsWithoutData()
      }
    }
  }

  @ViewBuilder
  private func newLists() -> some View {
    VStack(alignment: .leading) {
      Text(LocalizedString.titleText)
        .font(.system(size: LayoutConstant.titleFontSize, weight: .heavy))

      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/421
      // - Set Up DataSource for UserListsPageViewController.swift.
      newListCell(
        profileImage: UIImage(systemName: "note.text.badge.plus")!, listName: "fakeName1",
        numOfMembers: 10, numOfFollowers: 100)
      newListCell(
        profileImage: UIImage(systemName: "note.text.badge.plus")!, listName: "fakeName2",
        numOfMembers: 20, numOfFollowers: 99)
      newListCell(
        profileImage: UIImage(systemName: "note.text.badge.plus")!, listName: "fakeName3",
        numOfMembers: 30, numOfFollowers: 81)

      HStack {
        Text(LocalizedString.showMoreButtonText)
          .foregroundStyle(.blue)

        Spacer()

        Image(uiImage: UIImage(systemName: "chevron.forward")!)
      }
      /// to enable this HStack to react even if users tap on a blank area
      .background(.clear)
      .contentShape(Rectangle())
      .onTapGesture {
        // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/422
        // - Enable Transition to Suggested Lists Page from UserListsPage.
      }
      .padding(.vertical)

    }
    .padding(.horizontal)
  }

  @ViewBuilder
  private func newListCell(
    profileImage: UIImage, listName: String, numOfMembers: Int, numOfFollowers: Int
  ) -> some View {
    HStack(alignment: .top) {
      Image(uiImage: profileImage)
        .frame(width: LayoutConstant.imageSize, height: LayoutConstant.imageSize)
        .background(.gray)
        .clipShape(RoundedRectangle(cornerRadius: LayoutConstant.imageCornerRadius))

      Spacer()

      VStack(alignment: .leading) {
        HStack {
          Text(listName)
            .fontWeight(.bold)

          Text("\(numOfMembers) \(LocalizedString.membersText)")
            .foregroundStyle(.gray)
        }

        HStack {
          Image(systemName: "person.circle")
            .clipShape(Circle())

          Text("\(numOfFollowers) \(LocalizedString.followersText)")
        }
      }

      Spacer()

      Button {
        // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/423
        // - Add Follow Functionality to Follow Button in UserListsPageView.
      } label: {
        Text(LocalizedString.followButtonText)
          .foregroundStyle(.white)
          .padding()
      }
      .background(.black)
      .frame(height: LayoutConstant.followButtonHeight)
      .clipShape(RoundedRectangle(cornerRadius: LayoutConstant.followButtonCornerRadius))
    }
  }

  @ViewBuilder
  private func ListsWithoutData() -> some View {
    VStack(alignment: .leading) {
      Text(LocalizedString.headlineText)
        .font(.system(size: LayoutConstant.headlineFontSize, weight: .heavy))
        .padding(.bottom, LayoutConstant.headlineButtomPadding)

      Text(LocalizedString.subHeadlineText)
        .font(.system(size: LayoutConstant.subHeadlineFontSize))
        .foregroundStyle(.gray)

      Spacer()
    }
    .padding(.horizontal)

  }
}

#Preview {
  UserListsPageView()
}
