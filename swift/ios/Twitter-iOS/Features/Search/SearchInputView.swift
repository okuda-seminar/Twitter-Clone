//
//  SearchInputView.swift
//  Twitter-iOS
//

import SwiftUI

struct SearchInputView: View {
  @Binding var showSearchHome: Bool
  @State var searchQuery: String = ""

  var body: some View {
    VStack {
      SearchInputHeaderView(searchQuery: $searchQuery, showSearchHome: $showSearchHome)
      HStack {
        Text(String(localized: "Recent searches"))
          .font(.headline)

        Spacer()
        
        Button(action: {
        }, label: {
          Image(systemName: "multiply")
            .foregroundStyle(Color.primary)
        })
      }
      .padding()

      Spacer()
    }
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/61 - Dismiss keyboard when swipe up / down gesture happens in SearchInputView.
  }
}

#Preview {
  SearchInputView(showSearchHome: .constant(false))
}
