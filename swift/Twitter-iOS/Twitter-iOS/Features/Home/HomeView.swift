//
//  HomeView.swift
//  Twitter-iOS
//

import SwiftUI

struct HomeView: View {
  @Binding var enableSideMenu: Bool
  @Namespace var animation
  @State var horizontalOffset = LayoutConstant.forYouOffset
  @State var selectedTabID: HomeTabViewID = .ForYou

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
    static let forYouOffset = screenWidth / 2
    static let followingOffset = -screenWidth / 2
    static let halfOffset = (forYouOffset+followingOffset) / 2
  }

  init(enableSideMenu: Binding<Bool>) {
    self._enableSideMenu = enableSideMenu
  }

  var body: some View {
    VStack {
      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/28 - Implement Following tab view skelton.

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

      HStack {
        ForEach(HomeTabViewID.allCases, id: \.self) { tabID in
          HomeTabView()
            .padding()
            .frame(width: LayoutConstant.screenWidth)
            .id(tabID)
        }
      }
      .offset(x: horizontalOffset)
      .gesture(DragGesture()
        .onChanged { value in
          withAnimation {
            guard LayoutConstant.followingOffset <= horizontalOffset && horizontalOffset <= LayoutConstant.forYouOffset else { return }
            let deltaX = value.translation.width / 5
            if deltaX <= 0 {
              horizontalOffset = max(LayoutConstant.followingOffset, horizontalOffset+deltaX)
            } else {
              horizontalOffset = min(LayoutConstant.forYouOffset, horizontalOffset+deltaX)
            }
          }
        }
        .onEnded { value in
          withAnimation {
            if horizontalOffset <= LayoutConstant.halfOffset {
              horizontalOffset = LayoutConstant.followingOffset
              selectedTabID = .Following
              enableSideMenu = false
            } else {
              horizontalOffset = LayoutConstant.forYouOffset
              selectedTabID = .ForYou
              enableSideMenu = true
            }
          }
        }
      )
    }
    .overlay(
      NewTweetEntrypointButton()
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 18, trailing: 18))
      , alignment: .bottomTrailing
    )
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
