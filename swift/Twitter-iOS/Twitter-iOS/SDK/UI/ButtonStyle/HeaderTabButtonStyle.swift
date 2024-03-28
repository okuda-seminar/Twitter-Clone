import SwiftUI

struct HeaderTabButtonStyle: ButtonStyle {
  private enum LayoutConstant {
    static let buttonHeight = 44.0
  }

  let buttonWidth: CGFloat

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .frame(width: buttonWidth, height: LayoutConstant.buttonHeight)
      .background(Color(UIColor.systemBackground))
  }
}
