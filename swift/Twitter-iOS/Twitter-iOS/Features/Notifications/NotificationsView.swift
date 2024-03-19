//
//  NotificationsView.swift
//  Twitter-iOS
//
//  Created by 奥田遼 on 2024/03/16.
//

import SwiftUI

struct NotificationsView: View {
  @Namespace var animation
  @State var selectedTabID: NotificationsTabViewID = .All
  private var screenWidth = UIScreen.main.bounds.width

  enum NotificationsTabViewID {
    static var allCases: [NotificationsTabViewID] {
      return [.All, .Verified, .Mentions]
    }
    case All
    case Verified
    case Mentions
  }

  private func NotificationsTabTitle(for tabID: NotificationsTabViewID) -> String {
    switch tabID {
    case .All:
      return String(localized: "All")
    case .Verified:
      return String(localized: "Verified")
    case .Mentions:
      return String(localized: "Mentions")
    }
  }



  var body: some View {
    VStack {
      ScrollViewReader { proxy in
        HStack {
          Spacer()
          ForEach(NotificationsTabViewID.allCases, id: \.self) { tabID in
            NotificationsHeaderButton(
              selectedTabID: $selectedTabID,
              animation: animation,
              title: NotificationsTabTitle(for: tabID),
              tabID: tabID,
              proxy: proxy)
            Spacer()
          }
        }

        ScrollView(.horizontal) {
          LazyHStack {
            ForEach(NotificationsTabViewID.allCases, id: \.self) { tabID in
              NotificationsTabView()
                .frame(width: screenWidth)
                .id(tabID)
            }
          }
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

struct NotificationsHeaderButton: View {
  @Binding var selectedTabID: NotificationsView.NotificationsTabViewID
  var animation: Namespace.ID
  var title: String
  var tabID: NotificationsView.NotificationsTabViewID
  var proxy: ScrollViewProxy

  private enum LayoutConstant {
    static let buttonWidth = 80.0
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
  NotificationsView()
}
