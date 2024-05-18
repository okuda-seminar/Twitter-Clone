//
//  SearchView.swift
//  Twitter-iOS
//

import SwiftUI

struct SearchView: View {
  @Binding var enableSideMenu: Bool
  @State var showSearchHome = true

  var body: some View {
    ZStack {
      SearchHomeView(enableSideMenu: $enableSideMenu, showSearchHome: $showSearchHome)
        .animation(.default, value: showSearchHome)
        .opacity(showSearchHome ? 1.0 : 0)

      SearchInputView(showSearchHome: $showSearchHome)
        .animation(.default, value: showSearchHome)
        .opacity(showSearchHome ? 0 : 1.0)
    }
    .onChange(of: showSearchHome) {
      enableSideMenu = showSearchHome
    }
  }
}

#Preview {
  SearchView(enableSideMenu: .constant(true))
}
