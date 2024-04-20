//
//  ContentView.swift
//  Twitter-iOS
//

import SwiftUI

struct ContentView: View {
  @State var horizontalOffset = LayoutConstant.mainOffset
  @State var enableSideMenu = true

  private enum LayoutConstant {
    static let screenWidth = UIScreen.main.bounds.width

    static let sideBarOffset = screenWidth / 2 - 90
    static let mainOffset = -screenWidth / 2
    static let halfOffset = (sideBarOffset + mainOffset) / 2
  }

  var body: some View {
    HStack {
      Text("Hi")
        .frame(width: LayoutConstant.screenWidth)

      TabView {
        // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/67 - Disable swipe gesture of tab views when side menu is showing up.
        // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/68 - Refactor how to initialize TabView.
        HomeView(enableSideMenu: $enableSideMenu)
          .tabItem { Image(systemName: "house") }
          .gesture(
            TapGesture()
              .onEnded {
                withAnimation {
                  if horizontalOffset == LayoutConstant.sideBarOffset {
                    horizontalOffset = LayoutConstant.mainOffset
                  }
                }
              }
          )
        SearchView(enableSideMenu: $enableSideMenu)
          .tabItem { Image(systemName: "magnifyingglass") }
          .gesture(
            TapGesture()
              .onEnded {
                withAnimation {
                  if horizontalOffset == LayoutConstant.sideBarOffset {
                    horizontalOffset = LayoutConstant.mainOffset
                  }
                }
              }
          )
        CommunitiesHomeView(enableSideMenu: $enableSideMenu)
          .tabItem { Image(systemName: "person.2") }
          .gesture(
            TapGesture()
              .onEnded {
                withAnimation {
                  if horizontalOffset == LayoutConstant.sideBarOffset {
                    horizontalOffset = LayoutConstant.mainOffset
                  }
                }
              }
          )
        NotificationsView(enableSideMenu: $enableSideMenu)
          .tabItem { Image(systemName: "bell") }
          .gesture(
            TapGesture()
              .onEnded {
                withAnimation {
                  if horizontalOffset == LayoutConstant.sideBarOffset {
                    horizontalOffset = LayoutConstant.mainOffset
                  }
                }
              }
          )
        MessagesView(enableSideMenu: $enableSideMenu)
          .tabItem { Image(systemName: "envelope") }
          .gesture(
            TapGesture()
              .onEnded {
                withAnimation {
                  if horizontalOffset == LayoutConstant.sideBarOffset {
                    horizontalOffset = LayoutConstant.mainOffset
                  }
                }
              }
          )
      }
      .frame(width: LayoutConstant.screenWidth)
    }
    .frame(width: 2 * LayoutConstant.screenWidth)
    .offset(x: horizontalOffset)
    .gesture(
      DragGesture()
        .onChanged { value in
          return
        }
        .onEnded { value in
          return
        }
    )
  }
}

#Preview{
  ContentView()
}
