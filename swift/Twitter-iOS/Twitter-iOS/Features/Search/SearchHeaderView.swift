//
//  SearchHeaderView.swift
//  Twitter-iOS
//

import SwiftUI

struct SearchHeaderView: View {
  private enum LayoutConstant {
    static let gearImageSize = 28.0
  }
  var body: some View {
    HStack {
      Button(action: {

      }, label: {
        HStack {
          Spacer()
          Image(systemName: "magnifyingglass")
          Text(String(localized: "Search"))
          Spacer()
        }
      })
      .padding()
      .foregroundStyle(Color.gray)
      .background(Color(UIColor.secondarySystemBackground))
      .clipShape(Capsule())

      Image(systemName: "gear")
        .resizable()
        .scaledToFit()
        .frame(width: LayoutConstant.gearImageSize, height: LayoutConstant.gearImageSize)
    }
    .padding()
  }
}

#Preview {
  SearchHeaderView()
}
