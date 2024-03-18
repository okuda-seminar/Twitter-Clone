//
//  NewTweetEntrypointButton.swift
//  Twitter-iOS
//

import SwiftUI

struct NewTweetEntrypointButton: View {
  @State var showSheet: Bool = false

  private enum LayoutConstant {
    static let buttonWidth = 44.0
  }

  var body: some View {
    Button(action: {
      showSheet.toggle()
    }, label: {
      Image(systemName: "plus")
    })
    .buttonStyle(RoundedButtonStyle(buttonShape: .circle, buttonWidth: LayoutConstant.buttonWidth))
    .fullScreenCover(isPresented: $showSheet) {
      NewTweetEditView()
    }
  }
}

#Preview {
    NewTweetEntrypointButton()
}
