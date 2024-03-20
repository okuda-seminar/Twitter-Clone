//
//  ContentView.swift
//  Twitter-iOS
//

import SwiftUI
import SwiftData

struct ContentView: View {
  var body: some View {
    TabView {
      HomeView().tabItem { Image(systemName: "house") }
      SearchView().tabItem { Image(systemName: "magnifyingglass") }
      CommunitiesHomeView().tabItem { Image(systemName: "person.2") }
      NotificationsView().tabItem { Image(systemName: "bell") }
      MessagesView().tabItem { Image(systemName: "envelope") }
    }
  }
}



#Preview {
  ContentView()
    .modelContainer(for: Item.self, inMemory: true)
}
