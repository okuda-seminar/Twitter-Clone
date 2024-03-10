//
//  NewActionButton.swift
//  Twitter-iOS
//
//  Created by 奥田遼 on 2024/03/09.
//

import SwiftUI

struct NewActionButton: View {
  var body: some View {
    Button(action: {
      print("New Tweet")
    }, label: {
      Image(systemName: "plus")
    })
    .buttonStyle(RoundedButtonStyle())
  }
}

struct RoundedButtonStyle: ButtonStyle {
  private enum LayoutConstant {
    static let buttonSize = 44.0
  }

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .frame(width: LayoutConstant.buttonSize, height: LayoutConstant.buttonSize)
      .foregroundColor(.white)
      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/22 - Add Twitter branded blue color.
      .background(.blue)
      .clipShape(Circle())
  }
}

#Preview {
  NewActionButton()
}
