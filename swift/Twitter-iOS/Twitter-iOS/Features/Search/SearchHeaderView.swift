//
//  SearchHeaderView.swift
//  Twitter-iOS
//

import SwiftUI

struct SearchHeaderView: View {
  @Binding var showSearchHome: Bool
  @State var showSheet: Bool = false

  private enum LayoutConstant {
    static let gearImageSize = 28.0
  }

  var body: some View {
    HStack {
      HStack {
        Spacer()
        Image(systemName: "magnifyingglass")
        Text(String(localized: "Search"))
        Spacer()
      }
      .padding()
      .foregroundStyle(Color.gray)
      .background(Color(UIColor.secondarySystemBackground))
      .clipShape(Capsule())
      .onTapGesture {
        showSearchHome = false
      }

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
  SearchHeaderView(showSearchHome: .constant(false))
}
