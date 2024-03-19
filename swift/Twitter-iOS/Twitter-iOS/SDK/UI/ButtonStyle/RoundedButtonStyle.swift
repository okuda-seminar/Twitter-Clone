//
//  NewActionButton.swift
//  Twitter-iOS
//
//  Created by 奥田遼 on 2024/03/09.
//

import SwiftUI

struct RoundedButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .foregroundColor(.white)
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/22 - Add Twitter branded blue color.
      .background(.blue)
  }
}
