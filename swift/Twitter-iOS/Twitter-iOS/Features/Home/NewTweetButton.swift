//
//  NewTweetButton.swift
//  Twitter-iOS
//
//  Created by 奥田遼 on 2024/03/18.
//

import SwiftUI

struct NewTweetButton: View {
  @State var showSheet: Bool = false

  private enum LayoutConstant {
    static let buttonWidth = 84.0
  }

  var body: some View {
    Button(action: {
      showSheet.toggle()
    }, label: {
      Text("Post")
        .underline()
    })
    .buttonStyle(RoundedButtonStyle(buttonShape: .capsule, buttonWidth: LayoutConstant.buttonWidth))
  }
}

#Preview {
    NewTweetButton()
}
