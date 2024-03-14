//
//  HomeView.swift
//  Twitter-iOS
//
//  Created by 奥田遼 on 2024/03/14.
//

import SwiftUI

struct HomeView: View {
  private var headerButtonWidth = UIScreen.main.bounds.width / 2

  var body: some View {
    VStack {
      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/27 - Enable header tab buttons in Home to switch corresponding views.
      HStack {
        Button(action: {}, label: {
          Text("For you")
            .font(.headline)
            .foregroundStyle(.primary)
        })
        .buttonStyle(HeaderTabButtonStyle(buttonWidth: headerButtonWidth))
        Button(action: {}, label: {
          Text("Following")
            .font(.headline)
            .foregroundStyle(.primary)
        })
        .buttonStyle(HeaderTabButtonStyle(buttonWidth: headerButtonWidth))
      }
      ForYouTabView()
    }
  }
}

#Preview {
  HomeView()
}
