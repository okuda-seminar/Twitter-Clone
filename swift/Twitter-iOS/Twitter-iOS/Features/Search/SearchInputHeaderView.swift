//
//  SearchHeaderView.swift
//  Twitter-iOS
//

import SwiftUI

struct SearchInputHeaderView: View {
  @Binding var searchQuery: String
  @Binding var showSearchHome: Bool

  var body: some View {
    HStack {
      SearchBarView(searchQuery: $searchQuery, showSearchHome: $showSearchHome)
    }
  }
}

struct SearchBarView: View {
  @Binding var searchQuery: String
  @Binding var showSearchHome: Bool
  @FocusState private var isFocused: Bool
  @State var editing: Bool = false

  var body: some View {
    HStack {
      HStack {
        Spacer()
        Image(systemName: "magnifyingglass")
          .foregroundStyle(Color.gray)
          .animation(.default, value: editing)
        TextField(String(localized: "Search"), text: $searchQuery)
          .foregroundStyle(Color.primary)
          .animation(.default, value: editing)
          .focused($isFocused)
          .onAppear {
            isFocused = !showSearchHome
          }
          .onDisappear {
            isFocused = false
          }
        Spacer()
      }
      .padding()
      .background(Color(UIColor.secondarySystemBackground))
      .clipShape(Capsule())

      Text(String(localized: "Cancel"))
        .underline()
        .foregroundStyle(Color.primary)
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0))
        .onTapGesture {
          showSearchHome = true
          isFocused = false
        }
    }
    .padding()
    .onChange(of: showSearchHome) {
      isFocused = !showSearchHome
    }
  }
}

#Preview {
  SearchInputHeaderView(searchQuery: .constant(""), showSearchHome: .constant(false))
}
