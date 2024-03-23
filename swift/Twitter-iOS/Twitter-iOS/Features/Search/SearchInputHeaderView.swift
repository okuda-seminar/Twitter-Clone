//
//  SearchHeaderView.swift
//  Twitter-iOS
//

import SwiftUI

struct SearchInputHeaderView: View {
  @Binding var searchQuery: String

  var body: some View {
    HStack {
      SearchBarView(searchQuery: $searchQuery)
    }
  }
}

struct SearchBarView: View {
  @Binding var searchQuery: String
  @Environment(\.dismiss) private var dismiss
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
            isFocused = true
          }
        Spacer()
      }
      .padding()
      .background(Color(UIColor.secondarySystemBackground))
      .clipShape(Capsule())

      Button(action: {
        dismiss()
      }, label: {
        Text(String(localized: "Cancel"))
          .underline()
          .foregroundStyle(Color.primary)
      })
      .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0))
    }
    .padding()
  }
}

#Preview {
  SearchInputHeaderView(searchQuery: .constant(""))
}
