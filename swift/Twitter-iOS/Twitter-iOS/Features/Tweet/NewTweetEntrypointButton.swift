//
//  NewTweetEntrypointButton.swift
//  Twitter-iOS
//

import SwiftUI

struct NewTweetEntrypointButton: View {
  @State var showSheet: Bool = false

  private enum LayoutConstant {
    static let buttonSize = 44.0
  }

  var body: some View {
    Button(action: {
      showSheet.toggle()
    }, label: {
      Image(systemName: "plus")
        .frame(width: LayoutConstant.buttonSize, height: LayoutConstant.buttonSize)
    })
    .clipShape(Circle())
    .buttonStyle(RoundedButtonStyle())
    .fullScreenCover(isPresented: $showSheet) {
      NewTweetEditView()
    }
  }
}

#Preview {
    NewTweetEntrypointButton()
}
