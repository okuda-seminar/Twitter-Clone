//
//  ContentView.swift
//  Twitter-iOS
//

import SwiftUI
import SwiftData

struct ContentView: View {
  @State var horizontalOffset = LayoutConstant.mainOffset

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
        HomeView().tabItem { Image(systemName: "house") }
        SearchView().tabItem { Image(systemName: "magnifyingglass") }
        CommunitiesHomeView().tabItem { Image(systemName: "person.2") }
        NotificationsView().tabItem { Image(systemName: "bell") }
        MessagesView().tabItem { Image(systemName: "envelope") }
      }
      .frame(width: LayoutConstant.screenWidth)
    }
    .frame(width: 2*LayoutConstant.screenWidth)
    .offset(x: horizontalOffset)
    .gesture(DragGesture()
      .onChanged { value in
        withAnimation {
          if value.translation.width > 0 && LayoutConstant.mainOffset <= horizontalOffset {
            horizontalOffset = LayoutConstant.mainOffset + value.translation.width
          } else if value.translation.width < 0 &&  horizontalOffset > LayoutConstant.mainOffset {
            horizontalOffset = LayoutConstant.sideBarOffset + value.translation.width
          }
        }
      }
      .onEnded { value in
        withAnimation {
          if horizontalOffset >= LayoutConstant.halfOffset {
            horizontalOffset = LayoutConstant.sideBarOffset
          } else {
            horizontalOffset = LayoutConstant.mainOffset
          }
        }
      }
    )
  }
}



#Preview {
  ContentView()
    .modelContainer(for: Item.self, inMemory: true)
}
