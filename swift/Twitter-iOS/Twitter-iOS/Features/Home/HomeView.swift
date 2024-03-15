//
//  HomeView.swift
//  Twitter-iOS
//
//  Created by 奥田遼 on 2024/03/14.
//

import SwiftUI

struct HomeView: View {
  @Namespace var animation
  @State var currentTab = "For you"

  var body: some View {
    VStack {
      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/27 - Enable header tab buttons in Home to switch corresponding views.
      HStack {
        HomeHeaderButton(currentTab: $currentTab, animation: animation, title: "For you")

        HomeHeaderButton(currentTab: $currentTab, animation: animation, title: "Following")
      }
      ForYouTabView()
    }
  }
}

struct HomeHeaderButton: View {
  @Binding var currentTab: String
  var animation: Namespace.ID
  var title: String

  private enum LayoutConstant {
    static let buttonWidth = 120.0
    static let underBarHeight = 3.0
  }

  var body: some View {
    Button(action: {
      withAnimation {
        currentTab = title
      }
    }, label: {
      VStack {
        Text(title)
          .font(.headline)
          .foregroundStyle(.primary)

        if currentTab == title {
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
