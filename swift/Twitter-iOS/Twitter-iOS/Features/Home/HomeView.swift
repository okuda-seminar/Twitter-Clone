//
//  HomeView.swift
//  Twitter-iOS
//
//  Created by 奥田遼 on 2024/03/14.
//

import SwiftUI

struct HomeView: View {
  @Namespace var animation
  @State var selectedTabID: HomeTabViewID = .ForYou

  enum HomeTabViewID {
    case ForYou
    case Following
  }

  private var screenWidth = UIScreen.main.bounds.width

  var body: some View {
    VStack {
      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/28 - Implement Following tab view skelton.
      ScrollViewReader { proxy in
        HStack {
          HomeHeaderButton(selectedTabID: $selectedTabID, animation: animation, title: "For you", tabID: .ForYou, proxy: proxy)

          HomeHeaderButton(selectedTabID: $selectedTabID, animation: animation, title: "Following", tabID: .Following, proxy: proxy)
        }

        ScrollView(.horizontal) {
          LazyHStack {
            ForYouTabView()
              .frame(width: screenWidth)
              .id(HomeTabViewID.ForYou)
            ForYouTabView()
              .frame(width: screenWidth)
              .id(HomeTabViewID.Following)
          }
        }
      }
    }
  }
}

struct HomeHeaderButton: View {
  @Binding var selectedTabID: HomeView.HomeTabViewID
  var animation: Namespace.ID
  var title: String
  var tabID: HomeView.HomeTabViewID
  var proxy: ScrollViewProxy

  private enum LayoutConstant {
    static let buttonWidth = 120.0
    static let underBarHeight = 3.0
  }

  var body: some View {
    Button(action: {
      withAnimation {
        selectedTabID = tabID
        proxy.scrollTo(tabID)
      }
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
  HomeView()
}
