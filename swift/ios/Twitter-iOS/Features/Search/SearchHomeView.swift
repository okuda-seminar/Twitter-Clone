//
//  SearchView.swift
//  Twitter-iOS
//

import SwiftUI

struct SearchHomeView: View {
  @Binding var enableSideMenu: Bool
  @Binding var showSearchHome: Bool
  @Namespace var animation
  @State var selectedTabID: SearchTabViewID = .ForYou

  enum SearchTabViewID {
    static var allCases: [SearchTabViewID] {
      return [.ForYou, .Trending, .News, .Sports, .Entertainment]
    }

    case ForYou
    case Trending
    case News
    case Sports
    case Entertainment
  }

  private func searchTabTitle(for tabID: SearchTabViewID) -> String {
    switch tabID {
    case .ForYou:
      return String(localized: "For you")
    case .Trending:
      return String(localized: "Trending")
    case .News:
      return String(localized: "News")
    case .Sports:
      return String(localized: "Sports")
    case .Entertainment:
      return String(localized: "Entertainment")
    }
  }

  private var screenWidth = UIScreen.main.bounds.width

  init(enableSideMenu: Binding<Bool>, showSearchHome: Binding<Bool>) {
    self._enableSideMenu = enableSideMenu
    self._showSearchHome = showSearchHome
  }

  var body: some View {
    VStack {
      SearchHeaderView(showSearchHome: $showSearchHome)
      ScrollViewReader { proxy in
        ScrollView(.horizontal, showsIndicators: false) {
          HStack {
            // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/31 - Polish Search UI.
            // We cannot use ForEarch here. Probably Apple's bug.
            SearchHeaderButton(
              selectedTabID: $selectedTabID,
              animation: animation,
              title: searchTabTitle(for: .ForYou),
              tabID: .ForYou,
              proxy: proxy)
            SearchHeaderButton(
              selectedTabID: $selectedTabID,
              animation: animation,
              title: searchTabTitle(for: .Trending),
              tabID: .Trending,
              proxy: proxy)
            SearchHeaderButton(
              selectedTabID: $selectedTabID,
              animation: animation,
              title: searchTabTitle(for: .News),
              tabID: .News,
              proxy: proxy)
            SearchHeaderButton(
              selectedTabID: $selectedTabID,
              animation: animation,
              title: searchTabTitle(for: .Sports),
              tabID: .Sports,
              proxy: proxy)
            SearchHeaderButton(
              selectedTabID: $selectedTabID,
              animation: animation,
              title: searchTabTitle(for: .Entertainment),
              tabID: .Entertainment,
              proxy: proxy)
          }
        }

        ScrollView(.horizontal) {
          LazyHStack {
            ForEach(SearchTabViewID.allCases, id: \.self) { tabID in
              SearchTabView()
                .frame(width: screenWidth)
                .id(tabID)
                .onAppear {
                  enableSideMenu = tabID == SearchTabViewID.ForYou
                }
            }
          }
        }
      }
    }
    .overlay(
      NewTweetEntrypointButton()
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 18, trailing: 18)),
      alignment: .bottomTrailing
    )
  }
}

struct SearchHeaderButton: View {
  @Binding var selectedTabID: SearchHomeView.SearchTabViewID
  var animation: Namespace.ID
  var title: String
  var tabID: SearchHomeView.SearchTabViewID
  var proxy: ScrollViewProxy

  private enum LayoutConstant {
    static let buttonWidth = 80.0
    static let underBarHeight = 3.0
  }

  var body: some View {
    Button(
      action: {
        withAnimation {
          selectedTabID = tabID
          proxy.scrollTo(tabID)
        }
      },
      label: {
        VStack {
          Text(title)
            .font(.headline)
            .foregroundStyle(.primary)

          if selectedTabID == tabID {
            Capsule()
              .fill(Color.blue)
              .frame(height: LayoutConstant.underBarHeight)
              .matchedGeometryEffect(id: "TAB", in: animation)
          } else {
            Capsule()
              .fill(Color.clear)
              .frame(height: LayoutConstant.underBarHeight)
          }
        }
      }
    )
    .buttonStyle(HeaderTabButtonStyle(buttonWidth: LayoutConstant.buttonWidth))
  }
}

#Preview {
  SearchHomeView(enableSideMenu: .constant(true), showSearchHome: .constant(true))
}
