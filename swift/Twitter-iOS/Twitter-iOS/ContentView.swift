//
//  ContentView.swift
//  Twitter-iOS
//

import SwiftUI
import SwiftData

import Combine

//struct ContentView: View {
//  let detector: CurrentValueSubject<CGFloat, Never>
//  let publisher: AnyPublisher<CGFloat, Never>
//
//  init() {
//    let detector = CurrentValueSubject<CGFloat, Never>(0)
//    self.publisher = detector
//      .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
//      .dropFirst()
//      .eraseToAnyPublisher()
//    self.detector = detector
//  }
//
//  var body: some View {
//    ScrollView(.horizontal) {
//      HStack(spacing: 20) {
//        ForEach(0...100, id: \.self) { i in
//          Rectangle()
//            .frame(width: 200, height: 100)
//            .foregroundColor(.green)
//        }
//      }
//      .background(GeometryReader {
//        Color.clear.preference(key: ViewOffsetKey.self,
//                               value: -$0.frame(in: .named("scroll")).origin.x)
//      })
//      .onPreferenceChange(ViewOffsetKey.self) { detector.send($0) }
//    }
//      .coordinateSpace(name: "scroll")
//      .onReceive(publisher) {
//        print("Stopped on: \($0)")
//      }
//  }
//}
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
          .gesture(TapGesture()
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
          .gesture(TapGesture()
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
          .gesture(TapGesture()
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
          .gesture(TapGesture()
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
          .gesture(TapGesture()
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
    .frame(width: 2*LayoutConstant.screenWidth)
    .offset(x: horizontalOffset)
    .gesture(DragGesture()
      .onChanged { value in
        // temporarily disable for simplicity.
        return
        //        withAnimation {
        //          if value.translation.width > 0 && LayoutConstant.mainOffset <= horizontalOffset {
        //            horizontalOffset = LayoutConstant.mainOffset + value.translation.width
        //          } else if value.translation.width < 0 &&  horizontalOffset > LayoutConstant.mainOffset {
        //            horizontalOffset = LayoutConstant.sideBarOffset + value.translation.width
        //          }
        //        }
      }
      .onEnded { value in
        return

        //        withAnimation {
        //          if horizontalOffset >= LayoutConstant.halfOffset {
        //            horizontalOffset = LayoutConstant.sideBarOffset
        //          } else {
        //            horizontalOffset = LayoutConstant.mainOffset
        //          }
        //        }
      }
    )
  }
}

#Preview {
  ContentView()
}
