import SwiftUI
import UIKit

class SearchInputViewController: UIViewController {

  // MARK: - Private Props

  private enum LocalizedString {
    static let cancelButtonTitle = String(localized: "Cancel")
    static let title = String(localized: "Search")
  }

  private let dataSource = SearchInputDataSource()
  private let viewObserver = SearchInputViewObserver()

  private var searchQuery = ""

  private lazy var cancelButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: LocalizedString.cancelButtonTitle, style: .plain, target: self,
      action: #selector(dismissByTappingCancelButton))
    button.tintColor = .black
    return button
  }()

  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(
      rootView: SearchInputView(
        dataSource: dataSource, viewObserver: viewObserver))
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  // MARK: - View Lifecycle

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setUpNavigationAndBackground()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
    startFetchingRecentSearches()
    setUpViewObserver()
  }

  // MARK: - Private API

  private func setUpSubviews() {
    view.addSubview(hostingController.view)

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
    ])
  }

  private func setUpNavigationAndBackground() {
    view.backgroundColor = .systemBackground

    navigationItem.backButtonDisplayMode = .minimal
    navigationItem.rightBarButtonItems = [cancelButton]
    navigationItem.hidesBackButton = true
    let searchBar = UISearchBar()
    searchBar.delegate = self
    searchBar.placeholder = LocalizedString.title
    searchBar.barTintColor = .blue
    navigationItem.titleView = searchBar
  }

  private func setUpViewObserver() {
    viewObserver.didRemoveRecentlySearchQuery = { removedQuery in
      injectSearchService().removeRecentlySearchedQuery(removedQuery)
    }
  }

  private func startFetchingRecentSearches() {
    let searchService = injectSearchService()
    DispatchQueue.global(qos: .userInitiated).async {
      searchService.fetchRecentSearchedUsers { [weak self] recentlySearchedUsers in
        Task { @MainActor [weak self] in
          self?.fetchRecentSearchedUsersCompletion(recentlySearchedUsers: recentlySearchedUsers)
        }
      }

      searchService.fetchRecentSearchedQueries { [weak self] recentlySearchedQueries in
        Task { @MainActor in
          self?.fetchRecentSearchedQueriesCompletion(
            recentlySearchedQueries: recentlySearchedQueries)
        }
      }
    }
  }

  private func fetchRecentSearchedUsersCompletion(recentlySearchedUsers: [SearchedUserModel]) {
    dataSource.recentlySearchedUsers = recentlySearchedUsers
  }

  private func fetchRecentSearchedQueriesCompletion(recentlySearchedQueries: [SearchedQueryModel]) {
    dataSource.recentlySearchedQueries = recentlySearchedQueries
  }

  @objc
  private func dismissByTappingCancelButton() {
    navigationController?.popViewController(animated: true)
  }
}

extension SearchInputViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    searchQuery = searchText
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    navigationController?.pushViewController(
      SearchResultViewController(searchQuery: searchQuery), animated: true)
  }
}

struct SearchInputView: View {

  // MARK: - Public Props

  @ObservedObject var dataSource: SearchInputDataSource
  @ObservedObject var viewObserver: SearchInputViewObserver

  // MARK: - Private Props

  private enum LayoutConstant {
    static let userIconSize: CGFloat = 36.0
  }

  private enum LocalizedString {
    static let headlineText = String(localized: "Recent searches")
  }

  // MARK: - View

  var body: some View {
    VStack {
      Headline()
      RecentlySearchedUsersCatalog()
      RecentlySearchedQueriesList()
      Spacer()
    }
    .padding()
  }

  @ViewBuilder
  private func Headline() -> some View {
    HStack {
      Text(LocalizedString.headlineText)
        .bold()
      Spacer()
    }
    .padding(.bottom)
  }

  @ViewBuilder
  private func RecentlySearchedUsersCatalog() -> some View {
    ScrollView(.horizontal) {
      HStack {
        if dataSource.recentlySearchedUsers.count > 0 {
          ForEach(dataSource.recentlySearchedUsers) { searchedUserModel in
            VStack {
              if let icon = searchedUserModel.icon {
                Image(uiImage: icon)
                  .resizable()
                  .scaledToFit()
                  .frame(width: LayoutConstant.userIconSize)
                  .clipShape(Circle())
              }
              Text(searchedUserModel.name)
              Text(searchedUserModel.userName)
                .font(.caption)
            }
          }
        }
      }
    }
  }

  @ViewBuilder
  private func RecentlySearchedQueriesList() -> some View {
    VStack {
      if dataSource.recentlySearchedQueries.count > 0 {
        List {
          ForEach(dataSource.recentlySearchedQueries) { searchedQueryModel in
            Text(searchedQueryModel.text)
          }
          .onDelete(perform: { indexSet in
            viewObserver.didRemoveRecentlySearchQuery?("")
          })
        }
        .listStyle(PlainListStyle())
      }
    }
  }
}

#Preview {
  SearchInputView(
    dataSource: createFakeSearchInputDataSource(), viewObserver: SearchInputViewObserver())
}
