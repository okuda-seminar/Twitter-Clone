//
//  SearchInputView.swift
//  Twitter-iOS
//

import SwiftUI

struct SearchInputView: View {
  @State var searchQuery: String = ""
  var body: some View {
    VStack {
      SearchInputHeaderView(searchQuery: $searchQuery)
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
    }
  }
}

#Preview {
  SearchInputView()
}
