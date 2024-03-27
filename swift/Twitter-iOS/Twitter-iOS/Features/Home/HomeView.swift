//
//  HomeView.swift
//  Twitter-iOS
//

import Combine
import SwiftUI

struct HomeView: View {
  @Binding var enableSideMenu: Bool
  @GestureState var isDragging = false
  @Namespace var animation
  @State var selectedTabID: HomeTabViewID = .ForYou

  let detector: CurrentValueSubject<CGFloat, Never>
  let publisher: AnyPublisher<CGFloat, Never>

  enum HomeTabViewID {
    static var allCases: [HomeTabViewID] {
      return [.ForYou, .Following]
    }
    case ForYou
    case Following
  }

  private func homeTabTitle(for tabID: HomeTabViewID) -> String {
    switch tabID {
    case .ForYou:
      return "For you"
    case .Following:
      return "Following"
    }
  }

  private enum LayoutConstant {
    static let screenWidth = UIScreen.main.bounds.width
    static let forYouOffset = 0.0
    static let followingOffset = screenWidth
    static let halfOffset = (forYouOffset+followingOffset) / 2
  }

  init(enableSideMenu: Binding<Bool>) {
    self._enableSideMenu = enableSideMenu
    self.detector = CurrentValueSubject<CGFloat, Never>(0)
    self.publisher = self.detector
      .debounce(for: .seconds(0.1), scheduler: DispatchQueue.main)
      .dropFirst()
      .eraseToAnyPublisher()
  }

  var body: some View {
    ScrollViewReader { proxy in
      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/28 - Implement Following tab view skelton.
      HStack {
        HStack {
          Spacer()
          ForEach(HomeTabViewID.allCases, id: \.self) { tabID in
            HomeHeaderButton(
              enableSideMenu: $enableSideMenu,
              selectedTabID: $selectedTabID,
              animation: animation,
              title: homeTabTitle(for: tabID),
              tabID: tabID)
            Spacer()
          }
        }
      }

      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/71 - Use ViewController instead of ScrollView with pub/sub to detect scroll has finished.
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(HomeTabViewID.allCases, id: \.self) { tabID in
            HomeTabView()
              .padding()
              .frame(width: LayoutConstant.screenWidth)
              .id(tabID)
          }
        }
        .background(GeometryReader {
          Color.clear.preference(
              key: ViewOffsetKey.self,
            value: -$0.frame(in: .named("scroll")).origin.x)
        })
        .onPreferenceChange(ViewOffsetKey.self) {
          detector.send($0)
        }
      }
      .coordinateSpace(name: "scroll")
      .onReceive(publisher) { xOffset in
        if xOffset < LayoutConstant.halfOffset {
          withAnimation {
            proxy.scrollTo(HomeTabViewID.ForYou)
            selectedTabID = .ForYou
          }
        } else {
          withAnimation {
            proxy.scrollTo(HomeTabViewID.Following)
            selectedTabID = .Following
          }
        }
      }
      .overlay(
        NewTweetEntrypointButton()
          .padding(EdgeInsets(top: 0, leading: 0, bottom: 18, trailing: 18))
        , alignment: .bottomTrailing
      )
    }

  }
}

struct HomeHeaderButton: View {
  @Binding var enableSideMenu: Bool
  @Binding var selectedTabID: HomeView.HomeTabViewID
  var animation: Namespace.ID
  var title: String
  var tabID: HomeView.HomeTabViewID

  private enum LayoutConstant {
    static let buttonWidth = 80.0
    static let underBarHeight = 3.0
  }

  var body: some View {
    Button(action: {
      withAnimation {
        selectedTabID = tabID
      }
      enableSideMenu = tabID == HomeView.HomeTabViewID.ForYou
    }, label: {
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
    })
    .buttonStyle(HeaderTabButtonStyle(buttonWidth: LayoutConstant.buttonWidth))
  }
}

#Preview {
  HomeView(enableSideMenu: .constant(true))
}
