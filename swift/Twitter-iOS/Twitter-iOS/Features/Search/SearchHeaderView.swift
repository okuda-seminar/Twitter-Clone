//
//  SearchHeaderView.swift
//  Twitter-iOS
//

import SwiftUI

struct SearchHeaderView: View {
  @State var showSheet: Bool = false

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

      Button(action: {
        showSheet.toggle()
      }, label: {
        Image(systemName: "gear")
          .resizable()
          .scaledToFit()
          .frame(width: LayoutConstant.gearImageSize, height: LayoutConstant.gearImageSize)
          .foregroundStyle(Color.primary)
      })
    }
    .padding()
    .fullScreenCover(isPresented: $showSheet) {
      SearchSettingsView()
    }
  }
}

#Preview {
  SearchHeaderView()
}
