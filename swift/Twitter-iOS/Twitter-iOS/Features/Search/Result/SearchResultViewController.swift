import SwiftUI
import UIKit

class SearchResultViewController: UIViewController {

  init(searchQuery: String) {
    self.searchQuery = searchQuery
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Private Props

  private var searchQuery: String

  private lazy var searchFiltersButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: self,
      action: #selector(showSearchFilters))
    button.tintColor = .black
    return button
  }()

  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(
      rootView: SearchResultView(searchQuery: searchQuery))
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
    navigationItem.rightBarButtonItems = [searchFiltersButton]
    let searchBar = UISearchBar()
    searchBar.delegate = self
    searchBar.text = searchQuery
    searchBar.barTintColor = .blue
    navigationItem.titleView = searchBar
  }

  @objc
  private func showSearchFilters() {
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/361
    // - Create Search Filters Page in Search.
  }
}

// MARK: - Delegate

extension SearchResultViewController: UISearchBarDelegate {
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    navigationController?.pushViewController(
      SearchInputViewController(), animated: true)
  }
}

struct SearchResultView: View {

  init(searchQuery: String) {
    self.searchQuery = searchQuery
  }

  // MARK: - Private Props

  private enum LayoutConstant {
    static let headlineFontSize: CGFloat = 29.0
    static let subHeadlineFontSize: CGFloat = 15.0
    static let headlineViewSpacing: CGFloat = 10.0
    static let headlineViewTopPadding: CGFloat = 50.0
  }

  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/375
  // - Create Link to Search Settings Page from "Search settings" in SearchResultView.
  private enum LocalizedString {
    static let noResultsText = String(localized: "No results for ")
    static let subHeadlineText = String(
      localized:
        """
        Try searching for something else, or check your Search settings to see if they're protecting you from sensitive content.
        """
    )
  }

  private func styledSubHeadlineText() -> AttributedString {
    var attributedText = AttributedString(LocalizedString.subHeadlineText)
    if let range = attributedText.range(of: "Search settings") {
      attributedText[range].foregroundColor = .black
      attributedText[range].underlineStyle = .single
    }
    return attributedText
  }

  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/363
  // - Create Search Output Data Source to Count and Display Searched Posts in Search.
  private let searchResultsCount = 0

  @State private var activeTab: SearchResultTabModel.Tab = .top
  @State private var tabBarToScroll: SearchResultTabModel.Tab?
  @State private var tabToScroll: SearchResultTabModel.Tab?

  private var searchQuery: String

  private var tabs: [SearchResultTabModel] = [
    .init(id: .top),
    .init(id: .latest),
    .init(id: .people),
    .init(id: .photos),
    .init(id: .videos),
  ]

  // MARK: - View

  var body: some View {
    VStack {
      TabBar()
      Tabs()
    }
  }

  @ViewBuilder
  private func TabBar() -> some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 40) {
        ForEach(tabs) { tab in
          Button(
            action: {
              withAnimation(.snappy) {
                activeTab = tab.id
                tabBarToScroll = tab.id
                tabToScroll = tab.id
              }
            },
            label: {
              Text(tab.id.rawValue)
                .foregroundStyle(activeTab == tab.id ? Color.primary : .gray)
            }
          )
          .buttonStyle(.plain)
        }
      }
      .scrollTargetLayout()
      .padding(.top)
      .padding(.bottom)
      .overlay(alignment: .bottom) {
        ZStack {
          Divider()
        }
      }
    }
    .scrollPosition(
      id: .init(
        get: {
          return tabBarToScroll
        }, set: { _ in }), anchor: .center
    )
    .safeAreaPadding(15)
  }

  @ViewBuilder
  private func Tabs() -> some View {
    GeometryReader { geoProxy in
      let size = geoProxy.size
      ScrollView(.horizontal) {
        LazyHStack(spacing: 0) {
          ForEach(tabs) { tab in
            switch tab.id {
            case .top:
              // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/363
              // - Create Each Search Result Page in Search.
              if searchResultsCount > 0 {
                // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/373
                // - Create "Top" Search Result Page with Dummy Data in Search.
              } else {
                TabViewWithoutData()
                  .frame(width: size.width)
              }
            case .latest:
              if searchResultsCount > 0 {
                // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/368
                // - Create "Latest" Search Result Page with Dummy Data in Search.
              } else {
                TabViewWithoutData()
                  .frame(width: size.width)
              }
            case .people:
              if searchResultsCount > 0 {
                // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/367
                // - Create "People" Search Result Page with Dummy Data in Search.
              } else {
                TabViewWithoutData()
                  .frame(width: size.width)
              }
            case .photos:
              if searchResultsCount > 0 {
                // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/371
                // - Create "Photos" Search Result Page with Dummy Data in Search.
              } else {
                TabViewWithoutData()
                  .frame(width: size.width)
              }
            case .videos:
              if searchResultsCount > 0 {
                // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/372
                // - Create "Videos" Search Result Page with Dummy Data in Search
              } else {
                TabViewWithoutData()
                  .frame(width: size.width)
              }
            }
          }
        }
        .scrollTargetLayout()
      }
      .scrollIndicators(.hidden)
      .scrollTargetBehavior(.paging)
      .scrollPosition(id: $tabToScroll)
      .onChange(of: tabToScroll) { _, newValue in
        if let newValue {
          withAnimation {
            activeTab = newValue
            tabBarToScroll = newValue
            tabToScroll = newValue
          }
        }
      }
    }
  }

  @ViewBuilder
  private func TabViewWithoutData() -> some View {
    VStack(alignment: .leading, spacing: LayoutConstant.headlineViewSpacing) {
      Text(LocalizedString.noResultsText + searchQuery)
        .font(.system(size: LayoutConstant.headlineFontSize, weight: .heavy))

      Text(styledSubHeadlineText())
        .font(.system(size: LayoutConstant.subHeadlineFontSize))
        .foregroundStyle(.gray)

      Spacer()
    }
    .padding(.top, LayoutConstant.headlineViewTopPadding)
    .padding(.horizontal)
  }
}

#Preview {
  SearchResultView(searchQuery: "Twitter")
}
