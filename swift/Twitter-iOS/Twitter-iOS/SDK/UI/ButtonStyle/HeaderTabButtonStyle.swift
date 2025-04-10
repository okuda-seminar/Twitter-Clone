import SwiftUI

struct HeaderTabButtonStyle: ButtonStyle {

  let buttonWidth: CGFloat

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .frame(width: buttonWidth, height: 44.0)
      .background(Color(UIColor.systemBackground))
  }
}
