//
//  NewActionButton.swift
//  Twitter-iOS
//
//  Created by 奥田遼 on 2024/03/09.
//

import SwiftUI

enum RoundedButtonClipShape {
  case circle
  case capsule
}


struct RoundedButtonStyle: ButtonStyle {
  var buttonShape: RoundedButtonClipShape
  var buttonWidth: CGFloat

  private enum LayoutConstant {
    static let buttonHeight = 44.0
  }

  func makeBody(configuration: Configuration) -> some View {
    switch buttonShape {
    case .circle:
      makeCircleBody(configuration: configuration)
    case .capsule:
      makeCapsuleBody(configuration: configuration)
    }
  }

  func makeCircleBody(configuration: Configuration) -> some View {
    configuration.label
      .frame(width: buttonWidth, height: LayoutConstant.buttonHeight)
      .foregroundColor(.white)
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/22 - Add Twitter branded blue color.
      .background(.blue)
      .clipShape(Circle())
  }

  func makeCapsuleBody(configuration: Configuration) -> some View {
    configuration.label
      .frame(width: buttonWidth, height: LayoutConstant.buttonHeight)
      .foregroundColor(.white)
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/22 - Add Twitter branded blue color.
      .background(.blue)
      .clipShape(Capsule())
  }
}
