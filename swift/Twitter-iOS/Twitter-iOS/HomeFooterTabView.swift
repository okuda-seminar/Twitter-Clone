//
//  HomeFooterTabView.swift
//  Twitter-iOS
//
//  Created by 奥田遼 on 2024/03/09.
//

import SwiftUI

struct HomeFooterTabView: View {
  var body: some View {
    TabView {
      HomeView().tabItem { Image(systemName: "house") }
      Text("Search").tabItem { Image(systemName: "magnifyingglass") }
      Text("Communities").tabItem { Image(systemName: "person.2") }
      Text("Notifications").tabItem { Image(systemName: "bell") }
      Text("Messages").tabItem { Image(systemName: "envelope") }
    }
  }
}

#Preview {
  HomeFooterTabView()
}
